/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
/**
 *
 * @author srang
 */


@WebServlet(name = "ClientServlet", urlPatterns = {"/users"})
public class ClientDAO extends HttpServlet{
    public void doPost(Client client) {
        String sql = "INSERT INTO User (nom, prenom, email) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, client.getFirstName());
            stmt.setString(2, client.getLastName());
            stmt.setString(3, client.getContact());

            stmt.executeUpdate();
            System.out.println("Client ajouté avec succès !");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        if(idStr != null)
        {
            Client client = null;
            int id = Integer.parseInt(idStr);
            String sql = "SELECT * FROM User WHERE id = ?";
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                if (conn == null) {
                    response.getWriter().println("Erreur : Impossible de se connecter à la base de données.");
                    return; 
                }

                stmt.setInt(1, id);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        client = new Client();
                        client.setId(rs.getInt("ID"));
                        client.setFirstName(rs.getString("first_name"));
                        client.setLastName(rs.getString("last_name"));
                        client.setContact(rs.getString("Contact"));
                        System.out.println(client.getLastName());
                    }
                }
                request.setAttribute("users", client);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Users.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else{
            List<Client> clients = new ArrayList<>();
            String sql = "SELECT * FROM User";

            try (Connection conn = DatabaseConnection.getConnection();
                 ) {
                if (conn == null) {
                    response.getWriter().println("Erreur : Impossible de se connecter à la base de données.");
                    return; 
                }
                PreparedStatement stmt = conn.prepareStatement(sql);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Client client = new Client();
                        client.setId(rs.getInt("ID"));
                        client.setFirstName(rs.getString("first_name"));
                        client.setLastName(rs.getString("last_name"));
                        client.setContact(rs.getString("Contact"));
                        System.out.println(client.getLastName());
                        clients.add(client);
                    }
                }
                System.out.println(clients);
                request.setAttribute("users", clients);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Users.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
