package model;

public class Admin {
    private final String username;
    private final String password;

    // Constructor để thiết lập giá trị cố định cho username và password
    public Admin() {
        this.username = "admin";
        this.password = "password123";
    }

    // Getter cho username
    public String getUsername() {
        return username;
    }

    // Getter cho password
    public String getPassword() {
        return password;
    }
}
