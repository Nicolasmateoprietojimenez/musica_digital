<?php
include '../functions/conexion.php';
include '../functions/estudiante/crear_nuevo_estudiante.php';

// Verificamos si se ha enviado el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtenemos los valores del formulario
    $correo = $_POST["correo"];
    $pin = $_POST["pin"];

    // Verificamos la conexión
    if ($conexion->connect_error) {
        die("Conexión fallida: " . $conexion->connect_error);
    }

    // Llamamos al procedimiento almacenado para obtener el ID del estudiante
    $sql = "CALL ObtenerIdEstudiantePorCorreo(?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("s", $correo);
    $stmt->execute();
    $stmt->bind_result($id_estudiante);

    if ($stmt->fetch()) {
        // echo "ID del estudiante encontrado: " . $id_estudiante;
        $stmt->close();

        // Verificamos el PIN
        $mensaje_verificacion = verificarPin($conexion, $id_estudiante, $pin);

        // Mostramos el mensaje en un alert script
        echo "<script>";
        echo "alert('".$mensaje_verificacion['mensaje']."');";
        if (!is_null($mensaje_verificacion['url'])) {
            echo "window.location.href = '".$mensaje_verificacion['url']."';";
        }
        echo "</script>";

    } else {
        echo "No se encontró ningún estudiante con el correo proporcionado.";
    }

    // Cerramos la conexión y liberamos los recursos
    $conexion->close();
}
?>
