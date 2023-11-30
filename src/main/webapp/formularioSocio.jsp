<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
<h2 class="col-6 text-center">Introduzca los datos del nuevo socio:</h2>
<form method="post" action="grabaSocio.jsp">
  <!--LOS VALORES NO LOS RESCATA POR QUE EN LA VALIDACION NO SE GRABAN HASTA QUE NO ESTAN TODOS CORRECTOS (BUSCAR OTRO METODO)  estan comentados -->
  <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Nº socio</label> <input class="col-4 "type="text" name="numero" > <!-- value="<%= request.getParameter("numero") %> "-->    </div>  </br>
  <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Nombre</label>   <input class="col-4 "type="text" name="nombre">  <!--value="<%= request.getParameter("nombre") %>"-->   </div>  </br>
  <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Estatura</label> <input class="col-4 "type="text" name="estatura"> <!-- value="<%= request.getParameter("estatura") %> "--> </div>  </br>
  <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Edad</label>     <input class="col-4 "type="text" name="edad" > <!-- value="<%= request.getParameter("edad") %> "-->     </div>  </br>
  <div class="row m-2"><label class="col-2 bg-primary m-2 rounded p-2 text-white">Localidad</label><input class="col-4 "type="text" name="localidad" > <!-- value="<%= request.getParameter("edad") %> "--> </div>  </br>

  <input class="col-6 m-2  text-center bg-warning" type="submit" value="Aceptar">
</form>
    <form method="get" action="index.jsp">
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