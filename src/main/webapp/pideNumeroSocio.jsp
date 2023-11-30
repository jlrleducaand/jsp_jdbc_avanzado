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

    ResultSet listado = s.executeQuery("SELECT * FROM socio");
%>
<table>
    <tr>
        <th>Código</th>
        <th>Nombre</th>
        <th>Estatura</th>
        <th>Edad</th>
        <th>Localidad</th>
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

        <td class="row">
            <form method="get" action="borraSocio.jsp">
                <input type="hidden" name="socioID" value="<%=listado.getString("socioID") %>"/>
                <input type="submit" value="Borrar">
            </form>
        </td>
        <td class="row">
            <form method="get" action="detalleSocio.jsp">
                <input type="hidden" name="socioID" value="<%=listado.getString("socioID") %>"/>
                <input type="submit" value="Detalle">
            </form>
        </td>
        <td class="row">
            <form method="get" action="index.jsp">
                <input type="hidden" name="volver" value="<%=listado.getString("socioID") %>"/>
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