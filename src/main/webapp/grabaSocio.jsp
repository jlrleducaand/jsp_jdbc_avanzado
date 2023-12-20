<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
    int numero = -1;
    String nombre = null;
    int estatura = -1;
    int edad = -1;
    String localidad = null;

    boolean flagValidaNumero = false;
    boolean flagValidaNombreNull = false;
    boolean flagValidaNombreBlank = false;
    boolean flagValidaEstatura = false;
    boolean flagValidaEdad = false;
    boolean flagValidaLocalidad = false;


    try {
        numero = Integer.parseInt(request.getParameter("numero"));
        flagValidaNumero = true;

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("nombre"));
        flagValidaNombreNull = true;

        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("nombre").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaNombreBlank = true;
        nombre = request.getParameter("nombre");

        edad = Integer.parseInt(request.getParameter("edad"));
        flagValidaEdad = true;

        estatura = Integer.parseInt(request.getParameter("estatura"));
        flagValidaEstatura = true;

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("localidad"));
        //CONTRACT nonBlank
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("localidad").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaLocalidad = true;
        localidad = request.getParameter("localidad");

    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaNumero) {
            session.setAttribute("error", "Error en número.");
        } else if (!flagValidaNombreNull || !flagValidaNombreBlank) {
            session.setAttribute("error", "Error en nombre.");
        } else if (!flagValidaEdad) {
            session.setAttribute("error", "Error en edad.");
        } else if (!flagValidaEstatura) {
            session.setAttribute("error", "Error en estatura.");
        } else if (!flagValidaLocalidad) {
            session.setAttribute("error", "Error en localidad.");
        }

        valida = false;  //retorna a false al caer en cualquier error
    }
    //FIN CÓDIGO DE VALIDACIÓN

    //EMPIEZA LOGICA DE CODIGO
    if (valida) {
        //OBJETOS NECESARIOS
        Connection conn = null;
        PreparedStatement ps = null; //PARAMETRIZADAS
        // ResultSet rs = null;  //NO NECESITAMOS RECUPERAR RESULTADOS DE LA QUERRY

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "1234");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conn.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO socio VALUES (" +
                    "?, " + //socioID
                    "?, " + //nombre
                    "?, " + //estatura
                    "?, " + //edad
                    "?)";   //localidad

            ps = conn.prepareStatement(sql);
            int idx = 1;
            /* se invierte el orden de ejecucion  en ps   de derecha a izquierda
             * primero  va a leer la variable de (idx inicializada)  y luego aumenta el contador idx++
            */
            ps.setInt(idx++, numero);
            ps.setString(idx++, nombre);
            ps.setInt(idx++, estatura);
            ps.setInt(idx++, edad);
            ps.setString(idx++, localidad);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);


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


        // out.println("Socio dado de alta.");
        // response.sendRedirect("detalleSocio.jsp?socioID="+numero);
        // response.sendRedirect("pideNumeroSocio.jsp?socioIDADestacar="+numero);

        session.setAttribute("socioIDADestacar", numero);
        response.sendRedirect("pideNumeroSocio.jsp");

        } else {
        //out.println("Error de validación!");

        response.sendRedirect("formularioSocio.jsp");
    }
%>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
