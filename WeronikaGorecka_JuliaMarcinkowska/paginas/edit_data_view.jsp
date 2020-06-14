<%--<?php--%>
<%--session_start();--%>
<%--if (!isset($_SESSION["user"]) || !isset($_SESSION["type"]) || $_SESSION["type"] == -1) {--%>
<%--    echo "Error, you are not logged in, redirecting to main page.";--%>
<%--    header('refresh:2; url=index.html');--%>
<%--    exit();--%>
<%--}--%>
<%--?>--%>

<!doctype html>
<html lang="en">
<head>
    <title>Edit personal information</title>
    <link rel="stylesheet" href="bootstrap-4.5.0/css/bootstrap.min.css"/>

    <style>
        html,
        body {
            height: 100%;
        }

        body {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-align: center;
            align-items: center;
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            width: 100%;
            max-width: 330px;
            padding: 15px;
            margin: auto;
        }

        .form-signin .form-control {
            position: relative;
            box-sizing: border-box;
            height: auto;
            padding: 10px;
            font-size: 16px;
        }

        .form-signin .form-control:focus {
            z-index: 2;
        }

    </style>
</head>
<body class="text-center">

<div class="align-content-md-center ml-auto">
    <img src="resources/bus_icon.png">
</div>
<div>
<%--    <?php--%>
<%--    include "../basedados/basedados.h";--%>

<%--    $user_id = $_GET["user_id"];--%>
<%--    global $conn;--%>
<%--    $sql = "SELECT * FROM users WHERE ID=" . $user_id;--%>
<%--    $retval = mysqli_query($conn, $sql);--%>
<%--    if (!$retval) {--%>
<%--        die('Could not get data: ' . mysqli_error($conn));--%>
<%--    }--%>
<%--    $row = mysqli_fetch_array($retval);--%>
<%--    $name = $row["name"];--%>
<%--    $email = $row["email"];--%>
<%--    $login = $row["login"];--%>
<%--    $password = $row["password"];--%>
    ?>
</div>
<form class='form-signin' action='edit_data.php' method='post'>
    <h1 class='h3 mb-3 font-weight-normal'>Edit personal information</h1>
    <input type='text' name='name' class='form-control mt-lg-1' placeholder="Name" value='<?php echo $name; ?>'
           autofocus required/>
    <input type='email' name='email' class='form-control mt-lg-1' placeholder="Email" value='<?php echo $email; ?>'
           required/>
    <input type='text' name='login' class='form-control mt-lg-1' placeholder="Login" value='<?php echo $login; ?>'
           required/>
    <input type='password' name='password' class='form-control mt-lg-1' placeholder="Password"
           value='<?php echo $password; ?>' required/>
    <input type = 'hidden' name='user' value='<?php echo $user_id; ?>'/>
    <button class='btn btn-lg btn-primary btn-block mt-lg-1' type='submit'>Submit</button>
</form>

</body>
</html>
