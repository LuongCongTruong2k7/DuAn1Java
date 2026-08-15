package whm.ws;

import java.io.IOException;

import jakarta.websocket.CloseReason;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

/**
 * Server-side WebSocket endpoint for realtime notifications.
 *
 * <p>Annotated endpoint, so Tomcat auto-registers it under
 * {@code /admin/ws} via its WebSocket SCI scan — no extra wiring needed.</p>
 *
 * <p>Clients connect to {@code ws://host/QuanLy_Kho/admin/ws?channel=receipt-6}
 * (or {@code issue-6}) to watch one order, or {@code channel=broadcast} to
 * receive a global "data changed" refresh. On connect the endpoint subscribes
 * the session to that channel; {@link RealtimeNotifier} publishes events when
 * the manager approves an order or data changes. On close the session is
 * unsubscribed.</p>
 */
@ServerEndpoint("/admin/ws")
public class RealtimeEndpoint {

    private String channel;

    @OnOpen
    public void onOpen(Session session) {
        String query = session.getRequestURI().getQuery();
        String ch = param(query, "channel");
        if (ch == null || ch.isBlank()) {
            close(session, CloseReason.CloseCodes.VIOLATED_POLICY, "Missing channel");
            return;
        }
        this.channel = ch;
        WsHub.subscribe(ch, session);

        if (WsHub.BROADCAST.equals(ch))
            return; // global channel — nothing to replay

        // If this order was already approved before the client connected, tell it now.
        String type = ch.contains("receipt") ? "receipt" : "issue";
        try {
            int id = Integer.parseInt(ch.substring(ch.indexOf('-') + 1));
            if (RealtimeNotifier.isApproved(type, id)) {
                String json = "{\"" + type + "Id\":" + id + ",\"approvedBy\":\"cached\"}";
                session.getBasicRemote().sendText("event: approved\ndata: " + json + "\n\n");
            }
        } catch (NumberFormatException | IOException ignored) {
            // malformed channel or send failed — the client reload picks up state anyway
        }
    }

    /** We never read application data; drop anything the client sends. */
    @OnMessage
    public void onMessage(String message) {
        // no-op
    }

    @OnClose
    public void onClose(Session session, CloseReason reason) {
        if (channel != null)
            WsHub.unsubscribe(channel, session);
    }

    @OnError
    public void onError(Session session, Throwable t) {
        if (channel != null)
            WsHub.unsubscribe(channel, session);
    }

    /** Parse {@code name} out of a query string like {@code ?channel=receipt-6}. */
    private static String param(String query, String name) {
        if (query == null)
            return null;
        for (String pair : query.split("&")) {
            int eq = pair.indexOf('=');
            if (eq > 0 && pair.substring(0, eq).equals(name))
                return pair.substring(eq + 1);
        }
        return null;
    }

    private static void close(Session session, CloseReason.CloseCodes code, String msg) {
        try {
            session.close(new CloseReason(code, msg));
        } catch (IOException ignored) {
            // best effort
        }
    }
}
