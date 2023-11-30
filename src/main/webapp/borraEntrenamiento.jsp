<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int codigo = -1;

    try {
        codigo = Integer.parseInt(request.getParameter("entrenamientoID"));
    } catch (NumberFormatException nfe) {
        nfe.printStackTrace();
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN


    if (valida) {


        Connection conn = null;
        PreparedStatement ps = null;
        // ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER
            Class.forName("com.mysql.cj.jdbc.Driver");  // desde classPath
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","root", "1234");



            //UTILIZAR PreparedStatement SIEMPRE EN QUERIES PARAMETRIZADAS
            //EN ESTE CASO 1 SOLO PARÁMETRO: socioID = ?
            //NÓTESE QUE EL PARÁMETRO SE INTRODUCE CON UN CARÁCTER ?
            String sql = "DELETE FROM entrenamiento WHERE entrenamientoID = ?";
            //CREO EL OBJETO PreparedStatement
            ps = conn.prepareStatement(sql);

            //A LA HORA DE ESTABLECER EL VALOR DEL PARÁMETRO PARA PODER EJECUTAR
            //LA QUERY DEBEMOS INDICAR LA POSICIÓN Y UTILIZAR EL SETTER DE TIPO ADECUADO
            ps.setInt(1, codigo);

            //CUANDO EJECUTAS SENTENCIAS DML, INSERT, UPDATE, DELETE SE EMPLEA ps.executeUpdate()
            int filasAfectadas = ps.executeUpdate();

            System.out.println("ENTRENAMIENTOS BORRADOS:  " + filasAfectadas);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try { ps.close(); } catch (Exception e) { /* Ignored */ }
            try { conn.close(); } catch (Exception e) { /* Ignored */ }
        }

    }
%>

<!-- REDIRECCIÓN POR JavaScript EN EL CLIENTE  -->
<script>document.location = "pideNumeroEntrenamiento.jsp"</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
