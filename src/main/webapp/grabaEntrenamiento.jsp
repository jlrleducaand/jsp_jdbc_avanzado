<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: JLRL
  Date: 27/11/2023
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <title>Graba Entrenamiento</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="styles.css">
    </head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;

    String tipoEntrenamiento = null;
    String ubicacion = null;
    Date fechaRealizacion = null;


    boolean flagValidaTipoEntrenamientoNull = false;
    boolean flagValidaTipoEntrenamientoBlank = false;
    boolean flagValidaUbicacionNull = false;
    boolean flagValidaUbicacionBlank = false;
    boolean flagValidaFechaRealizacionParse = false;

    try {


        Objects.requireNonNull(request.getParameter("tipo_entrenamiento"));
        flagValidaTipoEntrenamientoNull = true;

        if (request.getParameter("tipo_entrenamiento").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaTipoEntrenamientoBlank = true;

        tipoEntrenamiento = request.getParameter("tipo_entrenamiento");


        Objects.requireNonNull(request.getParameter("ubicacion"));
        flagValidaUbicacionNull = true;


        if (request.getParameter("ubicacion").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaUbicacionBlank = true;

        ubicacion = request.getParameter("ubicacion");


        //String strfechaRealizacion = request.getParameter("fecha_realizacion");  // cadena para mysql
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  //formateador


        try {
            fechaRealizacion = dateFormat.parse(request.getParameter("fecha_realizacion"));  //asignacion
            flagValidaFechaRealizacionParse = true;


        }catch (ParseException e){
            valida = false;
            throw new RuntimeException("La cadena no se puede convertir en fecha");
        }




    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaTipoEntrenamientoNull || !flagValidaTipoEntrenamientoBlank) {
            session.setAttribute("error", "Error en tipo Entrenamiento.");
        } else if (!flagValidaUbicacionNull || !flagValidaUbicacionBlank ) {
            session.setAttribute("error", "Error en Ubicacion.");
        } else if (!flagValidaFechaRealizacionParse){
            session.setAttribute("error", "Error en el formato de la Fecha");
        }

        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");


            String sql = "INSERT INTO entrenamiento (tipo_entrenamiento, ubicacion, fecha_realizacion) VALUES ( " +
                    "?, " + //tipoEntrenamiento
                    "?, " + //ubicacion
                    "?)";  //fecha_realizacion

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setString(idx++, tipoEntrenamiento);
            ps.setString(idx++, ubicacion);
            ps.setDate(idx++, new java.sql.Date(fechaRealizacion.getTime()));

            int filasAfectadas = ps.executeUpdate();
            System.out.println("ENTRENAMIENTO GRABADO:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {

            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }


        //session.setAttribute("entrenamientoIDADestacar", numero);
        response.sendRedirect("pideNumeroEntrenamiento.jsp");

    } else {

        response.sendRedirect("formularioEntrenamiento.jsp");
    }
%>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
