import 'package:fluttertoast/fluttertoast.dart';
import '../utils/color_constants.dart';


class CustomToast{
  void showToast(String body,bool error){
    Fluttertoast.showToast(
        msg: body,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error?ColorConstant.errorColor:ColorConstant.success,
        textColor: ColorConstant.whiteA700,
        fontSize: 16.0
    );
  }

}