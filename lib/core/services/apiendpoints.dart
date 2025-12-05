class ApiEndPoints{
  // Auth
  static const String signupUser = '/api/auth/fleet-manager/signup';
  static const String loginFleetManager = '/api/auth/fleet-manager/login';
  static const String forgotPasswordEmail = '/api/auth/fleet-manager/forget-password';
  static const String verifyOtp = '/api/auth/fleet-manager/verify-otp';
  static const String resetPassword = '/api/auth/fleet-manager/reset-password';
  //Dashboard
  static const String home = '/api/fleet/home/';
  static const String createTire = '/api/fleet/tire/create';
  static const String createWheel = '/api/fleet/wheel/create';
  static const String imageUpload = '/api/upload/single';
  static const String getAllTires = '/api/fleet/tire/';
  static const String getAllWheel = '/api/fleet/wheel/';
  static const String puncture = '/api/fleet/puncture/make';
  static const String sendForRethread = '/api/fleet/retread/create';
  static const String tiresDamageReport = '/api/fleet/report-damage/tire';
  static const String wheelDamageReport = '/api/fleet/report-damage/wheel';

  //Profile
  static const String profileUpdate = '/api/auth/fleet-manager/profile';
  static const String updatePassword = '/api/auth/fleet-manager/change-password';
  static const String rotateTire = '/api/fleet/tire/rotate';
  static const String rotateWheel = '/api/fleet/wheel/rotate';
  static const String dismountTire = '/api/fleet/tire/dismount';
  static const String dismountWheel = '/api/fleet/wheel/dismount';

  static String getTireUrl() {
      return "/api/fleet/assets?type=tire&status=inStorage&search=";
  }

  static String getWheelUrl() {
      return "/api/fleet/assets?type=wheel&status=inStorage&search=";

  }



  static String getTireId(String id){
    return '/api/fleet/tire/$id';
  }
  static String getWheelId(String id){
    return '/api/fleet/wheel/$id';
  }



}
