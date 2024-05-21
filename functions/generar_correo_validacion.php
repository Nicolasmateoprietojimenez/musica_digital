<?php

require 'phpmailer/src/PHPMailer.php';
require 'phpmailer/src/Exception.php';
require 'phpmailer/src/SMTP.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

function enviarCorreoBienvenida($nombre, $apellido, $correo, $pin) {
    $mail = new PHPMailer(true);

    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'nicompj@gmail.com';
    $mail->Password = 'htpsxfgqoiubugty';
    $mail->SMTPSecure = 'tls';
    $mail->Port = 587;


    try {
    
        $mail->setFrom('nicompj@gmail.com');
        $mail->addAddress($correo);
        $mail->CharSet = 'UTF-8';
        $mail->isHTML(true);
        $mail->Subject = '¡Bienvenido!';
        $mail->Body = "
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; background-color: #f5f5f5; margin: 0; padding: 0; }
                    .container { max-width: 600px; margin: 20px auto; padding: 20px; background-color: #fff; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
                    h1 { color: #1a1a1a; text-align: center; }
                    p { color: #333; line-height: 1.6; }
                    a { color: #007bff; text-decoration: none; }
                    .pin { font-size: 24px; font-weight: bold; color: #f00; }
                </style>
            </head>
            <body>
                <div class='container'>
                    <h1>¡Bienvenido!</h1>
                    <p>Hola $nombre $apellido,</p>
                    <p>Te damos la bienvenida, la plataforma de aprendizaje musical y digital.</p>
                    <p>Para activar tu cuenta, por favor ingresa el siguiente PIN en el siguiente enlace:</p>
                    <p class='pin'>$pin</p>
                    <p><a href='http://localhost/musica_digital/other/activar_cuenta.html'>Ingresa aquí</a></p>
                    <p>¡Esperamos verte pronto!</p>
                </div>
            </body>
            </html>
        ";
        $mail->AltBody = "¡Bienvenido! Hola $nombre $apellido, te damos la bienvenida, la plataforma de aprendizaje musical y digital. Para activar tu cuenta, por favor ingresa el siguiente PIN: $pin. ¡Esperamos verte pronto!";

        $mail->send();
        return 'El mensaje se envió correctamente.';
    } catch (Exception $e) {
        return "Hubo un error al enviar el mensaje: {$mail->ErrorInfo}";
    }
}

?>
