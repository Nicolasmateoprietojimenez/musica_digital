const formulario = document.querySelector('.formulario');
const inputs = document.querySelectorAll('.formulario__input');

const expresiones = {
    correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
    contrasena: /^.{4,12}$/ // 4 a 12 caracteres
};

const campos = {
    correo: false,
    contrasena: false
};

function validarCampo(expresion, valor, grupo) {
    const grupoElemento = document.getElementById(`formulario__grupo-${grupo}`);
    const icono = grupoElemento.querySelector('i');
    const errorTexto = grupoElemento.querySelector('.formulario__input-error');

    if (expresion.test(valor.value)) {
        grupoElemento.classList.remove('formulario__grupo-incorrecto');
        grupoElemento.classList.add('formulario__grupo-correcto');
        icono.classList.add('fa-duotone', 'fa-circle-check');
        icono.classList.remove('fa-circle-xmark');
        errorTexto.classList.remove('formulario__input-error-activo');
        errorTexto.classList.remove('formulario__grupo-error-activo');
        campos[grupo] = true;
    } else {
        grupoElemento.classList.add('formulario__grupo-incorrecto');
        grupoElemento.classList.remove('formulario__grupo-correcto');
        icono.classList.remove('fa-duotone', 'fa-circle-check');
        icono.classList.add('fa-circle-xmark');
        errorTexto.classList.add('formulario__grupo-error-activo');
        campos[grupo] = false;
    }
}

function validarFormulario(e) {
    switch (e.target.name) {
        case "correo":
            validarCampo(expresiones.correo, e.target, 'correo');
            break;
        case "contrasena":
            validarCampo(expresiones.contrasena, e.target, 'contrasena');
            break;
    }
}

inputs.forEach((input) => {
    input.addEventListener('keyup', validarFormulario);
    input.addEventListener('blur', validarFormulario);
});

formulario.addEventListener('submit', (e) => {
    e.preventDefault();

    if (campos.correo && campos.contrasena) {
        formulario.submit();
    } else {
        const mensajeError = document.querySelector('.formulario__mensaje');
        mensajeError.classList.add('formulario__mensaje-activo');
        mensajeError.innerHTML = '<p><i class="fa-solid fa-triangle-exclamation"></i> <b>Error</b> Por favor complete todos los campos correctamente.</p>';
    }
});
