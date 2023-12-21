<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
<div class="container ">
<h2 class=" text-center">Introduzca los datos del nuevo socio:</h2>
<form class="container text-center " method="post" action="grabaSocio.jsp">
  <!--LOS VALORES NO LOS RESCATA POR QUE EN LA VALIDACION NO SE GRABAN HASTA QUE NO ESTAN TODOS CORRECTOS (BUSCAR OTRO METODO)  estan comentados -->
  <div><label class="col-2 bg-secondary  rounded m-2 p-2 text-white">Nº socio</label> <input class="col-4 p-2 m-2"type="text" name="numero"></div>  </br>
  <div><label class="col-2 bg-secondary  rounded m-2 p-2 text-white">Nombre</label>   <input class="col-4 p-2 m-2"type="text" name="nombre"></div>  </br>
  <div><label class="col-2 bg-secondary  rounded m-2 p-2 text-white">Estatura</label> <input class="col-4 p-2 m-2"type="text" name="estatura"></div>  </br>
  <div><label class="col-2 bg-secondary  rounded m-2 p-2 text-white">Edad</label>     <input class="col-4 p-2 m-2"type="text" name="edad"></div>  </br>
  <div><label class="col-2 bg-secondary  rounded m-2 p-2 text-white">Localidad</label><input class="col-4 p-2 m-2"type="text" name="localidad"></div>  </br>

  <div class="text-center "><input class="col-6 p-2 m-2 btn btn-warning text-center" type="submit" value="Aceptar"></div></form>

    <form class="container text-center" method="get" action="index.jsp">
      <input class="col-6 p-2 m-2 btn btn-primary flex-grow text-center" type="submit" value="Volver">
    </form>



<%
    if (session.getAttribute("error") != null){
  System.out.println(session.getAttribute("error"));
%>
<h4 class="text-center"><%= session.getAttribute("error")%></h4>
<%}%>

</div>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>