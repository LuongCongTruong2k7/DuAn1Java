package whm.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/** Simple Gmail SMTP sender (fill in credentials before use). */
public final class XMail {
    private static final String HOST = "smtp.gmail.com";
    private static final String FROM = "luongcongtruong02@gmail.com"; // your email
    private static final String PASSWORD = "xjrs dorc nsdm cjdw"; // app password

    private XMail() {
    }

    public static void send(String to, String subject, String body) {
        if (XStr.isBlank(FROM))
            return; // not configured
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject(subject);
            msg.setContent(body, "text/html;charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException e) {
            throw new IllegalStateException("Gửi mail thất bại", e);
        }
    }
}
