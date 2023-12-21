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
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery("SELECT * FROM entrenamiento");
%>
<div class="container text-center">
    <h1>CRUD DE ENTRENAMIENTOS</h1><br>
<table class="container">
    <tr class="text-center">
        <th>Código</th>
        <th>Tipo Entrenamiento</th>
        <th>Ubicacion</th>
        <th>Fecha </th>
        <th>
            <form method="get" action="formularioEntrenamiento.jsp" class="text-center">
                <input class="btn btn-primary" type="submit" value="Nuevo">
            </form>
        </th>
        <th>
            <form method="get" action="entrenamiento.jsp" class="text-center">
                <input class="btn btn-primary" type="submit" value="Volver">
            </form>
        </th>
    </tr>
    <%
        Integer entrenamientoIDADestacar = (Integer) session.getAttribute("entrenamientoIDADestacar");
        String claseDestacar = "";

        while (listado.next()) {
            claseDestacar = (entrenamientoIDADestacar != null
                    && entrenamientoIDADestacar == listado.getInt("entrenamientoID")) ?
                    "destacar" : "";
    %>

    <tr class="<%= claseDestacar%>">
        <td><%=listado.getInt("entrenamientoID")%>          </td>
        <td><%=listado.getString("tipo_entrenamiento")%>    </td>
        <td><%=listado.getString("ubicacion")%>             </td>
        <td><%=listado.getDate("fecha_realizacion")%>       </td>

        <td>
            <form method="PUSH" action="borraEntrenamiento.jsp">
                <input type="hidden" name="entrenamientoID" value="<%=listado.getString("entrenamientoID") %>"/>
                <input class="btn btn-secondary" type="submit" value="Borrar">
            </form>
        </td>
        <td>
            <form method="get" action="detalleEntrenamiento.jsp">
                <input type="hidden" name="entrenamientoID" value="<%=listado.getString("entrenamientoID") %>"/>
                <input class="btn btn-secondary" type="submit" value="Detalle">
            </form>
        </td>

    </tr>
    <%
        } // while
        conexion.close();
    %>
</table>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>