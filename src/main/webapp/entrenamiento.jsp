<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP Entrenamientos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container d-flex  text-center">
    <h1 class="col"><%= "Entrenamientos" %>
    </h1>
</div>
<br/>
<div class="container d-flex justify-content-between">

    <a href="listadoEntrenamiento.jsp" class="col-4 btn btn-primary m-2">Listado de Entrenamiento</a>
    <br>
    <a href="formularioEntrenamiento.jsp" class="col-4 btn btn-primary m-2">Fomulario de Entrenamiento Nuevo</a>
    <br>
    <a href="pideNumeroEntrenamiento.jsp" class="col-4 btn btn-primary m-2 ">Pide número de Entrenamiento</a>
</div>
<br>
<div class="row justify-content-center">

    <form action="detalleEntrenamiento.jsp" class="container">
        <label class=" bg-primary  m-2 rounded p-2 text-white">Carga Entrenamiento con ID:</label>
        <input type="text" name="entrenamientoID">
        <input type="submit" value="Enviar" class="v">
    </form>

    <form  action="index.jsp" >
        <input  type="submit" value="Volver" >
    </form>

</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
