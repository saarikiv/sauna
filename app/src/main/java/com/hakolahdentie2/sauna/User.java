package com.hakolahdentie2.sauna;
import com.google.firebase.database.IgnoreExtraProperties;

@IgnoreExtraProperties
public class User {

    public String firstname;
    public String lastname;
    public String uid;
    public String email;

    public User() {
        // Default constructor required for calls to DataSnapshot.getValue(User.class)
    }

    public User(String firstname, String lastname, String uid, String email) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.uid = uid;
        this.email = email;
    }

    public String toString(){
        return "UID: " + this.uid + " - FirstName: " + this.firstname + " LastName: " + this.lastname + " email: " + this.email;
    }

}

