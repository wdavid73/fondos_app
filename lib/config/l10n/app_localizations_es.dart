// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Español';

  @override
  String get general => 'General';

  @override
  String get name => 'Nombre';

  @override
  String get email => 'Correo';

  @override
  String get home => 'Inicio';

  @override
  String greeting(Object name) {
    return 'Hola $name!';
  }

  @override
  String get error => '¡Error!';

  @override
  String get loading => 'Cargando...';

  @override
  String get notFoundItem => '¡No se han encontrado elementos!';

  @override
  String get save => 'Guardar';

  @override
  String get update => 'Actualizar';

  @override
  String get delete => 'Eliminar';

  @override
  String get close => 'Cerrar';

  @override
  String get open => 'Abrir';

  @override
  String get edit => 'Editar';

  @override
  String get notUser => 'Sin usuario';

  @override
  String get endList => 'Has llegado al final de la lista.';

  @override
  String get maintenanceApp => 'App en Mantenimiento';

  @override
  String get errorApp =>
      'No se pudo comprobar si hay una nueva versión disponible. Asegúrate de tener conexión a internet e inténtalo de nuevo.';

  @override
  String get newVersionAvailable => 'Nueva version disponible';

  @override
  String get updateNow => '¡Actualiza ahora!';

  @override
  String get updateMessage =>
      '¡Actualización disponible! Toca para descargar la última versión y disfrutar de la mejor experiencia.';

  @override
  String get accountDetails => 'Detalles de cuenta';

  @override
  String get comingSoon => 'Próximamente...';

  @override
  String get signInAccount => 'Acceda a su cuenta';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get signUp => 'Regístrate';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get notHaveAccount => '¿No tienes cuenta?';

  @override
  String get createOneHere => 'Crea una aquí';

  @override
  String get password => 'Contraseña';

  @override
  String get newPassword => 'Nueva Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get forgetPassword => '¿Olvidaste tu contraseña?';

  @override
  String get recoveryPassword => 'Recuperar contraseña';

  @override
  String get signInFailed => 'Inicio de sesión fallido';

  @override
  String get confirmEmail => 'Confirmar Email';

  @override
  String get confirmEmailMsg =>
      'Por favor ingrese su correo electrónico, para verificar que existe y seguir con su proceso de restablecimiento de contraseña';

  @override
  String get passwordUpdate => 'Contraseña actualizada correctamente';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get signInWithApple => 'Iniciar sesión con ID de Apple';

  @override
  String get emailAddress => 'Correo electrónico';

  @override
  String get acceptBtn => 'Aceptar';

  @override
  String get cancelBtn => 'Cancelar';

  @override
  String get itsEmpty => '¡Uy! Está vacío';

  @override
  String get notFoundTitle => 'No encontrado';

  @override
  String get notFoundInfo => 'No pudimos encontrar lo que buscabas';

  @override
  String get registerSuccess => 'Registro satisfactorio';

  @override
  String get registerError => 'Se ha producido un error durante el registro';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get reportBug => 'Reportar un error';

  @override
  String get sendFeedback => 'Enviar feedback';

  @override
  String get account => 'Cuenta';

  @override
  String get deleteAccount => 'Borrar cuenta';

  @override
  String get feedback => 'Feedback';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get permission => 'Permisos';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get connectionTimeOut =>
      'La solicitud de conexión tardó mucho tiempo y fue abortada.';

  @override
  String get sendTimeOut =>
      'La solicitud de conexión tardó mucho tiempo y fue abortada.';

  @override
  String get receiveTimeOut =>
      'La conexión se ha interrumpido, inténtelo de nuevo.';

  @override
  String get connectionError => 'Error de conexión.';

  @override
  String get badCertificate => 'Mal certificado';

  @override
  String get badResponse =>
      'Respuesta con un código de estado no estándar, posiblemente debido al software del servidor.';

  @override
  String get unknown =>
      'Se ha producido un error desconocido al procesar la solicitud.';

  @override
  String get cancel =>
      'La solicitud ha sido cancelada manualmente por el usuario.';

  @override
  String get notInternet =>
      'No se ha detectado conexión a Internet, inténtelo de nuevo.';

  @override
  String get imageNotFound => 'Imagen no encontrada';

  @override
  String get errorGetImage => 'Error obteniendo la imagen.';

  @override
  String get skip => 'Saltar';

  @override
  String get done => 'Hecho';

  @override
  String get back => 'Volver';

  @override
  String get next => 'Siguiente';

  @override
  String get isRequired => 'El campo es requerido';

  @override
  String get isEmpty => 'Por favor llene el campo';

  @override
  String get isEmptyList => 'Por favor seleccione al menos un elemento';

  @override
  String get isEmptySelect => 'Por favor seleccione un elemento';

  @override
  String get isEmail => 'Por favor ingrese un correo valido';

  @override
  String get isNotEqual => 'Los valores no son iguales';

  @override
  String get isNotEqualPassword => 'Las contraseñas no coinciden';

  @override
  String get isPasswordLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get isInvalidPasswordPattern =>
      'La contraseña debe contener entre 6 y 20 caracteres, incluir mayúscula, minúscula y número.';

  @override
  String get fullnameLabel => 'Nombre Completo';

  @override
  String get fullnameHint => 'Ingresa tu nombre completo';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Ingresa tu email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Ingresa tu contraseña';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmPasswordHint => 'Confirmar tu contraseña';

  @override
  String get selectAnOption => 'Selecciona una opción';

  @override
  String get selectAnOptionDisabled =>
      'Seleccionar una opción esta deshabilitada';

  @override
  String get networkRequestFailed =>
      'Error de red. Verifica tu conexión a internet.';

  @override
  String get errorNetworkRequestFailed =>
      'Error de red. Verifica tu conexión a internet.';

  @override
  String get tooManyRequests =>
      'Demasiadas solicitudes. Intenta de nuevo más tarde.';

  @override
  String get errorTooManyRequests =>
      'Demasiadas solicitudes. Intenta de nuevo más tarde.';

  @override
  String get userDisabled => 'Esta cuenta de usuario ha sido deshabilitada.';

  @override
  String get errorUserDisabled =>
      'Esta cuenta de usuario ha sido deshabilitada.';

  @override
  String get operationNotAllowed =>
      'La operación no está permitida. Verifica la configuración de tu proveedor de autenticación en Firebase.';

  @override
  String get errorOperationNotAllowed =>
      'La operación no está permitida. Verifica la configuración de tu proveedor de autenticación en Firebase.';

  @override
  String get internalError =>
      'Ocurrió un error interno inesperado. Intenta de nuevo más tarde.';

  @override
  String get errorInternalError =>
      'Ocurrió un error interno inesperado. Intenta de nuevo más tarde.';

  @override
  String get invalidEmail => 'El formato del correo electrónico no es válido.';

  @override
  String get errorInvalidEmail =>
      'El formato del correo electrónico no es válido.';

  @override
  String get userNotFound =>
      'No se encontró un usuario con este correo electrónico.';

  @override
  String get errorUserNotFound =>
      'No se encontró un usuario con este correo electrónico.';

  @override
  String get wrongPassword => 'La contraseña es incorrecta.';

  @override
  String get errorWrongPassword => 'La contraseña es incorrecta.';

  @override
  String get invalidCredential =>
      'Credenciales incorrectas. Verifica tu correo y contraseña.';

  @override
  String get errorInvalidCredential =>
      'Credenciales incorrectas. Verifica tu correo y contraseña.';

  @override
  String get accountExistsWithDifferentCredential =>
      'Ya existe una cuenta con este correo, pero con un método de inicio de sesión diferente (ej. Google, Facebook).';

  @override
  String get errorAccountExistsWithDifferentCredential =>
      'Ya existe una cuenta con este correo, pero con un método de inicio de sesión diferente.';

  @override
  String get multiFactorAuthRequired =>
      'Se requiere autenticación de múltiples factores para completar la operación.';

  @override
  String get errorMultiFactorAuthRequired =>
      'Se requiere autenticación de múltiples factores para completar la operación.';

  @override
  String get emailAlreadyInUse => 'Este correo electrónico ya está registrado.';

  @override
  String get errorEmailAlreadyInUse =>
      'Este correo electrónico ya está registrado.';

  @override
  String get weakPassword =>
      'La contraseña es demasiado débil (debe tener al menos 6 caracteres).';

  @override
  String get errorWeakPassword =>
      'La contraseña es demasiado débil (debe tener al menos 6 caracteres).';

  @override
  String get requiresRecentLogin =>
      'Esta acción requiere que hayas iniciado sesión recientemente. Por favor, vuelve a iniciar sesión.';

  @override
  String get errorRequiresRecentLogin =>
      'Esta acción requiere que hayas iniciado sesión recientemente. Por favor, vuelve a iniciar sesión.';

  @override
  String get errorTimeout => 'Se agotó el tiempo de espera de la operación.';

  @override
  String get errorUserTokenExpired =>
      'Tu sesión ha expirado. Por favor, inicia sesión de nuevo.';

  @override
  String get errorInvalidUserToken =>
      'Tu sesión no es válida. Por favor, inicia sesión de nuevo.';

  @override
  String get search => 'Buscar';

  @override
  String get recommendationsForYou => 'Recomendaciones para ti';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get favorites => 'Favoritos';

  @override
  String get noSuggestions => 'No hay sugerencias...';

  @override
  String get detail => 'Detalle';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get tryAgain => 'Try again';
}
