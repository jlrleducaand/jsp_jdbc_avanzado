<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="styles.css"/>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery("SELECT * FROM entrenamiento");
%>
<table>
    <tr>
        <th>Código</th>
        <th>Tipo Entrenamiento</th>
        <th>Ubicacion</th>
        <th>Fecha </th>
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
        <td>
            <%=listado.getInt("entrenamientoID")%>
        </td>
        <td><%=listado.getString("tipo_entrenamiento")%>
        </td>
        <td><%=listado.getString("ubicacion")%>
        </td>
        <td><%=listado.getDate("fecha_realizacion")%>
        </td>


        <td class="row">
            <form method="PUSH" action="borraEntrenamiento.jsp">
                <input type="hidden" name="entrenamientoID" value="<%=listado.getString("entrenamientoID") %>"/>
                <input type="submit" value="Borrar">
            </form>
        </td>
        <td class="row">
            <form method="get" action="detalleEntrenamiento.jsp">
                <input type="hidden" name="entrenamientoID" value="<%=listado.getString("entrenamientoID") %>"/>
                <input type="submit" value="Detalle">
            </form>
        </td>
        <td class="row">
            <form method="get" action="entrenamiento.jsp">  <!-- index.jsp -->
                <input type="hidden" name="volver" value="<%=listado.getString("entrenamientoID") %>"/>
                <input type="submit" value="Volver">
            </form>
        </td>
    </tr>
    <%
        } // while
        conexion.close();
    %>
</table>
</body>
</html>