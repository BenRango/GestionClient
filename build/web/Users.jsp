<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Avis des Clients</title>
    
    <%-- Le style CSS est maintenant directement ici --%>
    <style>
        body {
            font-family: 'Roboto', sans-serif; /* Pense à ajouter le lien Google Fonts si tu veux cette police */
            background-color: #f4f7f9;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 40px;
        }

        .user-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .user-card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .user-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            background-color: #3498db;
            color: white;
            padding: 15px;
            text-align: center;
        }

        .card-header h2 {
            margin: 0;
            font-size: 1.2em;
        }

        .card-body {
            padding: 20px;
        }

        .card-body p {
            margin: 0 0 10px;
            line-height: 1.6;
        }

        .card-body .review {
            font-style: italic;
            color: #555;
            border-left: 3px solid #3498db;
            padding-left: 15px;
            margin-top: 15px;
        }
    </style>
    
    <%-- Pour un meilleur rendu de la police, tu peux garder ce lien --%>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>

    <div class="container">
        <h1>Liste des Avis Clients</h1>

        <div class="user-grid">
            <c:if test="${not empty listeDesClients}">
                <c:forEach var="client" items="${listeDesClients}">
                    <div class="user-card">
                        <div class="card-header">
                            <h2>${client.firstName} ${client.lastName}</h2>
                        </div>
                        <div class="card-body">
                            <p><strong>Contact :</strong> ${client.contact}</p>
                            <p class="review">
                                "Ceci est un avis statique pour la démonstration. 
                                Vous pourriez ajouter un champ 'avis' dans votre base de données et l'afficher ici avec ${client.reviews}."
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty listeDesClients}">
                <p>Aucun client à afficher pour le moment.</p>
            </c:if>
        </div>
    </div>

</body>
</html>