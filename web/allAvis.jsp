<%-- 
    Document   : allAvis
    Created on : Sep 18, 2025, 7:00:45 PM
    Author     : srang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="database.model.Review"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Opinions Clients</title>
        <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        :root {
            --primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --success: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --warning: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            --danger: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            
            --bg-primary: #0f0f23;
            --bg-secondary: #1a1a2e;
            --bg-card: rgba(220, 220, 220, 0.1); /* Gris transparent */
            --bg-glass: rgba(255, 255, 255, 0.1);
            
            --text-primary: #ffffff;
            --text-secondary: #b8b8ff;
            --text-muted: #8888aa;
            
            --border: rgba(255, 255, 255, 0.1);
            --shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            --shadow-hover: 0 15px 45px rgba(31, 38, 135, 0.5);
            
            --radius: 20px;
            --radius-sm: 12px;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            margin: 0;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.2) 0%, transparent 50%);
            z-index: -1;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 700;
            letter-spacing: -0.8px;
        }

        .container {
            width: 100%;
            max-width: 1200px;
        }
        
        .opinions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            animation: grid-in 0.8s ease-out;
        }
        
        @keyframes grid-in {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .opinion-card {
            background-color: var(--bg-card);
            border-radius: 16px;
            padding: 40px;
            box-shadow: var(--shadow-light);
            transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94), box-shadow 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 1px solid rgba(255, 255, 255, 0.1); /* Bordure légèrement transparente */
            display: flex;
            flex-direction: column;
            position: relative;
            margin-top: 30px;
            backdrop-filter: blur(10px); /* Ajoute un effet de flou pour le "glassmorphism" */
        }

        .nav-item {
            padding: 8px 20px;
            margin-bottom: 20px;
            background: transparent;
            border-radius: 20px;
            color: white;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: bold;
        }

        .nav-item.active {
            background: var(--primary);
            color: white;
            transform: scale(1.05);
        }

        .nav-item:hover:not(.active) {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .opinion-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
        }
        
        .opinion-icon {
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: var(--primary-color);
            border-radius: 50%;
            padding: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: var(--shadow-light);
        }
        
        .opinion-icon svg {
            fill: #ffffff;
            width: 24px;
            height: 24px;
        }
        
        .opinion-card-header {
            font-size: 1.4em;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 20px;
            border-bottom: 3px solid var(--primary-bg);
            padding-bottom: 12px;
            text-align: center;
            margin-top: 20px;
        }
        
        .opinion-field {
            margin-bottom: 18px;
        }
        
        .opinion-field-label {
            font-weight: 500;
            color: var(--light-text);
            margin-bottom: 6px;
            display: block;
            font-size: 0.95em;
        }

        .opinion-field-value {
            font-size: 1.1em;
            color: var(--text-color);
            word-wrap: break-word;
        }

        .no-opinions {
            color: var(--light-text);
            text-align: center;
            margin-top: 50px;
            font-size: 1.2em;
            font-style: italic;
        }
        
        /* Styles pour les étiquettes et les valeurs spécifiques */
        .opinion-card .contact .opinion-field-value {
            font-weight: bold;
            color: #333;
        }

        .opinion-card .satisfaction .opinion-field-value {
            font-weight: bold;
            /* Ajoute une couleur conditionnelle en JSP */
            color: <%= "Oui".equals(request.getAttribute("satisfaction")) ? "#4CAF50" : "#F44336" %>;
        }
    </style>
    </head>
    <body>

        <h1>Opinions des clients</h1>
        <button class="nav-item"><a href="/GestionClient" class="nav-item"> Donner votre avis </a></button>
        
        
        <div class="container">
            <% 
                List<Review> opinions = (List<Review>) request.getAttribute("reviewsList");
                if (opinions != null && !opinions.isEmpty()) {
            %>
            <div class="opinions-grid">
                <% for (Review opinion : opinions) { %>
                <%@ page import="java.util.Date" %>
                <%@ page import="java.text.SimpleDateFormat" %>
                <% 
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                    Date dateVisite = opinion.getDateVisite();
                %>
                    <div class="opinion-card">
                        <div class="opinion-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.38 0 2.5 1.12 2.5 2.5S13.38 10 12 10 9.5 8.88 9.5 7.5 10.62 5 12 5zm0 14.2c-2.5 0-4.71-1.28-6-3.23.09-1.92 4.01-3.15 6-3.15s5.91 1.23 6 3.15c-1.29 1.95-3.5 3.23-6 3.23z"/>
                            </svg>
                        </div>
                        <div class="opinion-card-header">
                            Par <%= opinion.getUser().getLastName() %> <%= opinion.getUser().getFirstName() %> 
                        </div>
                        
                        <div class="opinion-field contact">
                            <span class="opinion-field-label">Contact:</span>
                            <span class="opinion-field-value"><%= opinion.getUser().getContact() %></span>
                        </div>
                        
                        <div class="opinion-field satisfaction">
                            <span class="opinion-field-label">Satisfaction:</span>
                            <span class="opinion-field-value"><%= opinion.getSatisfaction() %></span>
                        </div>
                        
                        <div class="opinion-field raison">
                            <span class="opinion-field-label">Raison:</span>
                            <span class="opinion-field-value"><%= opinion.getRaison() %></span>
                        </div>
                        
                        <div class="opinion-field commentaire">
                            <span class="opinion-field-label">Commentaire:</span>
                            <span class="opinion-field-value"><%= opinion.getCommentaire() %></span>
                        </div>
                        
                        <div class="opinion-field service">
                            <span class="opinion-field-label">Service:</span>
                            <span class="opinion-field-value"><%= opinion.getService() %></span>
                        </div>
                        
                        <div class="opinion-field date-visite">
                            <span class="opinion-field-label">Date de visite:</span>
                            <span class="opinion-field-value"><%= dateFormat.format(dateVisite) %></span>
                        </div>
                        
                        <div class="opinion-field heure-visite">
                            <span class="opinion-field-label">Heure de visite:</span>
                            <span class="opinion-field-value"><%= timeFormat.format(dateVisite) %></span>
                        </div>
                    </div>
                <% } %>
            </div>
            <% 
                } else {
            %>
            <div class="no-opinions">Aucune opinion trouvée.</div>
            <% 
                }
            %>
        </div>
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
        const satisfactionElements = document.querySelectorAll('.opinion-field.satisfaction .opinion-field-value');
        satisfactionElements.forEach(element => {
            const value = element.textContent.trim();
            if (value === '1') {
                element.textContent = 'Oui';
            } else if (value === '0') {
                element.textContent = 'Non';
            }
        });
        });
    </script>
    </body>
</html>