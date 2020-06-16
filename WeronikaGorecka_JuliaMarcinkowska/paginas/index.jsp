<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <title>Start page</title>
  <link rel="stylesheet" href="bootstrap-4.5.0/css/bootstrap.min.css"/>
  <script src="bootstrap-4.5.0/js/jQuery-3.5.1.js"></script>
  <script src="bootstrap-4.5.0/js/bootstrap.min.js"></script>

  <style>
    html,
    body {
      height: 100%;
    }
  </style>
</head>

<div class="d-flex bd-highlight m-3">
  <a href="contact_info.html" class="btn btn-lg btn-dark mr-auto">Contact</a>
  <a href="signin.html" class="btn btn-lg btn-dark mr-1">Sign in</a>
  <a href="registration.html" class="btn btn-lg btn-outline-dark mr-1">Sign up</a>
</div>

<body class="text-center">
<div class="d-flex">
  <img src="resources/bus_icon.png" class="mx-auto" style="width: 250px;"/>
</div>
<div class="container my-5 mx-auto">
  <div id="indicator" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#indicator" data-slide-to="0" class="active"></li>
      <li data-target="#indicator" data-slide-to="1"></li>
      <li data-target="#indicator" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item">
        <img src="resources/lis_cb.png" class="d-block w-80">
      </div>
      <div class="carousel-item active">
        <img src="resources/bus_inside.jpg" class="d-block w-80">
      </div>
      <div class="carousel-item">
        <img src="resources/bus_cliff.jpg" class="d-block w-80">
      </div>
    </div>
    <a class="carousel-control-prev" href="#indicator" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#indicator" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
<div class="jumbotron d-flex justify-content-center">
  <div class="container">
    <h1 class="display-4">Contact information</h1>
    <p class="lead">
    <h3><b>CBBus</b> <br></h3>
    <div class="d-flex justify-content-center">
      <table>
        <tr>
          <th></th>
          <th></th>
        </tr>
        <tr>
          <td class="pr-lg-5"><b>Adress:</b></td>
          <td class="pl-lg-5">Av. 1 de Maio 235,<br>6000-086 Castelo Branco</td>
        </tr>
        <tr>
          <td class="pr-lg-5"><b>Contact:</b></td>
          <td class="pl-lg-5">info@cbbus.pt<br>+351 695 246 213</td>
        </tr>
        <tr>
          <td class="pr-lg-5"><b>Operating hours:</b></td>
          <td class="pl-lg-5">Monday to friday: 9.00 am to 19.00 pm <br>
            Saturday: 10.00 am to 14.00 <br>
            Sunday: Closed
          </td>
        </tr>
      </table>
    </div>
    </p>
  </div>
</div>
</body>
</html>
