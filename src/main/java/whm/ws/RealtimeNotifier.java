package whm.ws;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Server-side entry point for realtime notifications.
 *
 * <p>Servlets call the {@code notify*} methods after a mutation that other
 * users should see without an F5. Notifications are best-effort: when nobody
 * is listening the event is dropped (the next page load reads fresh data).</p>
 *
 * <p>Two kinds of channels exist:</p>
 * <ul>
 *   <li>{@code receipt-N} / {@code issue-N} — per-order, the staff member
 *       watching that detail page.</li>
 *   <li>{@code broadcast} — global refresh for every open page.</li>
 * </ul>
 */
public final class RealtimeNotifier {

    private RealtimeNotifier() {
    }

    /** Orders approved while their detail page was closed — pushed on next subscribe. */
    private static final Map<String, Boolean> APPROVED = new ConcurrentHashMap<>();

    private static String channel(String type, int id) {
        return type + "-" + id;
    }

    // ---- approval (per-order channel) -------------------------------------

    /** True when the order was approved while its page had no listener. */
    public static boolean isApproved(String type, int id) {
        return Boolean.TRUE.equals(APPROVED.get(channel(type, id)));
    }

    /** True when someone is currently connected to {@code type}-{@code id}. */
    public static boolean hasListener(String type, int id) {
        return WsHub.hasSubscriber(channel(type, id));
    }

    /**
     * The manager approved a receipt/issue: tell the staff member watching that
     * order ({@code receipt-N}/{@code issue-N}) AND every open page (broadcast,
     * so the dashboard pending-count and lists refresh).
     */
    public static void notifyApproved(String type, int id, String approvedByName) {
        String ch = channel(type, id);
        String json = "{\"" + type + "Id\":" + id + ",\"approvedBy\":\"" + escape(approvedByName) + "\"}";
        boolean delivered = WsHub.publish(ch, "event: approved\ndata: " + json + "\n\n");
        // If nobody was watching this order, remember it so the next viewer
        // learns immediately on connect. Either way, everyone refreshes.
        if (!delivered)
            APPROVED.put(ch, Boolean.TRUE);
        WsHub.publish(null, "event: refresh\ndata: " + json + "\n\n");
    }

    // ---- creation (broadcast) ---------------------------------------------

    /** Order created; pending counts and lists change. */
    public static void notifyOrderCreated(String type, int id) {
        String json = "{\"event\":\"created\",\"type\":\"" + type + "\",\"id\":" + id + "}";
        WsHub.publish(null, "event: created\ndata: " + json + "\n\n");
    }

    /** A detail row was added/removed — the order page (per-order channel) and
     *  the list page (broadcast, total quantity changed) both refresh. */
    public static void notifyDetailChanged(String type, int id, String actor) {
        String json = "{\"event\":\"refresh\",\"type\":\"" + type + "\",\"id\":" + id
                + ",\"by\":\"" + escape(actor) + "\"}";
        WsHub.publish(channel(type, id), "event: refresh\ndata: " + json + "\n\n");
        WsHub.publish(null, "event: refresh\ndata: " + json + "\n\n");
    }

    /** User list changed (created / edited / deactivated / activated). */
    public static void notifyUsersChanged(String actor) {
        String json = "{\"event\":\"users\",\"by\":\"" + escape(actor) + "\"}";
        WsHub.publish(null, "event: users\ndata: " + json + "\n\n");
    }

    /** Product or category data changed — catalog + reports + dashboard refresh. */
    public static void notifyCatalogChanged(String actor) {
        String json = "{\"event\":\"catalog\",\"by\":\"" + escape(actor) + "\"}";
        WsHub.publish(null, "event: catalog\ndata: " + json + "\n\n");
    }

    // ---- helpers ----------------------------------------------------------

    private static String escape(String s) {
        if (s == null)
            return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
