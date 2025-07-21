// import 'dart:async';
// import 'dart:convert';
//
// import 'package:counteract_balancing/models/country_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
//
// import '../components/custom_toast.dart';
// import '../services/api_endpoints.dart';
// import '../services/base_services.dart';
// import '../utils/text_constants.dart';
// import '../utils/utils.dart';
//
// class SignUpController extends GetxController {
//   SignUpController(context);
//
//   BuildContext? context;
//   RxInt count = 1.obs;
//   final RoundedLoadingButtonController btnController =
//       RoundedLoadingButtonController();
//
//   // BaseService baseService = BaseService();
//
//   @override
//   void onInit() async {
//     getCounty();
//     Timer(Duration(seconds: 1), () {
//       count.value = 0;
//     });
//     super.onInit();
//   }
//
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController companyController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController adressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confPasswordController = TextEditingController();
//   TextEditingController countryZipCode = TextEditingController();
//
//   FocusNode? firstNameNode = FocusNode();
//   FocusNode? lastNameNode = FocusNode();
//   FocusNode? companyNode = FocusNode();
//   FocusNode? phoneNode = FocusNode();
//   FocusNode? adressNode = FocusNode();
//   FocusNode? countryZipCodeNode = FocusNode();
//   TextEditingController country = TextEditingController();
//   TextEditingController state = TextEditingController();
//   TextEditingController city = TextEditingController();
//   FocusNode? stateNode = FocusNode();
//   FocusNode? cityNode = FocusNode();
//   FocusNode? emailNode = FocusNode();
//   FocusNode? passwordNode = FocusNode();
//   FocusNode? confPasswordNode = FocusNode();
//   FocusNode? countryNode = FocusNode();
//
//   RxBool showPassword = true.obs;
//   RxBool showConfPassword = true.obs;
//
//   BaseService baseService = BaseService();
//   GlobalKey<FormState> formKey = new GlobalKey();
//
//   bool formSubmitted = false;
//   RxList<String> Cities = ["City"].obs;
//   RxList<String> CountryNew = ['Country'].obs;
//   String selectedCity = "City";
//   String selectedCountryNew = "Country";
//   String selectedState = "]State/Province";
//   RxList<String> States = ["State/Province"].obs;
//
//   Future getResponse() async {
//     var res = await rootBundle.loadString('assets/lotties/country.json');
//     return jsonDecode(res);
//   }
//
//
//   Future getCounty() async {
//     CountryNew.clear();
//     var countryres = await getResponse() as List;
//     countryres.forEach((data) {
//       var model = StatusModel();
//       model.name = data['name'];
//       model.emoji = data['emoji'];
//       CountryNew.add(model.emoji! + "    " + model.name!);
//     });
//
//     print(CountryNew);
//     return CountryNew;
//   }
//
//   Future getState() async {
//     States.clear();
//     print('arso select state');
//     var response = await getResponse();
//     var takestate = response
//         .map((map) => StatusModel.fromJson(map))
//         .where((item) => item.emoji + "    " + item.name == selectedCountryNew)
//         .map((item) => item.state)
//         .toList();
//     var states = takestate as List;
//     states.forEach((f) {
//       print('arso state');
//       var name = f.map((item) => item.name).toList();
//       print('arso state $name');
//       if(name.length == 0 ){
//         name = ['Not Available'];
//         city.text = 'Not Available';
//         state.text = 'Not Available';
//       }
//       for (var statename in name) {
//         print(statename.toString());
//         States.add(statename.toString());
//         print('arso state ${statename.toString()}');
//       }
//     });
//
//     return States;
//   }
//
//   Future getCity() async {
//     Cities.clear();
//     var response = await getResponse();
//     var takestate = response
//         .map((map) => StatusModel.fromJson(map))
//         .where((item) => item.emoji + "    " + item.name == selectedCountryNew)
//         .map((item) => item.state)
//         .toList();
//     var states = takestate as List;
//     states.forEach((f) {
//       var name = f.where((item) => item.name == selectedState);
//       print('arso city ya hai $name');
//       if(name.length == 0 ){
//         name = ['Not Available'];
//         city.text = 'Not Available';
//         state.text = 'Not Available';
//         return;
//       }
//       var cityname = name.map((item) => item.city).toList();
//       cityname.forEach((ci) {
//         var citiesname = ci.map((item) => item.name).toList();
//         for (var citynames in citiesname) {
//           print(citynames.toString());
//           Cities.add(citynames.toString());
//         }
//       });
//     });
//     return Cities;
//   }
//
//   void saveInfo(context) {
//     final formState = formKey.currentState;
//     if (formSubmitted == true) {
//       if (formState!.validate()) {
//         formState.save();
//         // then do something
//       }
//     }
//   }
//
//
//   Future<void> signUpUser(context) async {
//     Utils.hideKeyboard(context);
//     final formState = formKey.currentState;
//     if (formState!.validate()) {
//       formState.save();
//       btnController.start();
//       if (passwordController.text != confPasswordController.text) {
//         btnController.stop();
//         Get.dialog(CustomToast(
//           message: '${'Errors_passwordsNotMatch'.tr}',
//           error: true,
//         ));
//       } else {
//         Map body = {
//           "first_name": firstNameController.text,
//           "last_name": lastNameController.text,
//           // "company_name": companyController.text,
//           "email": emailController.text.toLowerCase(),
//           "password": passwordController.text,
//           "city": "${city.text}",
//           // "state": "${state.text}",
//           // "country": "${country.text}",
//           "phone": phoneController.text,
//           // "address": adressController.text
//         };
//         print(body);
//         baseService.token = '';
//         var a = await baseService.basePostAPI(
//           APIEndpoints.signUpUrl,
//           body,
//           loading: false,
//         );
//         btnController.stop();
//         if (a['status'] == true) {
//           Get.offAllNamed('/loginScreen');
//           Get.dialog(CustomToast(
//             message: 'Please click verification link in your email inbox to verify your account.',
//             error: false,
//           ));
//         } else {
//           btnController.stop();
//           Get.dialog(CustomToast(
//             message: '${a['message']}',
//             error: true,
//           ));
//         }
//       }
//     }
//   }
// }
