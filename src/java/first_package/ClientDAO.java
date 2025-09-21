package first_package;

import database.DatabaseConnection;
import database.model.Client;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
@WebServlet(name = "ClientServlet", urlPatterns = {"/users"})
public class ClientDAO extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String firstName = request.getParameter("nom");
        String contact = request.getParameter("phone");

        if (contact == null || contact.trim().isEmpty()) {
            System.out.println(request.getParameter("name"));
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Le contact ne peut pas être vide.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check for existing user
            String checkSql = "SELECT COUNT(*) FROM User WHERE Contact = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, contact);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        System.out.println("Un utilisateur avec ce numéro de contact existe déjà.");
                        String userSql = "SELECT ID FROM User WHERE Contact = ?";
                        try (PreparedStatement userStmt = conn.prepareStatement(userSql)) {
                            userStmt.setString(1, contact);
                            try (ResultSet userRs = userStmt.executeQuery()) {
                                if (userRs.next()) {
                                    int userId = userRs.getInt("ID");
                                    response.setContentType("application/json");
                                    response.setCharacterEncoding("UTF-8");
                                    response.getWriter().write("{\"id\": " + userId + "}");
                                }
                            }
                        }
                        return;
                    }
                }
            }

            String insertSql = "INSERT INTO User (first_name, last_name, Contact) VALUES (?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setString(1, firstName);
                insertStmt.setString(2, ""); // last_name is an empty string
                insertStmt.setString(3, contact);

                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Client ajouté avec succès !");
                    
                    // You need to get the user ID here to return it to the client
                    String userSql = "SELECT ID FROM User WHERE Contact = ?";
                    try (PreparedStatement userStmt = conn.prepareStatement(userSql)) {
                        userStmt.setString(1, contact);
                        try (ResultSet userRs = userStmt.executeQuery()) {
                            if (userRs.next()) {
                                int userId = userRs.getInt("ID");
                                // Here, instead of a redirect, you should return the ID in a JSON response
                                response.setContentType("application/json");
                                response.setCharacterEncoding("UTF-8");
                                response.getWriter().write("{\"id\": " + userId + "}");
                            }
                        }
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur interne lors de l'ajout de l'utilisateur.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur de base de données : " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Client> clients = new ArrayList<>();
        String sql = "SELECT ID, first_name, last_name, Contact FROM User"; 

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
            throw new ServletException("Erreur de base de données", e);
        }
        
        request.setAttribute("listeDesClients", clients);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("Users.jsp");
        dispatcher.forward(request, response);
    }
}