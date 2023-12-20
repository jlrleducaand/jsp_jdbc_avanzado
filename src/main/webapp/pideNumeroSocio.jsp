<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css"/>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");
    Statement s = conn.createStatement();

    ResultSet listado = s.executeQuery("SELECT * FROM socio");
%>
<div class="container text-center">
    <h1>CRUD DE SOCIOS</h1><br/>
<table class="container">
    <tr>
        <th>Código</th>
        <th>Nombre</th>
        <th>Estatura</th>
        <th>Edad</th>
        <th>Localidad</th>
        <th>
            <form method="get" action="formularioSocio.jsp">
                <input type="submit" value="Nuevo">
            </form>
        </th>
        <th>
            <form method="get" action="index.jsp">
                <input type="submit" value="Volver">
            </form>
        </th>
    </tr>
    <%
        Integer socioIDADestacar = (Integer) session.getAttribute("socioIDADestacar");
        String claseDestacar = "";

        while (listado.next()) {
            claseDestacar = (socioIDADestacar != null
                    && socioIDADestacar == listado.getInt("socioID")) ?
                    "destacar" : "";
    %>

    <tr class="<%= claseDestacar%>">
        <td>
            <%=listado.getInt("socioID")%>
        </td>
        <td><%=listado.getString("nombre")%>
        </td>
        <td><%=listado.getInt("estatura")%>
        </td>
        <td><%=listado.getInt("edad")%>
        </td>
        <td><%=listado.getString("localidad")%>
        </td>

        <td>
            <form method="get" action="borraSocio.jsp">
                <input type="hidden" name="socioID" value="<%=listado.getString("socioID") %>"/>
                <input type="submit" value="Borrar">
            </form>
        </td>
        <td>
            <form method="get" action="detalleSocio.jsp">
                <input type="hidden" name="socioID" value="<%=listado.getString("socioID") %>"/>
                <input type="submit" value="Detalle">
            </form>
        </td>

    </tr>
    <%
        } // while
        conn.close();
    %>
</table>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>