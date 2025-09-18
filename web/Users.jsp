<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestion des Clients</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .container {
            width: 80%;
            margin: auto;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Liste des Clients</h1>

        <c:if test="${not empty users}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Prénom</th>
                        <th>Nom</th>
                        <th>Contact</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="client" items="${users}">
                        <tr>
                            <td><c:out value="${client.getID()}"/></td>
                            <td><c:out value="${client.getFirstName()}"/></td>
                            <td><c:out value="${client.getLastName()}"/></td>
                            <td><c:out value="${client.getContact()}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty users}">
            <p>Aucun client trouvé.</p>
        </c:if>
    </div>
</body>
</html>