<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.swing.*" %>
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

    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int socioId = -1;

    try {
        socioId = Integer.parseInt(request.getParameter("socioID"));
    } catch (NumberFormatException nfe) {
        nfe.printStackTrace();
        valida = false;
    }

    //FIN CÓDIGO DE VALIDACIÓN

    // VAMOS POR LA CONSULTA SQL
    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "SELECT * FROM socio WHERE socioID = ?";

            ps = conn.prepareStatement(sql);
            //  int idx = 1;                 para parametrizacion de varios datos
            //ps.setString(idx++, socioID);  para parametrizacion de varios datos
            ps.setInt(1, socioId);
            rs = ps.executeQuery();

            if (rs.next()) {

                int socio = rs.getInt("socioID");
                String nombre = rs.getString("nombre");
                int estatura = rs.getInt("estatura");
                int edad = rs.getInt("edad");
                String localidad = rs.getString("localidad");
%>
<table class="m-2">
    <thead>
    <tr>
        <th class="p-2">SocioID</th>
        <th class="p-2">Nombre</th>
        <th class="p-2 ">Estatura</th>
        <th class="p-2 ">Edad</th>
        <th class="p-2 ">Localidad</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="p-2 text-center"><%= socio %>
        </td>
        <td class="p-2 text-center"><%= nombre %>
        </td>
        <td class="p-2 text-center"><%= estatura %>
        </td>
        <td class="p-2 text-center"><%= edad %>
        </td>
        <td class="p-2 text-center"><%= localidad %>
        </td>
        <td>
            <form method="get" action="index.jsp">
                <input type="submit" value="Volver">
            </form>
        </td>
    </tr>
    </tbody>
</table>


<%
            }

        } catch (Exception ex) {
            ex.printStackTrace();



            } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        out.println("\t Socio dado de alta.");
    } else {
        out.println("<div><h3 class='text-center'>Error de validación!</h3>");
        out.println("<td>"
                + "<form method='get' action='index.jsp'>"
                + "<input type='submit' value='Volver'>"
                + "</form>"
                + "</td>"
                + "</div>");
    }

%>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
