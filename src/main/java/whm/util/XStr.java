package whm.util;

/** Small string helpers. */
public final class XStr {
    private XStr() {
    }

    public static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    public static String orDefault(String s, String def) {
        return isBlank(s) ? def : s.trim();
    }

    public static String abbreviate(String s, int max) {
        if (s == null)
            return "";
        return s.length() <= max ? s : s.substring(0, max - 1) + "…";
    }
}
