<?php

function insertarEstudiante($conexion, $correo, $contrasena, $nombre1, $nombre2, $apellido1, $apellido2, $estado, $nombreUsuario, $avatar, $edad) {
    try {
        $consulta = "INSERT INTO estudiante (correo_electronico, contrasena_estudiante, nombre1, nombre2, apellido1, apellido2, estado_estudiante, nombre_usuario, avatar, edad) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        $stmt = $conexion->prepare($consulta);
        
        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $conexion->error);
        }
        
        $stmt->bind_param("ssssssissi", $correo, $contrasena, $nombre1, $nombre2, $apellido1, $apellido2, $estado, $nombreUsuario, $avatar, $edad);
        
        if (!$stmt->execute()) {
            throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
        }
        
        return true;
    } catch (Exception $e) {
        echo "<script>alert('Error al insertar estudiante: " . $e->getMessage() . "');</script>";
        return false;
    }
}


function verificarPin($conexion, $id_estudiante, $pin) {
    try {
        $consulta = "SELECT pin FROM pin_verificacion WHERE id_estudiante = ? ORDER BY fecha_creacion_pin DESC LIMIT 1";
        $stmt = $conexion->prepare($consulta);

        if (!$stmt) {
            throw new Exception("Error al preparar la consulta: " . $conexion->error);
        }

        $stmt->bind_param("i", $id_estudiante);

        if (!$stmt->execute()) {
            throw new Exception("Error al ejecutar la consulta: " . $stmt->error);
        }

        $resultadoConsulta = $stmt->get_result();

        if ($resultadoConsulta->num_rows === 0) {
            return array("mensaje" => "No se encontró ningún PIN asociado al estudiante con ID $id_estudiante", "url" => "../../includes/procesar_activacion.php");
        }

        $fila = $resultadoConsulta->fetch_assoc();
        $ultimo_pin = $fila['pin'];

        if ($ultimo_pin == $pin) {
            // Activar la cuenta
            $stmt_activar = $conexion->prepare("CALL activarCuenta(?)");
            $stmt_activar->bind_param("i", $id_estudiante);
            $stmt_activar->execute();

            return array("mensaje" => "Cuenta activada con éxito", "url" => "../index.html");
        } else {
            return array("mensaje" => "El PIN proporcionado no coincide con el último PIN registrado para el estudiante con ID $id_estudiante", "url" => "../../includes/procesar_activacion.php");
        }
    } catch (Exception $e) {
        throw new Exception($e->getMessage());
    }
}



?>