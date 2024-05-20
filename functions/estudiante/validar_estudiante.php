<?php
function verificarLogin($conexion, $correo, $contrasena) {
    $respuesta = array(
        'mensaje' => '',
        'url_redireccion' => ''
    );

    // Preparamos la consulta para evitar inyecciones SQL
    $query = "SELECT contrasena_estudiante, estado_estudiante FROM estudiante WHERE correo_electronico = ?";
    if ($stmt = $conexion->prepare($query)) {
        $stmt->bind_param("s", $correo);
        $stmt->execute();
        $stmt->store_result();
        
        if ($stmt->num_rows > 0) {
            $stmt->bind_result($contrasenaHash, $estado);
            $stmt->fetch();
            
            if (password_verify($contrasena, $contrasenaHash)) {
                if ($estado == 1) {
                    $respuesta['mensaje'] = "Login exitoso";
                    $respuesta['url_redireccion'] = '../../index.html'; 
                } else {
                    $respuesta['mensaje'] = "Cuenta inactiva";
                    $respuesta['url_redireccion'] = '../../index.html'; // URL de redirección en caso de cuenta inactiva
                }
            } else {
                $respuesta['mensaje'] = "Contraseña incorrecta";
                $respuesta['url_redireccion'] = '../../index.html'; // URL de redirección en caso de contraseña incorrecta
            }
        } else {
            $respuesta['mensaje'] = "Correo no registrado";
            $respuesta['url_redireccion'] = '../../index.html'; // URL de redirección en caso de correo no registrado
        }

        $stmt->close();
    } else {
        $respuesta['mensaje'] = "Error en la consulta";
        $respuesta['url_redireccion'] = '../../index.html';
    }

    return $respuesta;
}
?>
