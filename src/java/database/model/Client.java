/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database.model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author srang
 */
public class Client {
    private int ID;
    private String first_name;
    private String last_name;
    private String Contact;
    private final List<String> reviews;
    
    public Client() {
        this.reviews = new ArrayList<>(); 
    }
    public String getFirstName() {
        return first_name;
    }

    public String getLastName() {
        return last_name;
    }

    public String getContact() {
        return Contact;
    }
    public List<String> getReviews() {
        return reviews;
    }

    public void setId(int id) {
        this.ID = id;
    }

    public void setLastName(String nom) {
        this.last_name = nom;
    }

    public void setFirstName(String prenom) {
        this.first_name = prenom;
    }

    public void setContact(String numero) {
        this.Contact = numero;
    }  
    public void addRevews(String review) {
        this.reviews.add(review);
    }  
}
