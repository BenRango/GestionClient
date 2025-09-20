package first_package;

import database.DatabaseConnection;
import database.model.Client;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ClientServlet", urlPatterns = {"/users"})
public class ClientDAO extends HttpServlet {
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String contact = request.getParameter("contact");
        

        String sql = "INSERT INTO User (first_name, last_name, Contact) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, contact);

            stmt.executeUpdate();
            System.out.println("Client ajouté avec succès !");
            
            // Après l'ajout, on redirige vers la liste des utilisateurs pour voir le résultat.
            response.sendRedirect("users");

        } catch (SQLException e) {
            e.printStackTrace();
            // En cas d'erreur, on peut aussi rediriger vers une page d'erreur.
            response.getWriter().println("Erreur lors de l'ajout du client : " + e.getMessage());
        }
    }

    // C'est cette méthode qui va chercher et AFFICHER la liste des clients.
    // Elle est appelée via une requête GET (quand tu tapes l'URL dans le navigateur).
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Client> clients = new ArrayList<>();
        String sql = "SELECT ID, first_name, last_name, Contact FROM User"; // Sois explicite sur les colonnes

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (conn == null) {
                response.getWriter().println("Erreur : Impossible de se connecter à la base de données.");
                return;
            }

            while (rs.next()) {
                Client client = new Client();
                client.setId(rs.getInt("ID"));
                client.setFirstName(rs.getString("first_name"));
                client.setLastName(rs.getString("last_name"));
                client.setContact(rs.getString("Contact"));
                clients.add(client);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Gérer l'exception, peut-être afficher une page d'erreur
            throw new ServletException("Erreur de base de données", e);
        }
        
        // On "attache" la liste de clients à la requête pour que la JSP puisse la récupérer
        request.setAttribute("listeDesClients", clients);
        
        // On transfère la main à la page JSP pour qu'elle s'occupe de l'affichage
        RequestDispatcher dispatcher = request.getRequestDispatcher("Users.jsp");
        dispatcher.forward(request, response);
    }
}