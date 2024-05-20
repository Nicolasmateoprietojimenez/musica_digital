<?php
include '../../functions/conexion.php';
include '../../functions/estudiante/validar_estudiante.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];

    $usuario = verificarLogin($conexion, $correo, $contrasena);
    $conexion->close();

    $_SESSION['mensaje'] = $usuario['mensaje'];
    $_SESSION['url_redireccion'] = $usuario['url_redireccion'];

    header("Location: " . $_SERVER['PHP_SELF']);
    exit();
}

if (isset($_SESSION['mensaje'])) {
    echo '<script>alert("' . $_SESSION['mensaje'] . '");</script>';
    $url_redireccion = $_SESSION['url_redireccion'];

    unset($_SESSION['mensaje']);
    unset($_SESSION['url_redireccion']);
    
    echo '<script>window.location.href="' . $url_redireccion . '";</script>';
}
?>
