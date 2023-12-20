<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado Entrenamientos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<div class="container">
    <div class="row">
        <h1>Listado de Entrenamientos</h1>
        <tr>
            <td class="mx-5 px-5 d-flex align-item-center">
              <form class="m-5 px-5"  method="get" action="entrenamiento.jsp">
              <input type="submit" value="Volver">
              </form>
            </td>
        </tr>
    </div>


    <%
        //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
        //	v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
        Class.forName("com.mysql.cj.jdbc.Driver");  //Conector Java
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");
        // consulta plana sin parametros  permite usar executeQuerry
        //UTILIZAR STATEMENT SÓLO EN QUERIES NO PARAMETRIZADAS  o PLANAS.
        // STATEMENT se utiliza el objeto para enviar consultas  y actualizaciones a las BBDD
        Statement s = conexion.createStatement();
        ResultSet listado = s.executeQuery("SELECT * FROM entrenamiento");

        //puedo poner una cabecera de tabla con html
        while (listado.next()) {
            //puedo poner una celda con cada informacion para campo deseado con html
            out.println(listado.getString("entrenamientoID") + " " + listado.getString("tipo_entrenamiento") + "<br>");
        }
        listado.close();
        s.close();
        conexion.close();
    %>


</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>