<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "musica_digital";

$conexion= new mysqli($servername, $username, $password, $dbname);
if ($conexion->connect_error) {
    die("La conexión a la base de datos falló: " . $conexion->connect_error);
}
?>
