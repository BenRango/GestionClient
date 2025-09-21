/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package first_package;

/**
 *
 * @author srang
 */

import database.DatabaseConnection;
import database.model.Client;
import database.model.Review;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
@WebServlet(name = "ReviewsDAO", urlPatterns = {"/reviews"})
public class ReviewsDAO extends HttpServlet {

    /**
     * Handles HTTP POST requests to add a new review to the database.
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Retrieve form data.
        String raison = request.getParameter("raison");
        String service = request.getParameter("service");
        String userIdStr = request.getParameter("user_id"); 
        String commentaire = request.getParameter("commentaire");
        String satisfaction = request.getParameter("satisfaction");
        String dateVisiteStr = request.getParameter("dateVisite");

        if (userIdStr == null || userIdStr.isEmpty()) {
            response.getWriter().println("Erreur: Le User ID est requis.");
            return;
        }

        try {
            Integer userId = Integer.valueOf(userIdStr);
            Date dateVisite = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateVisiteStr);

            String sql = "INSERT INTO Reviews (user_id, DateVisite, Raison, Satisfaction, Service, Commentaire) VALUES (?, ?, ?, ?, ?, ?)";

            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, userId);
                stmt.setTimestamp(2, new java.sql.Timestamp(dateVisite.getTime()));
                stmt.setString(3, raison);
                stmt.setString(4, satisfaction);
                stmt.setString(5, service);
                stmt.setString(6, commentaire);

                stmt.executeUpdate();
                System.out.println("Avis ajouté avec succès !");

                response.sendRedirect("reviews");

            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Erreur lors de l'ajout de l'avis : " + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur de données : " + e.getMessage());
        }
    }

    /**
     * Handles HTTP GET requests to retrieve and display all reviews.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        List<Review> reviews = new ArrayList<>();
        
        // SQL query to fetch all review attributes.
        String sql = "SELECT ID, user_id, DateVisite, Raison, Satisfaction, Service, Commentaire FROM Reviews";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            String userSql = "SELECT *FROM User Where ID = ?";
            while (rs.next()) {
                
                PreparedStatement userStmt = conn.prepareStatement(userSql);
                userStmt.setInt(1, rs.getInt("user_id"));
                ResultSet userRs = userStmt.executeQuery();
                Client user = new Client();
                while (userRs.next()) {
                    user.setContact(userRs.getString("Contact"));
                    user.setLastName(userRs.getString("last_name"));
                    user.setFirstName(userRs.getString("first_name"));
                }
                
                Review review = new Review();
                review.setID(rs.getInt("ID"));
                review.setUser_id(rs.getInt("user_id"));
                review.setUser(user);
                review.setDateVisite(rs.getTimestamp("DateVisite"));
                review.setRaison(rs.getString("Raison"));
                review.setSatisfaction(rs.getString("Satisfaction"));
                review.setService(rs.getString("Service"));
                review.setCommentaire(rs.getString("Commentaire"));
                reviews.add(review);
                //System.out.println(review.getUser().getFirstName());
                for (Review showedReview : reviews){
                 
                 System.out.println(showedReview.getID()+" : "+ showedReview.getUser().getFirstName());
                }
            }
            

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Erreur de base de données", e);
        }

        // Attach the list of reviews to the request object.
        request.setAttribute("reviewsList", reviews);

        // Forward the request to the JSP page for display.
        RequestDispatcher dispatcher = request.getRequestDispatcher("allAvis.jsp");
        dispatcher.forward(request, response);
    }
}
