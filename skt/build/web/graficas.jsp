    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="Conexion.*" %>
    <%@page import="javax.servlet.http.HttpSession"%>
    <% HttpSession sesion = request.getSession(true); %>
    <%
        if(sesion.isNew() || sesion == null) {
            response.sendRedirect("index.html");
            return;
        }
    %>
    <%String tipou = (String) sesion.getAttribute("tipou");%>

    <% if(sesion.isNew() || sesion==null)
        {
        response.sendRedirect("index.html");
        return;
        }
    %>
    <%

        if (tipou == null || tipou.equals("0") || tipou.equals("4")) {
        response.sendRedirect("index.html");
        return;
    }

    %>

    <!DOCTYPE html>
    <%
        Conexion pal = new Conexion();
        Connection con = pal.getConnection();
        Statement stmth = con.createStatement();
        Statement stmt2 = con.createStatement();
        ResultSet rs = stmth.executeQuery("select rbd_niv FROM resultadobd"); 
        ResultSet rs2 = stmt2.executeQuery("select rpo_niv FROM resultadopo"); 

        String nivel, nivel2;
        int pooavz = 0, pooint = 0, poomed = 0, poomin = 0;
        int bdavz = 0, bdint = 0, bdmed = 0, bdmin = 0;

        while (rs.next()) {
            nivel = rs.getString("rbd_niv");
            if(nivel.equals("3")) {
                pooavz++;
            } else if(nivel.equals("2")) {
                pooint++;
            } else if(nivel.equals("1")) {
                poomed++;
            } else if(nivel.equals("0")) {
                poomin++;
            }
        }

        while (rs2.next()) {
            nivel2 = rs2.getString("rpo_niv");
            if(nivel2.equals("3")) {
                bdavz++;
            } else if(nivel2.equals("2")) {
                bdint++;
            } else if(nivel2.equals("1")) {
                bdmed++;
            } else if(nivel2.equals("0")) {
                bdmin++;
            }
        }
    %>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Grafica de POO</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/Chart.min.css">
        <link rel="stylesheet" href="css/graf.css">
        <link rel="stylesheet" href="css/grafivasr.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"></script>
        <link rel="shortcut icon" href="./assets/logo1.png" />
    </head>
    <body>
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Niveles y su Cálculo</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                    Para poder asignar un nivel a los conocimientos de los egresados, con base a los resultados obtenidos en los formularios respondidos, seguimos la siguiente escala: <br> <br>Nivel avanzado 80% de aciertos o superior <br> <br>Nivel intermedio menor a 80% y mayor a 60% <br><br>Nivel básico menor a 60% y mayor a 40%  <br><br>Nivel mínimo menor a 40% <br><br>Esta escala aplica para ambos formularios, el porcentaje se obtendrá mediante la suma del valor de todos los aciertos que obtuvo dividido entre la suma total de los valores de los aciertos del examen y el resultado se multiplicará por 100.
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <header>
            <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
            <p class="h21">Skill-tech</p>
            <div class="Boton" id="alinearder"><form action="Cerrar" method="post"><input type="submit" value="Cerrar Sesión" class="BotonCe"></form></div>
        </header>
    <div style="width: 100%; height: 100%; padding-bottom: 13px; padding-left: 24px; padding-right: 808px; background: white; box-shadow: 0px -3px 0px #1589EE inset; justify-content: flex-start; align-items: center; display: inline-flex">
                <div style="justify-content: flex-start; align-items: center; gap: 24px; display: inline-flex">
                    <div class="fontdiv">
                        <%if(tipou.equals("1") ){%>
                        
                        <div class="flujo2">
                            <a href="graficas.jsp"><img class="imgflujo2" src="./assets/grafico-circular (1).png"><P class="txtflujo2">Gráficas</P></a>
                        </div>
                        <div class="flujo31">
                            <a href="repor.jsp"><img class="imgflujo4" src="./assets/reporte.png"><P class="txtflujo4">Reportes</P></a>
                        </div>
                        <%}else if(tipou.equals("2")){%>
                        <div class="flujo">
                            <a href="Editform.jsp"> <img class="imgflujo" src="./assets/formulario-de-contacto.png"><P class="txtflujo">Edición de formularios</P></a>
                        </div>
                        <div class="flujo">
                            <a href="graficas.jsp"><img class="imgflujo2" src="./assets/grafico-circular (1).png"><P class="txtflujo2">Gráficas</P></a>
                        </div>
                    <div class="flujo21">
                            <a href="bita.jsp"><img class="imgflujo3" src="./assets/archivo.png"><P class="txtflujo3">Bitacora</P></a>
                        </div>
                        
                        <%}%>
                    </div>
                </div>
            </div>
        <nav>
            <div class="nav-container">
                    <div class="fontdiv"><h2>Graficas Generales</h2></div>
            </div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" id="myInput">
               ?
            </button>
        </nav>
            <div class="alincentro"><h4 id='borde'>A continuación se muestran las gráficas de los egresados evaluados en las areas de programación y bases de datos:</h4></div>
        <section class="bodyg">
        <div class="a">
            <div class="titulo">POO</div>
                <div id="graficaPOO" class="grafica-container">
                <canvas class="grafica" ></canvas>
            </div>
            <div class="layoutgr"> <div class="alineatext"><br><br><img src="assets/rectangulo avanzado.jpg" class="alinearrec"> Avanzado <br><br> <img src="assets/rectangulo intermedio.png" class="alinearrec">Intermedio <br><br> <img src="assets/rectangulo basico.png" class="alinearrec">Basico <br><br> <img src="assets/rectangulo minimo.png" class="alinearrec">Minimo </div></div>
        </div>
        <div class="a">
            <div class="titulo">BD</div>
                <div id="graficaBD" class="grafica-container">
                <canvas class="grafica"></canvas>
            </div>
            <div class="layoutgr"> <div class="alineatext"><br><br><img src="assets/rectangulo avanzado.jpg" class="alinearrec"> Avanzado <br><br> <img src="assets/rectangulo intermedio.png" class="alinearrec">Intermedio <br><br> <img src="assets/rectangulo basico.png" class="alinearrec">Basico <br><br> <img src="assets/rectangulo minimo.png" class="alinearrec">Minimo </div></div>
        </div>
        
        </section>
            <div class="reporte">
            <form method="POST" action="gen">
                
            <a><input class="Botonab" type="submit" value="2020" name="gene"></a>      
            <a><input class="Botonab" type="submit" value="2021" name="gene1"></a>
            <a><input class="Botonab" type="submit" value="2022" name="gene2"></a>
            </form>
            </div>
            
            <div class="contenedor">
        </div>

        <script>
            var NivAvanz = "<%=pooavz%>";
            var Nivint = "<%=pooint%>";
            var Nivmed = "<%=poomed%>";
            var Nivbas = "<%=poomin%>";

            var NivAvanz2 = "<%=bdavz%>";
            var Nivint2 = "<%=bdint%>";
            var Nivmed2 = "<%=bdmed%>";
            var Nivbas2 = "<%=bdmin%>";

            const xd1 = parseInt(NivAvanz);
            const xd2 = parseInt(Nivint);
            const xd3 = parseInt(Nivmed);
            const xd4 = parseInt(Nivbas);

            const xd5 = parseInt(NivAvanz2);
            const xd6 = parseInt(Nivint2);
            const xd7 = parseInt(Nivmed2);
            const xd8 = parseInt(Nivbas2);

            const labels = ['Avanzado', 'Intermedio', 'Básico', 'Mínimo'];
            const colors = ['#20516F', '#585bb2', '#56D0FC', '#C23934'];

            const graphPOO = document.querySelector("#graficaPOO .grafica");
            const graphBD = document.querySelector("#graficaBD .grafica");

            const dataPOO = {
                datasets: [{
                    data: [xd1, xd2, xd3, xd4],
                    backgroundColor: colors
                }]
            };

            const dataBD = {
                datasets: [{
                    data: [xd5, xd6, xd7, xd8],
                    backgroundColor: colors
                }]
            };

            const configPOO = {
                type: 'pie',
                data: dataPOO
            };

            const configBD = {
                type: 'pie',
                data: dataBD
            };

            new Chart(graphPOO, configPOO);
            new Chart(graphBD, configBD);
        </script>
        <script>
            const myModal = document.getElementById('staticBackdrop')
    const myInput = document.getElementById('myInput')

    myModal.addEventListener('shown.bs.modal', () => {
    myInput.focus()
    })
        </script>
    </body>
    </html>