 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package first_package;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
/**
 *
 * @author srang
 */


@WebServlet(name = "MultiplicationServlet", urlPatterns = {"/main"})
public class Class1 extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String nStr = request.getParameter("n");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Résultat</title></head><body>");
        out.println("<h2>Résultat de la table</h2>");

        if (nStr != null) {
            try {
                int n = Integer.parseInt(nStr);
                out.println("<p>Table de " + n + " :</p>");
                out.println("<ul>");
                for (int i = 1; i <= 10; i++) {
                    out.println("<li>" + n + " × " + i + " = " + (n * i) + "</li>");
                } 
                out.println("</ul>");
            } catch (NumberFormatException e) {
                out.println("<p>Veuillez entrer un nombre valide.</p>");
            }
        } else {
            out.println("<p>Aucun nombre fourni.</p>");
        }

        out.println("<a href='/WebApplication2'>Retour</a>");
        out.println("</body></html>");
    }
}
