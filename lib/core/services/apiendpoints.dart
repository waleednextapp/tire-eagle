class ApiEndPoints{
  // Fleet Auth
  static const String signupFleet = '/api/auth/fleet-manager/signup';
  static const String loginFleetManager = '/api/auth/fleet-manager/login';
  static const String forgotPasswordEmail = '/api/auth/fleet-manager/forget-password';
  static const String verifyOtp = '/api/auth/fleet-manager/verify-otp';
  static const String resetPassword = '/api/auth/fleet-manager/reset-password';
  //Fleet Dashboard
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

  //Fleet Profile
  static const String profileUpdate = '/api/auth/fleet-manager/profile';
  static const String updatePassword = '/api/auth/fleet-manager/change-password';
  static const String rotateTire = '/api/fleet/tire/rotate';
  static const String rotateWheel = '/api/fleet/wheel/rotate';
  static const String dismountTire = '/api/fleet/tire/dismount';
  static const String dismountWheel = '/api/fleet/wheel/dismount';


  // User Auth
  static const String signupUser = '/api/auth/signup';
  static const String loginUser = '/api/auth/login';
  static const String userForgotPasswordEmail = '/api/auth/forget-password';
  static const String verifyUserOtp = '/api/auth/verify-otp';
  static const String userResetPassword = '/api/auth/reset-password';
  static const String userPasswordUpdate = '/api/user/change-password';

  // User Profile
  static const String userProfileUpdate = '/api/user/profile';


  // Fleet Get Tire / Wheel
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
  static String deleteTire(String id){
    return '/api/fleet/tire/delete?serialNumber=$id';
  }
  static String deleteWheel(String id){
    return '/api/fleet/wheel/delete?serialNumber=$id';
  }
static String returnDisposedUrl(String type){
    return '/api/fleet/assets/dismounted?type=$type';
  }
  static String returnBillingUrl(String status,{int? page,int? limit}){
    return '/api/fleet/transaction?page=1&limit=10&status=$status';
  }
  static String reminder({required String type, int page = 1, int limit = 10}) {
    // Construct the URL with required 'type' and optional 'page' and 'limit' parameters.
    return '/api/fleet/reminder/all-items?type=$type&page=$page&limit=$limit';
  }
  static String getHistoryAndReportUrl({int? page,int? limit,String? quickRange,String? startDate,String? endDate}){
    if(startDate !=null || endDate != null){
      return '/api/fleet/history?page=$page&limit=$limit&startDate=$startDate&endDate=$endDate';
    }
    else{
      return '/api/fleet/history?page=1&limit=10&quickRange=$quickRange';
    }
  }

      // User Dashboard
    static const String userHome = '/api/home/';


  static String userGetAllTire({int page = 1, int limit = 10}) {
    return '/api/user/tire/tire?page=$page&limit=$limit';
  }
  static String userGetWheelTire({int page = 1, int limit = 10}) {
    return '/api/user/wheel/?page=$page&limit=$limit';
  }

  static String getUserTireById(String id){
    return '/api/user/tire/$id';
  }
  static String getUserWheelById(String id){
    return '/api/user/wheel/$id';
  }
}
