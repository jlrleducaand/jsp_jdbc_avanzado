<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Club Baloncesto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container d-flex  text-center">
<h1 class="col"><%= "CLUB DE BALONCESTO" %>
</h1>
</div>
<br/>
<div class="container d-flex justify-content-center">
<a href="entrenamiento.jsp" class="col-3 btn btn-primary m-2">Menu Entrenamiento</a>
<br>
<a href="listadoSocios.jsp" class="col-3 btn btn-primary m-2">Listado de Socios</a>
<br>
<a href="formularioSocio.jsp" class="col-3 btn btn-primary m-2">Fomulario de Socio Nuevo</a>
<br>
<a href="pideNumeroSocio.jsp" class="col-3 btn btn-primary m-2 ">Crud de Socios</a>
</div>
<br>
<div>
<form class="container" action="detalleSocio.jsp">
    <label class=" bg-primary  m-2 rounded p-2 text-white">Carga Socio con ID:</label>
    <input type="text" name="socioID">
    <input type="submit" value="Enviar">
</form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>