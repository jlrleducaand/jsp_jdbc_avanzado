<%--
  Created by IntelliJ IDEA.
  User: JLRL
  Date: 27/11/2023
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Formulario Entrenamiento</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
<h2 class="col-6 text-center">Introduzca los datos del nuevo Entrenamiento:</h2>
<form method="post" action="grabaEntrenamiento.jsp">
    <!--LOS VALORES NO LOS RESCATA POR QUE EN LA VALIDACION NO SE GRABAN HASTA QUE NO ESTAN TODOS CORRECTOS (BUSCAR OTRO METODO)  estan comentados -->
    <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Tipo Entrenamiento</label>
        <select class="col-4 "type="text" name="tipo_entrenamiento"
        <option value=""> </option>
        <option value="fisico">Físico</option>
        <option value="tecnico">Técnico</option>
        </select>
    </div>  </br>
    <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Ubicacion</label>     <input class="col-4 "type="text" name="ubicacion" ></div>  </br>
    <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Fecha Realizacion</label><input class="col-4 "type="date" name="fecha_realizacion" ></div>  </br>

    <input class="col-6 m-2  text-center bg-warning" type="submit" value="Aceptar">
</form>
<form method="get" action="entrenamiento.jsp">
    <input class="col-6 m-2  text-center bg-alert" type="submit" value="Volver">
</form>



<%
    if (session.getAttribute("error") != null){
        System.out.println(session.getAttribute("error"));
%>
<h4><%= session.getAttribute("error")%></h4>
<%}%>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
