package whm.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@SuppressWarnings("serial")
@Entity
@Table(name = "[User]")
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserID")
    private Integer userId;

    @Column(name = "Username", nullable = false, unique = true)
    private String username;

    @Column(name = "Password", nullable = false)
    private String password;

    @Column(name = "FullName")
    private String fullName;

    @Column(name = "Email")
    private String email;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "RoleID", nullable = false)
    private Role role;

    @Column(name = "IsActive")
    private Boolean isActive = true;

    public boolean isAdmin() {
        return role != null && role.getRoleId() != null && role.getRoleId() == 1;
    }

    public User() {
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
}
