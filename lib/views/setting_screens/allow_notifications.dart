import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/views/setting_screens/billing_and_invoices.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/notification_controller.dart';
import '../../widgets/back_button.dart';

class AllowNotifications extends StatelessWidget {
  AllowNotifications({super.key});

  final NotificationController controller = Get.put(NotificationController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,

        title: customText(
          text: "Notifications",
          fontSize: 19.sp,
          fontWeight: FontWeight.w600,
        ),

        leading: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: backButton(),
        ),
        leadingWidth: 10.w,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 1.h),

            _buildNotificationRow(
              title: "Payments",
              value: controller.paymentsEnabled,
              onChanged: controller.togglePayments,
            ),

            Divider(height: 0.1.h, thickness: 1, color: Colors.grey.shade300),

            _buildNotificationRow(
              title: "Reminder",
              value: controller.reminderEnabled,
              onChanged: controller.toggleReminder,
            ),

            Divider(height: 0.1.h, thickness: 1, color: Colors.grey.shade300),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationRow({
    required String title,
    required RxBool value,
    required Function(bool) onChanged,
    double switchScale = 0.8, // new optional parameter to scale switch
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText(
            text: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),

          Obx(() =>
              Transform.scale(
                scale: switchScale, // scale the switch
                child: CupertinoSwitch(
                  value: value.value,
                  onChanged: onChanged,
                  activeColor: yellowColor,
                  trackColor: Colors.grey.shade300,
                ),
              )),
        ],
      ),
    );
  }
}
