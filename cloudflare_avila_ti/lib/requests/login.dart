// import '../services/services.dart';

// class LoginRegister {
//   // dynamic refreshState = () {}; // To save SetState

//   dynamic context = "";
//   make(String value) {
//     switch (value) {
//       case 'login':
//         login();
//         break;
//       case 'register':
//         register();
//         break;
//       default:
//         print("NO DEFINED");
//         break;
//     }
//   }

//   login() async {
//     print("login");
//     miLogin.username = miLogin.email;
//     dynamic result =
//         await httpRequest.post(cloudflareUrls.login, miLogin.toJson());
//     if (result.containsKey("error")) {
//       if (result["error"].toString().contains("TimeoutException")) {
//         customAlertDialog(context, "No se ha podido registrar",
//             customImagePicker.failed, "Revise su conexion");
//       } else {
//         await customAlertDialog(context, "Datos incorrectos",
//             customImagePicker.failed, "Intente nuevamente");
//       }
//     } else {
//       sotoreSecureData.setData("token", result['access']);
//       sotoreSecureData.setData("refresh", result['refresh']);
//       await customAlertDialog(
//           context, "Bienvenido !", customImagePicker.success, "");
//       drawerController.pageIndex = 4;
//       portfolioNav.defaultReturn(context, defaultRutesSC.home);
//     }
//   }

//   register() async {
//     miLogin.username = miLogin.email;
//     miLogin.firstName = miLogin.username;
//     await sotoreSecureData.delData("refresh");
//     await sotoreSecureData.delData("token");
//     dynamic result =
//         await httpRequest.post(cloudflareUrls.register, miLogin.toJson());
//     if (result.containsKey("error")) {
//       if (result["error"].toString().contains("TimeoutException")) {
//         customAlertDialog(context, "No se ha podido registrar",
//             customImagePicker.failed, "Revise su conexion");
//       } else {
//         dynamic mensaje = result['body'];
//         String error = mensaje.keys.toList()[0];
//         await customAlertDialog(context, "No se ha podido registrar",
//             customImagePicker.failed, mensaje[error][0]);
//       }
//     } else {
//       await login();
//     }
//   }

//   refresh() async {
//     dynamic result =
//         await httpRequest.post(cloudflareUrls.refresh, miLogin.toJson());
//     if (result.containsKey("error")) {
//       if (result['body'].containsKey('code')) {
//         print("sesion expirada");
//       } else {
//         print("error desconocido");
//       }
//     } else {
//       print("sucess refresh");
//     }
//   }
// }
