package model;

public class User {
    private int id;
    private String username, password, first_name, last_name, gender, birthday,number,address,status;

    public User(int id, String username, String password, String first_name, String last_name, String gender, String birthday) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.birthday = birthday;
    }

    public User(int id, String username, String first_name, String last_name, String gender, String birthday, String number, String address) {
        this.id = id;
        this.username = username;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.birthday = birthday;
        this.number = number;
        this.address = address;
    }

    public User(int id, String username, String first_name, String last_name, String gender, String birthday, String number, String address, String status) {
        this.id = id;
        this.username = username;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.birthday = birthday;
        this.number = number;
        this.address = address;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public String getNumber() {
        return number;
    }

    public String getAddress() {
        return address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }
}
