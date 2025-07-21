import 'package:get/get.dart';

class AuthController extends GetxController {
  var isObscure = true.obs;

  void toggleObscure (){
    isObscure.value = !isObscure.value;
}
}
