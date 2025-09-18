/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database.model;

/**
 *
 * @author srang
 */
public class Client {
    private int ID;
    private String first_name;
    private String last_name;
    private String Contact;

    public String getFirstName() {
        return first_name;
    }

    public String getLastName() {
        return last_name;
    }

    public String getContact() {
        return Contact;
    }

    public void setId(int id) {
        this.ID = id;
    }

    public void setLastName(String nom) {
        this.last_name = nom;
    }

    public void setFirstName(String prenom) {
        this.last_name = prenom;
    }

    public void setContact(String numero) {
        this.Contact = numero;
    }  
}
