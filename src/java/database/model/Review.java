/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database.model;

/**
 *
 * @author srang
 */
import java.util.Date;

public class Review {
    private int ID;
    private String Raison;
    private String Service;
    private Integer user_id;
    private String Commentaire;
    private Client user;
    private Date DateVisite;
    private String Satisfaction;

    public int getID() {
        return ID;
    }
    public Client getUser() {
        return user;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getRaison() {
        return Raison;
    }

    public void setRaison(String Raison) {
        this.Raison = Raison;
    }

    public String getService() {
        return Service;
    }

    public void setService(String Service) {
        this.Service = Service;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getCommentaire() {
        return Commentaire;
    }

    public void setCommentaire(String Commentaire) {
        this.Commentaire = Commentaire;
    }

    public Date getDateVisite() {
        return DateVisite;
    }

    public void setDateVisite(Date DateVisite) {
        this.DateVisite = DateVisite;
    }

    public String getSatisfaction() {
        return Satisfaction;
    }

    public void setSatisfaction(String Satisfaction) {
        this.Satisfaction = Satisfaction;
    }

    public void setUser(Client user) {
        this.user = user;
    }
}
