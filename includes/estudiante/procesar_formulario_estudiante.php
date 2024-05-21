<?php

include '../../functions/conexion.php';
include '../../functions/estudiante/crear_nuevo_estudiante.php';
include '../../functions/generar_correo_validacion.php';

function generarPIN() {
    return str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
}



if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo = $_POST["correo"];
    $contrasena = $_POST["contrasena"];
    $nombreCompleto = strtolower($_POST["nombre"]);
    $apellidoCompleto = strtolower($_POST["apellido"]);
    
    $estado = 0;
    $nombreUsuario = "";
    $avatar = "";
    $edad = $_POST["edad"];

    $nombres = explode(" ", $nombreCompleto);
    $apellidos = explode(" ", $apellidoCompleto);

    $nombre1 = $nombres[0];
    $apellido1 = $apellidos[0];

    $nombre2 = isset($nombres[1]) ? $nombres[1] : "";
    $apellido2 = isset($apellidos[1]) ? $apellidos[1] : "";

    $contrasena_hash = password_hash($contrasena, PASSWORD_DEFAULT);

    $stmt = $conexion->prepare("SELECT correo_electronico FROM estudiante WHERE correo_electronico = ?");
    $stmt->bind_param("s", $correo);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        echo "<script>alert('El correo electrónico ya está registrado.');</script>";
    } else {
        try {
            // Generar un PIN de 6 dígitos
            $pin = generarPIN();
            
            if (insertarEstudiante($conexion, $correo, $contrasena_hash, $nombre1, $nombre2, $apellido1, $apellido2, $estado, $nombreUsuario, $avatar, $edad)) {
                $id_estudiante = $conexion->insert_id;
                
                if (crearPin($conexion, $id_estudiante, $pin)) {
                    if (enviarCorreoBienvenida($nombre1, $apellido1, $correo, $pin)) {
                        echo "<script>alert('¡Solo un paso más! Activa tu cuenta con el mensaje que enviamos a tu correo.');</script>";
                        echo "<script>window.location.replace('../../public/login/formulario_registro.html');</script>";
                    } else {
                        echo "<script>alert('Error al enviar el correo de bienvenida.');</script>";
                        echo "<script>window.location.replace('../../public/login/formulario_registro.html');</script>";
                    }
                } else {
                    echo "<script>alert('Error al insertar el PIN de verificación.');</script>";
                    echo "<script>window.location.replace('../../public/login/formulario_registro.html');</script>";
                }
            } else {
                echo "<script>alert('Error al insertar el estudiante.');</script>";
                echo "<script>window.location.replace('../../public/login/formulario_registro.html');</script>";
            }
        } catch (Exception $e) {
            echo "<script>alert('Error: " . $e->getMessage() . "');</script>";
            echo "<script>window.location.replace('../../public/login/formulario_registro.html');</script>";
        }
    }
} else {
    echo "<script>alert('No se recibieron datos del formulario.');</script>";
    echo "<script>window.location.replace('../../public/login/formulario_registro.html');</script>";
}

?>
