const formulario = document.getElementById('formulario');
const inputs = document.querySelectorAll('#formulario input')


const expresiones = {
	// usuario: /^[a-zA-Z0-9\_\-]{4,16}$/, // Letras, numeros, guion y guion_bajo
	nombre: /^[a-zA-ZÀ-ÿ\s]{1,40}$/, // Letras y espacios, pueden llevar acentos.
	password: /^.{4,12}$/, // 4 a 12 digitos.
	correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
	edad: /^(?:[7-9]|[1-9]\d|100)$/
}

const campos = {
    nombre: false,
    apellido: false,
    edad: false,
    correo: false,
    contrasena1: false
}

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

function validarContrasena() {
    const inputPass1 = document.getElementById('contrasena');
    const inputPass2 = document.getElementById('contrasena2');
    const grupoElemento = document.getElementById('formulario__grupo-contrasena2');
    const icono = grupoElemento.querySelector('i');
    const errorTexto = grupoElemento.querySelector('.formulario__input-error');

    if (inputPass1.value === inputPass2.value) {
        grupoElemento.classList.remove('formulario__grupo-incorrecto');
        grupoElemento.classList.add('formulario__grupo-correcto');
        icono.classList.add('fa-duotone', 'fa-circle-check');
        icono.classList.remove('fa-circle-xmark');
        errorTexto.classList.remove('formulario__input-error-activo');
        errorTexto.classList.remove('formulario__grupo-error-activo');
        campos['contrasena1'] = true;
    } else {
        grupoElemento.classList.add('formulario__grupo-incorrecto');
        grupoElemento.classList.remove('formulario__grupo-correcto');
        icono.classList.remove('fa-duotone', 'fa-circle-check');
        icono.classList.add('fa-circle-xmark');
        errorTexto.classList.add('formulario__grupo-error-activo');
        campos['contrasena1'] = false;
    }
}

const validarFormulario =(e)=>{
    switch(e.target.name){
        case "nombre":
            validarCampo(expresiones.nombre, e.target, 'nombre');
        break;
        
        case "apellido":
            validarCampo(expresiones.nombre, e.target, 'apellido');
        break;
        case "edad":
            validarCampo(expresiones.edad, e.target, 'edad');
        break;
        case "correo":
            validarCampo(expresiones.correo, e.target, 'correo');
        break;
        case "contrasena":
            validarCampo(expresiones.password, e.target, 'contrasena');
        break;
        case "contrasena2":
            validarContrasena();
        break;
        
    }
};


inputs.forEach((input)=>{
    input.addEventListener('keyup', validarFormulario);
    input.addEventListener('blur', validarFormulario);
});

formulario.addEventListener('submit', (e)=>{
    e.preventDefault();

    const terminos =document.getElementById('terminos')
    if(campos.nombre && campos.apellido && campos.edad && campos.correo && campos.contrasena1 && terminos.checked){
        formulario.submit(); 
    }else{
        document.getElementById('formulario__mensaje').classList.add('formulario__mensaje-activo')
    }
});