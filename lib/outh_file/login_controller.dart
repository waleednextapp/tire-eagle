// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart' as fb;
// import 'package:counteract_balancing/controllers/fcm_controller.dart';
// import 'package:counteract_balancing/controllers/user_profile_controller.dart';
// import 'package:counteract_balancing/models/UserModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// import '../components/custom_toast.dart';
// import '../services/api_endpoints.dart';
// import '../services/base_services.dart';
// import '../services/local_db_key.dart';
// import '../utils/SharedPreferencesMethod.dart';
// import '../utils/text_constants.dart';
// import '../utils/utils.dart';
// import 'calculator_controller.dart';
//
// class LoginController extends GetxController {
//   @override
//   void onInit() async {
//     super.onInit();
//   }
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   FCMController fcmController = Get.put(FCMController());
//
//   final RoundedLoadingButtonController btnController =
//       RoundedLoadingButtonController();
//
//   final RoundedLoadingButtonController appleBtnController =
//   RoundedLoadingButtonController();
//
//   final RoundedLoadingButtonController googleBtnController =
//   RoundedLoadingButtonController();
//
//   final RoundedLoadingButtonController welcomeController =
//       RoundedLoadingButtonController();
//
//   FocusNode? emailNode = FocusNode();
//   FocusNode? passwordNode = FocusNode();
//
//   RxBool showPassword = true.obs;
//   RxBool rememberMe = true.obs;
//   RxBool agreeToPolicy = false.obs;
//
//   //Social login
//   final auth = fb.FirebaseAuth.instance;
//   final database = FirebaseDatabase.instance.reference();
//   String? loginPlatform;
//
//   GlobalKey<FormState> formKey = new GlobalKey();
//
//   BaseService baseService = BaseService();
//   Rx<UserModel> response = UserModel().obs;
//
//   Future<void> loginIn(context) async {
//     Utils.hideKeyboard(context);
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     String? devicetokenn;
//      devicetokenn = await storage.getString(LocalDBKeys.DEVICETOKEN);
//     if(devicetokenn == null){
//       FCMController fcmController  = Get.put(FCMController());
//       fcmController.tokenGeneration();
//       devicetokenn = await SharedPreferencesMethod.storage.getString(LocalDBKeys.DEVICETOKEN);
//     }
//     final formState = formKey.currentState;
//     if (formState!.validate()) {
//       formState.save();
//       btnController.start();
//       Map body = {
//         "email": emailController.text.toLowerCase(),
//         "password": passwordController.text,
//         "remember_me": rememberMe.value,
//         "news_letter_signup": agreeToPolicy.value,
//         "device_token": 'devicetokenn',
//         "device_type": Platform.isIOS ? "ios" : "android",
//       };
//       print(body);
//       baseService.token = '';
//       var a = await baseService.basePostAPI(
//         APIEndpoints.loginUrl,
//         body,
//         loading: false,
//       );
//       if (a != false) {
//         if (a['status'] == true) {
//           response.value = UserModel.fromJson(a);
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.USERDETAIL, jsonEncode(response.value.data!));
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.USERID, response.value.data!.id.toString());
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.KHANTAR, passwordController.text);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USEREMAIL, response.value.data!.email!);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USERNAME, response.value.data!.firstName!);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USERFULLNAME, "${response.value.data!.firstName!} ${response.value.data!.lastName!}");
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.TOKEN, response.value.data!.token!);
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.FIRSTTIMEOPENAPP,'false');
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USERTYPE, response.value.data!.role!.toString());
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.ISMEMEBER, response.value.data!.isMember! == true ? '1' :'0');
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.ISMEMEBERAPPROVED, response.value.data!.isMemberApproved! == true ? '1' :'0');
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.REMEMBERME, rememberMe.value == true ? 'yes' : 'no');
//           if (response.value.data!.profileImage != null) {
//             SharedPreferencesMethod.storage.setString(
//                 LocalDBKeys.USERPROFILEPIC, response.value.data!.profileImage!);
//           }
//           Get.offAllNamed('/dashboardScreen');
//           fcmController.enableTopics(response.value.data!.id);
//           CalculatorController calculatorController = Get.put(CalculatorController());
//           calculatorController.getCategories();
//           UserProfileController myProfileController = Get.put(UserProfileController());
//           myProfileController.getUserProfile();
//           btnController.stop();
//         } else if (a['status'] == false) {
//           print('from here');
//           Get.dialog(CustomToast(
//             message: '${a['message']}',
//             error: true,
//           ));
//           btnController.stop();
//         } else {
//           print('from here 2');
//           print(a['data']);
//           btnController.stop();
//           Get.dialog(CustomToast(
//             message: '${a['message']}',
//             error: true,
//           ));
//         }
//       } else {
//         // Utils.showToast('Check Internet Connection ', true);
//         btnController.stop();
//       }
//     } else {
//       btnController.stop();
//     }
//   }
//
//
//   void logout(BuildContext context) async {
//     Map data = SharedPreferencesMethod.getUserInfo();
//     baseService.token = data['token'];
//     var response = await baseService.basePostAPI("${APIEndpoints.logoutUrl}", {},loading: true);
//
//     if (response['status'] == true) {
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       SharedPreferencesMethod.storage.clear();
//       pref.clear();
//       // ChatController chatController = Get.put(ChatController());
//       // chatController.disconnectSocket();
//       Get.offAllNamed('/welcomeScreen');
//     } else {
//       Utils.showToast('Something went wrong', true);
//     }
//
//   }
//
//   Future<void> loginAsGuest(context) async {
//     Utils.hideKeyboard(context);
//     SharedPreferences storage = await SharedPreferences.getInstance();
//       Map body = {
//       };
//       print(body);
//       baseService.token = '';
//       var a = await baseService.basePostAPI(
//         APIEndpoints.guestLogin,
//         body,
//         loading: true,
//       );
//       if (a != false) {
//         if (a['status'] == true) {
//           response.value = UserModel.fromJson(a);
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.USERDETAIL, jsonEncode(response.value.data!));
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.USERID, response.value.data!.id.toString());
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.KHANTAR, passwordController.text);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USEREMAIL, response.value.data!.email!);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USERNAME, response.value.data!.firstName!);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.TOKEN, response.value.data!.token!);
//           SharedPreferencesMethod.storage
//               .setString(LocalDBKeys.USERTYPE, response.value.data!.role!.toString());
//           if (response.value.data!.profileImage != null) {
//             SharedPreferencesMethod.storage.setString(
//                 LocalDBKeys.USERPROFILEPIC, response.value.data!.profileImage!);
//           }
//           Get.offAllNamed('/dashboardScreen', arguments: false);
//           CalculatorController calculatorController = Get.put(CalculatorController());
//           calculatorController.getCategories();
//           UserProfileController myProfileController = Get.put(UserProfileController());
//           myProfileController.getUserProfile();
//
//           // Get.dialog(CustomToast(
//           //   message: '${response.value.message}',
//           //   error: false,
//           // ));
//           btnController.stop();
//         } else if (a['status'] == false) {
//           print('from here');
//           Get.dialog(CustomToast(
//             message: '${a['message']}',
//             error: true,
//           ));
//           btnController.stop();
//         } else {
//           print('from here 2');
//           print(a['data']);
//           btnController.stop();
//           Get.dialog(CustomToast(
//             message: '${a['message']}',
//             error: true,
//           ));
//         }
//       } else {
//         // Utils.showToast('Check Internet Connection ', true);
//         btnController.stop();
//       }
//   }
//
//   loginGoogle(context) async {
//     try {
//       googleBtnController.start();
//       // absorb.value = true;
//       GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//       GoogleSignInAccount? res = await _googleSignIn.signIn();
//
//       if (res == null) {
//         googleBtnController.stop();
//
//         Utils.showToast("Login Cancelled", true);
//       } else {
//         GoogleSignInAuthentication authGoogle = await res.authentication;
//         fb.AuthCredential credential =
//         fb.GoogleAuthProvider.credential(accessToken: authGoogle.accessToken);
//
//         await auth.signInWithCredential(credential);
//         fb.User? user = auth.currentUser;
//
//         loginPlatform = "google";
//         print(user);
//         socialLogin(user!, loginPlatform!, context);
//       }
//     } catch (err, trace) {
//       // absorb.value = false;
//       print(trace);
//       print(err);
//       googleBtnController.stop();
//       Utils.showToast(err.toString(), true);
//     }
//   }
//
//   loginApple(context) async {
//
//     // Utils.showToast(
//     //     "Coming Soon",
//     //     false);
//
//     try {
//       // absorb.value = true;
//       Get.back();
//       appleBtnController.start();
//       final credential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );
//
//       print('credential $credential');
//       print('credential ${credential.authorizationCode}');
//       print('credential ${credential.email}');
//       print('credential ${credential.state}');
//       print('credential ${credential.userIdentifier}');
//       print('credential ${credential.givenName}');
//       print('credential ${credential.familyName}');
//       print('credential ${credential.identityToken}');
//
//       Map userMap = Map();
//
//       if (credential != null && credential.userIdentifier != null) {
//         final userId = credential.userIdentifier!.replaceAll(".", "");
//
//         if (credential.email != null) {
//           final fullName = credential.givenName! + " " + credential.familyName!;
//
//           await database
//               .child(userId)
//               .set({"email": credential.email, "fullName": fullName});
//
//           userMap["userId"] = userId;
//           userMap["fullName"] = fullName;
//           userMap["email"] = credential.email;
//
//           final fb.AuthCredential authCredential =
//           fb.OAuthProvider('apple.com').credential(
//             accessToken: credential.authorizationCode,
//             idToken: credential.identityToken,
//           );
//           print(userId);
//           await auth.signInWithCredential(authCredential);
//         } else {
//           DatabaseEvent snapshot = await database.child(userId).once();
//           print('item ${snapshot.snapshot.children.first.key}');
//           print('item ${snapshot.snapshot.children.first.value}');
//           print('item ${snapshot.snapshot.children.last.key}');
//           print('item ${snapshot.snapshot.children.last.value}');
//
//           // Map<String, dynamic> item = snapshot.snapshot.value as Map<String, dynamic>;
//           Map<String, dynamic> item = Map<String, dynamic>();
//           if (snapshot.snapshot.children.isNotEmpty) {
//             if (snapshot.snapshot.children.first.key == 'email') {
//               item['email'] = snapshot.snapshot.children.first.value;
//             }
//             if (snapshot.snapshot.children.last.key == 'fullName') {
//               item['fullName'] = snapshot.snapshot.children.last.value;
//             }
//           }
//           print('item ${item}');
//
//           if (item != null && item["email"] != null) {
//             userMap["userId"] = userId;
//             userMap["fullName"] = item["fullName"];
//             userMap["email"] = item["email"];
//           } else {
//             Utils.showToast(
//                 '${'Errors_appleError'.tr}',
//                 true);
//           }
//         }
//
//         loginPlatform = "apple";
//         socialLoginWithApple(userMap, loginPlatform!, context);
//       } else {
//         appleBtnController.stop();
//         Utils.showToast("Login Error", true);
//       }
//     } catch (err) {
//       appleBtnController.stop();
//       print('ios catch block');
//       print(err.toString());
//       Utils.showToast("Login Cancelled", true);
//     }
//   }
//
//
//   Future<void> socialLoginWithApple(Map user,platform,context) async {
//     Utils.hideKeyboard(context);
//     String? devicetokenn = await SharedPreferencesMethod.storage
//         .getString(LocalDBKeys.DEVICETOKEN);
//     appleBtnController.start();
//     Map body = {
//       'clientId': user["userId"],
//       'email': user["email"],
//       'first_name': user["fullName"],
//       'last_name': user["fullName"],
//       'device_token': devicetokenn,
//       'device_type': (Platform.isIOS) ? 'ios' : 'android',
//       "authType": "apple",
//     };
//     print(body);
//     baseService.token = '';
//     var a = await baseService.basePostAPI(
//       APIEndpoints.socialLoginUrl,
//       body,
//       loading: false,
//     );
//     if (a != false) {
//       response.value = UserModel.fromJson(a);
//       if (response.value.status == true) {
//         response.value = UserModel.fromJson(a);
//         SharedPreferencesMethod.storage.setString(
//             LocalDBKeys.USERDETAIL, jsonEncode(response.value.data!));
//         SharedPreferencesMethod.storage.setString(
//             LocalDBKeys.USERID, response.value.data!.id.toString());
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.KHANTAR, passwordController.text);
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USEREMAIL, response.value.data!.email!);
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USERNAME, response.value.data!.firstName!);
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USERFULLNAME, "${response.value.data!.firstName!} ${response.value.data!.lastName!}");
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.TOKEN, response.value.data!.token!);
//         SharedPreferencesMethod.storage.setString(
//             LocalDBKeys.FIRSTTIMEOPENAPP,'false');
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USERTYPE, response.value.data!.role!.toString());
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.REMEMBERME, rememberMe.value == true ? 'yes' : 'no');
//         if (response.value.data!.profileImage != null) {
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.USERPROFILEPIC, response.value.data!.profileImage!);
//         }
//         Get.offAllNamed('/dashboardScreen');
//         fcmController.enableTopics(response.value.data!.id);
//         CalculatorController calculatorController = Get.put(CalculatorController());
//         calculatorController.getCategories();
//         UserProfileController myProfileController = Get.put(UserProfileController());
//         myProfileController.getUserProfile();
//         appleBtnController.stop();
//       } else if (response.value.status == false) {
//         Utils.showToast('${response.value.message}', true);
//         appleBtnController.stop();
//       } else {
//         appleBtnController.stop();
//         Utils.showToast('${response.value.message}', true);
//       }
//     } else {
//       Utils.showToast('${'Errors_checkInternet'.tr}', true);
//       btnController.stop();
//     }
//   }
//
//
//   Future<void> socialLogin(fb.User user,platform,context) async {
//     Utils.hideKeyboard(context);
//
//     var image = user.photoURL;
//
//     String? devicetokenn = await SharedPreferencesMethod.storage
//         .getString(LocalDBKeys.DEVICETOKEN);
//     googleBtnController.start();
//     Map body = {
//       "email": user.providerData[0].email,
//       "first_name": user.displayName,
//       "last_name": user.displayName,
//       "clientId": user.uid,
//       "authType": "google",
//       "device_type": Platform.isIOS ? "ios" : "android",
//       "device_token":'${devicetokenn}'
//     };
//     print(body);
//     baseService.token = '';
//     var a = await baseService.basePostAPI(
//       APIEndpoints.socialLoginUrl,
//       body,
//       loading: false,
//     );
//     print(a);
//     if (a != false) {
//       response.value = UserModel.fromJson(a);
//       if (response.value.status == true) {
//         response.value = UserModel.fromJson(a);
//         SharedPreferencesMethod.storage.setString(
//             LocalDBKeys.USERDETAIL, jsonEncode(response.value.data!));
//         SharedPreferencesMethod.storage.setString(
//             LocalDBKeys.USERID, response.value.data!.id.toString());
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.KHANTAR, passwordController.text);
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USEREMAIL, response.value.data!.email!);
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USERNAME, response.value.data!.firstName!);
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USERFULLNAME, "${response.value.data!.firstName!} ${response.value.data!.lastName!}");
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.TOKEN, response.value.data!.token!);
//         SharedPreferencesMethod.storage.setString(
//             LocalDBKeys.FIRSTTIMEOPENAPP,'false');
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.USERTYPE, response.value.data!.role!.toString());
//         SharedPreferencesMethod.storage
//             .setString(LocalDBKeys.REMEMBERME, rememberMe.value == true ? 'yes' : 'no');
//         if (response.value.data!.profileImage != null) {
//           SharedPreferencesMethod.storage.setString(
//               LocalDBKeys.USERPROFILEPIC, response.value.data!.profileImage!);
//         }
//         Get.offAllNamed('/dashboardScreen');
//         fcmController.enableTopics(response.value.data!.id);
//         CalculatorController calculatorController = Get.put(CalculatorController());
//         calculatorController.getCategories();
//         UserProfileController myProfileController = Get.put(UserProfileController());
//         myProfileController.getUserProfile();
//         googleBtnController.stop();
//       } else if (response.value.status == false) {
//         Utils.showToast('${response.value.message}', true);
//         googleBtnController.stop();
//       } else {
//         googleBtnController.stop();
//         Utils.showToast('${response.value.message}', true);
//       }
//     } else {
//       Utils.showToast('${'Errors_checkInternet'.tr}', true);
//       googleBtnController.stop();
//     }
//   }
//
// }
