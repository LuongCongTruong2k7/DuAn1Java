package whm.ws;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.websocket.Session;

/**
 * Registry of open WebSocket sessions, grouped by channel.
 *
 * <p>Channels:</p>
 * <ul>
 *   <li>{@code receipt-N} / {@code issue-N} — a staff member watching one
 *       receipt/issue detail page. When the manager approves, the order's
 *       status badge updates in place without an F5.</li>
 *   <li>{@code broadcast} — every open page that subscribes to it (dashboard,
 *       lists, reports, users, catalog). Server-side mutations publish one
 *       event to {@code broadcast} and every listening tab refreshes its data.</li>
 * </ul>
 *
 * <p>A channel may have many sessions (multiple tabs, different users).
 * A session may subscribe to at most one channel at a time.</p>
 */
public final class WsHub {

    /** Channel name for global "data changed somewhere, refresh" events. */
    public static final String BROADCAST = "broadcast";

    private WsHub() {
    }

    /** channel -> sessions subscribed to it. */
    private static final ConcurrentHashMap<String, Set<Session>> SESSIONS = new ConcurrentHashMap<>();
    /** session -> its channel, so we can clean up on close. */
    private static final ConcurrentHashMap<Session, String> CHANNELS = new ConcurrentHashMap<>();

    /** Subscribe {@code session} to {@code channel}. */
    public static void subscribe(String channel, Session session) {
        if (channel == null || session == null)
            return;
        // unsubscribe from any previous channel
        String old = CHANNELS.put(session, channel);
        if (old != null && !old.equals(channel))
            SESSIONS.computeIfAbsent(old, k -> ConcurrentHashMap.newKeySet()).remove(session);
        SESSIONS.computeIfAbsent(channel, k -> ConcurrentHashMap.newKeySet()).add(session);
    }

    /** Remove {@code session} from {@code channel} (no-op if it isn't subscribed). */
    public static void unsubscribe(String channel, Session session) {
        if (channel == null || session == null)
            return;
        CHANNELS.remove(session, channel);
        Set<Session> set = SESSIONS.get(channel);
        if (set != null) {
            set.remove(session);
            if (set.isEmpty())
                SESSIONS.remove(channel, set);
        }
    }

    /** True when at least one session is subscribed to {@code channel}. */
    public static boolean hasSubscriber(String channel) {
        Set<Session> set = SESSIONS.get(channel);
        return set != null && !set.isEmpty();
    }

    /**
     * Send {@code data} to every session subscribed to {@code channel} (or to
     * {@link #BROADCAST} when {@code channel} is {@code null}). Returns true if
     * at least one send succeeded.
     */
    public static boolean publish(String channel, String data) {
        boolean any = false;
        Set<Session> targets = new java.util.HashSet<>();
        if (channel != null) {
            Set<Session> set = SESSIONS.get(channel);
            if (set != null)
                targets.addAll(set);
        } else {
            Set<Session> set = SESSIONS.get(BROADCAST);
            if (set != null)
                targets.addAll(set);
        }
        for (Session s : targets) {
            if (s.isOpen()) {
                try {
                    synchronized (s) {
                        s.getBasicRemote().sendText(data);
                    }
                    any = true;
                } catch (IOException | IllegalStateException e) {
                    // broken session — drop it
                    String ch = CHANNELS.get(s);
                    if (ch != null)
                        unsubscribe(ch, s);
                }
            } else {
                String ch = CHANNELS.get(s);
                if (ch != null)
                    unsubscribe(ch, s);
            }
        }
        return any;
    }

    /** Best-effort close of a session after it has been evicted. */
    static void closeQuietly(Session s) {
        try {
            s.close();
        } catch (IOException ignored) {
            // best effort
        }
    }
}
