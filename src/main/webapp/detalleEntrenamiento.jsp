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
    int entrenamientoID = -1;

    try {
        entrenamientoID = Integer.parseInt(request.getParameter("entrenamientoID"));
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


            String sql = "SELECT * FROM entrenamiento WHERE entrenamientoID = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, entrenamientoID); // la primera ? será el valor pasado
            rs = ps.executeQuery();


            if (rs.next()) {

                entrenamientoID = rs.getInt("entrenamientoID");
                String tipoEntrenamiento = rs.getString("tipo_entrenamiento");
                String ubicacion = rs.getString("ubicacion");
                Date fechaRealizacion = rs.getDate("fecha_realizacion");
%>
<div class="container text-center">
    <h1>DETALLE DE ENTRENAMIENTO</h1><br/>
<table class="container m-2">
    <thead>
    <tr>
        <th class="p-2">EntrenamientoID</th>
        <th class="p-2">Tipo Entrenamiento</th>
        <th class="p-2 ">Ubicacion</th>
        <th class="p-2 ">Fecha Realizacion</th>
        <th>
            <form method="get" action="pideNumeroEntrenamiento.jsp">
                <input class="btn btn-primary" type="submit" value="Volver">
            </form>
        </th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="p-2 text-center"><%= entrenamientoID %>
        </td>
        <td class="p-2 text-center"><%= tipoEntrenamiento %>
        </td>
        <td class="p-2 text-center"><%= ubicacion %>
        </td>
        <td class="p-2 text-center"><%= fechaRealizacion %>
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
            try {
                rs.close();
            } catch (Exception e) { /* Ignored */}
        }

        out.println("\t Entrenamiento dado de alta.");
    } else {
        out.println("<div class='container text-center'><h3>Error de validación!</h3>");
        out.println("<form method='get' action='entrenamiento.jsp'>"
                + "<input type='submit' value='Volver'>"
                + "</form>"
                + "</div>");
    }

%>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
