import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tire_eagle/controllers/setting_controller.dart';
import 'package:tire_eagle/core/services/apiendpoints.dart';
import 'package:tire_eagle/core/services/base_services.dart';
import 'package:tire_eagle/models/historyandreportmodel.dart';
import 'package:tire_eagle/models/home_model.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';

import '../utils/utility.dart';
import '../widgets/damage_alert_dialog.dart';
import '../widgets/report_dialog.dart';

class DashboardController extends GetxController{
  var currentIndex = 0.obs;
  var selectedIndexTab = 0.obs;
  var inventoryIndexTab = 0.obs;
  var reportIndexTab = 0.obs;
  var addNewTab = 0.obs;
  var reportDamageTab = 0.obs;
  BaseService baseService = BaseService();
  Rx<HomeModel?> homeModel = Rx<HomeModel?>(null);
  Rx<HistoryAndReportModel?> historyModel = Rx<HistoryAndReportModel?>(null);
  RxBool isLoading = true.obs;
  String? selectedValue;
  var inventorySelectedIndex = 1.obs;
  PageController? _pageController;
  RxString selectedPosition = ''.obs;
  RxInt selectedHistoryIndex = 0.obs;
  // DashboardController ke andar
  RxString imageUrl = "".obs; // Ye line add karein

  final historySearchController = TextEditingController();
  // --- ADD THESE REACTIVE PROPERTIES ---
  final historySearchQuery = "".obs;
  final historyFilteredTires = <Tiresfull>[].obs;
  final historyFilteredWheels = <Wheels>[].obs;

  // --- ADD THE searchHistory FUNCTION ---
  void searchHistory(int index, String query) {
    final lowerQuery = query.toLowerCase();

    // 1. If query is empty, clear the filtered lists to show full history (handled by ListView logic)
    if (query.isEmpty) {
      historyFilteredTires.clear();
      historyFilteredWheels.clear();
      return;
    }

    // 2. Access the main history list from the reactive model
    // Note: We access entries directly from the historyModel
    final entries = historyModel.value?.data?.entries ?? [];

    if (index == 0) { // Tire Tab selected
      // Expand all nested tires into a single flat list and filter them by serial number
      final List<Tiresfull> filteredTiresList = entries
          .expand<Tiresfull>((e) => e.tires ?? [])
          .where((t) => (t.serialNumber ?? "").toLowerCase().contains(lowerQuery))
          .toList();

      // Update the OBSERVED list using .value = to trigger the UI rebuild
      historyFilteredTires.value = filteredTiresList;
      historyFilteredWheels.clear(); // Clear the other list
    } else { // Wheel Tab selected
      // Expand all nested wheels into a single flat list and filter them by serial number
      final List<Wheels> filteredWheelsList = entries
          .expand<Wheels>((e) => e.wheels ?? [])
          .where((w) => (w.serialNumber ?? "").toLowerCase().contains(lowerQuery))
          .toList();

      // Update the OBSERVED list using .value = to trigger the UI rebuild
      historyFilteredWheels.value = filteredWheelsList;
      historyFilteredTires.clear(); // Clear the other list
    }

    print("Filtered counts → Tires: ${historyFilteredTires.length}, Wheels: ${historyFilteredWheels.length}");
  }

  TextEditingController searchController = TextEditingController();
  RxList<Tires> filteredTires = <Tires>[].obs;

  void searchTire(String query) {
    if (query.isEmpty) {
      filteredTires.value = homeModel.value?.data?.tires ?? [];
      return;
    }

    filteredTires.value = homeModel.value!.data!.tires!
        .where((tire) =>
        (tire.serialNumber ?? "")
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  // Pagination
  var currentPage = 1.obs;
  List<String> positions = [
    'F-Left',
    'F-Right',
    'R-Left',
    'R-Right',

  ];
  String? uploadedImageUrl;
  String? isoFormat;
  var profilePicture = Rxn<File>();
  var selectedImage1 = Rxn<File>();
  var selectedImage2 = Rxn<File>();

  // 💡 Pagination State Variables for TotalTires Screen (Kept for UI logic/API response parsing)
  RxInt currentHistoryPage = 1.obs;
  RxBool hasNextHistoryPage = false.obs;
  RxInt totalHistoryPages = 1.obs;


  /// Add Wheel Controller
  TextEditingController tiredateController2 = TextEditingController();
  TextEditingController customerEmailControllerWheel = TextEditingController();
  TextEditingController serialNumberControllerWheel = TextEditingController();
  TextEditingController vehicleNumberControllerWheel = TextEditingController();
  TextEditingController wheelMaterialField = TextEditingController();
  TextEditingController wheelSizeField = TextEditingController();
  TextEditingController wheelConditionField = TextEditingController();

/// Add Tire Controller
  TextEditingController tiredateController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController tirebrandField = TextEditingController();
  TextEditingController tireplyField = TextEditingController();
  TextEditingController tiresizeField = TextEditingController();
  TextEditingController tireHealth = TextEditingController();


  /// Report Damage Controller
  TextEditingController tiredateController3 = TextEditingController();
  TextEditingController wheeldateController = TextEditingController();
  TextEditingController tireSerialNumber = TextEditingController();
  TextEditingController wheelSerialNumber = TextEditingController();
  TextEditingController tireNoteController = TextEditingController();
  TextEditingController wheelNoteController = TextEditingController();

  /// Puncture Controller
  TextEditingController punctureDateController = TextEditingController();
  TextEditingController punctureSerialController = TextEditingController();
  TextEditingController noOfPuncture = TextEditingController();
  TextEditingController noOfCuts = TextEditingController();
  TextEditingController noOfBulge = TextEditingController();
  TextEditingController costController = TextEditingController();

  /// Send for rethread Controller
  TextEditingController rethreadSerialNo = TextEditingController();
  TextEditingController rethreadCenterName = TextEditingController();
  TextEditingController rethreadAvgCost = TextEditingController();
  TextEditingController rethreadPickupLogistics = TextEditingController();
  TextEditingController rethreadDateofDamage = TextEditingController();
  TextEditingController rethreadReturnDate = TextEditingController();
  TextEditingController rethreadMountedPosition = TextEditingController();

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();



  void changePage(int index) {
    currentIndex.value = index;
    if (_pageController?.hasClients ?? false) {
      _pageController!.jumpToPage(index);
      print("iam here");
    } else {
      debugPrint("⚠️ PageController not set or not attached");
    }
  }

  // Future<File?> uploadImage() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     // allowedExtensions: ['png', 'jpg', 'jpeg'],
  //   );
  //
  //   if (result != null && result.files.single.path != null) {
  //     return File(result.files.single.path!);
  //   } else {
  //     return null;
  //   }
  // }
  // Pick an image

  // Function signature mein 'index' wapas add kar diya gaya hai
  Future<void> uploadImage(int? index) async {
    try {
      // 1. File Picker se file select karein
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result == null || result.files.single.path == null) {
        print('No file selected');
        return;
      }

      File file = File(result.files.single.path!);
      print('Picked file path: ${file.path}');
      print('File Exists: ${file.existsSync()}');

      // ⭐ Local State Update Logic ⭐
      if (index == 1) {
        // Agar index 1 hai, toh selectedImage1 mein jaayega
        selectedImage1.value = file;
        print('Image saved locally in selectedImage1');
      } else if (index == 2){
        // Agar index 1 nahi hai (yani 2 ya koi aur number), toh selectedImage2 mein jaayega
        selectedImage2.value = file;
        print('Image saved locally in selectedImage2');
      }
      else{
        profilePicture.value=file;
        print('Image saved locally in profile picture');
      }
      // Note: selectedImage1 aur selectedImage2 aapke project mein define hone chahiye.

      // 2. Request setup karein
      var uri = Uri.parse('http://app.yourwebsitemockup.net/tire-eagle/api/upload/single');
      var request = http.MultipartRequest('POST', uri);

      // 3. File ko Bytes mein padhein aur MIME type determine karein (Robust Logic)
      List<int> fileBytes = await file.readAsBytes();
      String fileName = file.path.split('/').last;

      String fileExtension = fileName.split('.').last.toLowerCase();
      MediaType mediaType;

      if (fileExtension == 'png') {
        mediaType = MediaType('image', 'png');
      } else if (fileExtension == 'gif') {
        mediaType = MediaType('image', 'gif');
      } else if (fileExtension == 'webp') {
        mediaType = MediaType('image', 'webp');
      } else if (fileExtension == 'svg') {
        mediaType = MediaType('image', 'svg+xml');
      } else {
        mediaType = MediaType('image', 'jpeg');
      }

      // 4. MultipartFile ko request mein add karein
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        fileBytes,
        filename: fileName,
        contentType: mediaType,
      ));

      // 5. Request send karein
      var response = await request.send();
      var respStr = await response.stream.bytesToString();

      print('--- Response ---');
      print('Status: ${response.statusCode}');
      print('Response Body: $respStr');
      print('----------------');

      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(respStr);
        uploadedImageUrl = jsonResp['data']['url'];
        print('✅ Upload success: ${jsonResp['data']['url']}');

        // ⭐ Ye line add karein taaki MyDetail screen update ho sake
        imageUrl.value = jsonResp['data']['url'] ?? "";

        print('✅ Upload success: ${jsonResp['data']['url']}');
      } else {
        print('❌ Upload failed with status ${response.statusCode}');
      }

    } catch (e) {
      print('🚨 Error uploading file: $e');
    }
  }


  Future<bool> requestPermission () async {
    if(await Permission.storage.request().isGranted){
      return true;

    }
    else{
      print("Storage Permission Denied");
      return false;
    }
  }



  /// Send for Rethread
  // RxString mountedPosition = "".obs;
  // RxString TireHealth = ''.obs;
  // RxString RethreadHistory = ''.obs;
  // RxString PickupLogistics = ''.obs;
  // RxString DateOfDamage = ''.obs;
  // RxString EstimatedReturnDate = ''.obs;

  // List<String> mountedPositionList = ["F-Right", "F-Left","R-Left","R-Right"];

  // List<String> tireHealthList = [
  //   "Good",
  //   "Average",
  //   "Bad",
  // ];
  //
  // List<String> rethreadHistoryList = [
  //   "Yes",
  //   "No",
  // ];
  //
  // List<String> pickupLogisticsList = [
  //   "Pending",
  //   "Completed",
  // ];
  //
  // List<String> dateOfDamageList = [
  //   "2025-01-01",
  //   "2025-01-02",
  // ];
  //
  // List<String> estimatedReturnDateList = [
  //   "2025-02-01",
  //   "2025-02-05",
  // ];

  // For Tire Details
  RxString selectedBrand = "".obs;
  //List<String> brandList = ["Bridgestone", "Michelin", "Goodyear"];

  RxString selectedTireSize = "".obs;
  List<String> tireSizeList = ["12.5R20", "11R22.5", "10R20"];

  RxString selectedPlyRating = "".obs;
  List<String> plyRatingList = ["8", "10", "12"];

  RxString tireHealth2 = "".obs;
  List<String> tireHealthList2 = ["12/32 ---- 🟢 (New)", "6/32 ---- 🟡 (Used)", "2/32 ---- 🔴 (Bad)"];

  RxString status = "".obs;
  List<String> statusList = ["inUse", "inStorage","inRepair","inReplacement","disposed"];

  RxString mountedPosition2 = "".obs;
  List<String> mountedPositionList2 = ["F-Right", "F-Left","R-Left","R-Right"];

  // For Tire Damage Section
  RxString damageType = "".obs;
  List<String> damageTypeList = ["puncture", "cut", "bulge"];

  RxString severity = "".obs;
  List<String> severityList = ["Minor", "Moderate", "Severe"];

  RxString mountedPosition5 = "".obs;
  List<String> mountedPositionList5 = ["F-Right", "F-Left","R-Left","R-Right"];

  RxInt noOfDamage = 0.obs;
  List<int> noOfDamageList = [1, 2, 3, 4, 5];

  // For Wheel Damage Section

  RxString damageType1 = "".obs;
  List<String> damageType1List = [ "cut", "bulge"];

  RxString severity1 = "".obs;
  List<String> severity1List = ["Minor", "Moderate", "Severe"];

  RxString mountedPosition6 = "".obs;
  List<String> mountedPositionList6 = ["F-Right", "F-Left","R-Left","R-Right"];

  RxInt noOfDamage1 = 0.obs;
  List<int> noOfDamage1List = [1, 2, 3, 4, 5];





  RxString wheelStatus = "".obs;
  List<String> wheelStatusList = ["inUse", "inStorage","inRepair","inReplacement","disposed"];

  RxString mountedPosition3 = "".obs;
  List<String> mountedPositionList3 = ["F-Right", "F-Left","R-Left","R-Right"];

//Rethread
  RxString mountedPosition7 = "".obs;
  List<String> mountedPositionList7 = ["F-Right", "F-Left","R-Left","R-Right"];

  // @override
  // void onInit() {
  //   home();
  //   super.onInit();
  // }

  void setPageController(PageController controller){
    _pageController = controller;
  }

  void selectTabSearch(int index) {
    selectedIndexTab.value = index;
  }

  void selectInventoryValue(int index) {
    inventoryIndexTab.value = index;
  }
  void selectHistoryValue(int index) {
    selectedHistoryIndex.value = index;
  }
  void reportValuetoggle(int index) {
    reportIndexTab.value = index;
  }
  void addNewToggle(int index) {
    addNewTab.value = index;
  }
  void reportDamageToggle(int index) {
    reportDamageTab.value = index;
  }
  final List<String> addTab = [
    "Add New Tire",
    "Add New Wheel",
  ];
  final List<String> reportTab = [
    "Tire",
    "Wheel",
  ];

  final List<String> notificationTabs = [
    "All",
    "Maintenance",
    "Replacement",
    "Filter",
  ];
  final List<String> inventoryTabs = [
    "In Use",
    "Disposed",
  ];

  final List<String> historyTabs = [
    "Tire",
    "Wheel",
  ];
  final List<String> reportTabs = [
    "Last Week",
    "Last Month",
    "Last 3 Months",
    "Filter",
  ];

  /// Puncture
  RxString mountedPosition4 = "".obs;
  List<String> mountedPositionList4 = ["F-Right", "F-Left","R-Left","R-Right"];




  Future<void> home() async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.home);

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel
      homeModel.value = HomeModel.fromJson(responseData);

// Default full list
      filteredTires.value = homeModel.value?.data?.tires ?? [];

      print("🏠 HomeModel Parsed:");
      print(homeModel.value?.toJson());

      // Example usage:
      print("Total Tires: ${homeModel.value?.data?.summary?.totalTires}");
      print("Tires Count: ${homeModel.value?.data?.tires?.length}");

    } catch (e) {
      print("❌ Home() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }

  // ADD New Api Call
  Future<void> addNewTire() async {

    print("================= TIRE FORM VALUES =================");
    print("Customer Email      : ${customerEmailController.text}");
    print("Image URL           : $uploadedImageUrl");
    print("Serial Number       : ${serialNumberController.text}");
    print("Date Of Entry       : $isoFormat");
    print("Brand               : ${tirebrandField.text}");
    print("Tire Size           : ${tiresizeField.text}");
    print("Ply Rating          : ${tireplyField.text}");
    print("Vehicle Number      : ${vehicleNumberController.text}");
    print("Mounted Position    : ${mountedPosition2.value}");
    print("Status              : ${status.value}");
    print("=====================================================");

    final body = {
      'userEmail': customerEmailController.text.trim(),
      'imageUrl': uploadedImageUrl,
      'serialNumber': serialNumberController.text.trim(),
      'dateOfEntry': isoFormat,
      'brand': tirebrandField.text.trim(),
      'tireSize': tiresizeField.text.trim(),
      'plyRating': tireplyField.text.trim(),
      'vehicalNumber': vehicleNumberController.text.trim(),
      'mountedPosition': mountedPosition2.value.trim(),
      'status': status.value.trim(),
    };

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.createTire,
      body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    clearTireForm();
    Get.offAllNamed('/bottomnavbar');
    home();
  }

  Future<void> addNewWheel() async {

    print("================= WHEEL FORM VALUES =================");
    print("Customer Email      : ${customerEmailControllerWheel.text}");
    print("Image URL           : $uploadedImageUrl");
    print("Serial Number       : ${serialNumberControllerWheel.text}");
    print("Date Of Entry       : $isoFormat");
    print("Material            : ${wheelMaterialField.text}");
    print("Wheel Size          : ${wheelSizeField.text}");
    print("Wheel Condition     : ${wheelConditionField.text}");
    print("Vehicle Number      : ${vehicleNumberControllerWheel.text}");
    print("Mounted Position    : ${mountedPosition3.value}");
    print("Status              : ${wheelStatus.value}");
    print("=====================================================");

    final body = {
      'userEmail': customerEmailControllerWheel.text.trim(),
      'imageUrl': uploadedImageUrl,
      'serialNumber': serialNumberControllerWheel.text.trim(),
      'dateOfEntry': isoFormat,
      'material': wheelMaterialField.text.trim(),
      'wheelSize': wheelSizeField.text.trim(),
      'wheelCondition': wheelConditionField.text.trim(),
      'vehicalNumber': vehicleNumberControllerWheel.text.trim(),
      'mountedPosition': mountedPosition3.value.trim(),
      'status': wheelStatus.value.trim(),
    };

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.createWheel,
      body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    clearWheelForm();
    Get.offAllNamed('/bottomnavbar');
    home();
  }


  Future<void> addPuncture(BuildContext context) async {
    final body = {
      "serialNumber": punctureSerialController.text.trim(),
      "mountedPosition": mountedPosition4.value,
      "punctureCount": noOfPuncture.text.trim(),
      "bulgeCount": noOfBulge.text.trim(),
      "cutCount": noOfCuts.text.trim(),
      "dateOfPuncture": isoFormat,
      "cost": costController.text.trim()
    };

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.puncture,
      body,
      loading: true,
    );

    if (responseMap["success"] != true) {
      return;
    }

    final data = responseMap["data"];
    if (data == null) return;

    clearPunctureForm();

    final puncture = data["puncture"];

    print(puncture);

    reportDialog(
      context,
      isPuncture: true,
      serialNo: puncture["serialNumber"]?.toString() ?? "",
      mountedPosition: puncture["mountedPosition"]?.toString() ?? "",
      puncture: puncture["punctureCount"]?.toString() ?? "",
      cut: puncture["cutCount"]?.toString() ?? "",
      bulge: puncture["bulgeCount"]?.toString() ?? "",
      serviceFees: puncture["cost"] is num ? puncture["cost"].toDouble() : 0,
      totalAmount: puncture["cost"] is num ? puncture["cost"].toDouble() : 0,
    );
  }

  Future<void> sendForRethread(BuildContext context) async {
    final body = {
      "serialNumber": rethreadSerialNo.text.trim(),
      "mountedPosition": mountedPosition7.value,
      "averageCost": rethreadAvgCost.text.trim(),
      "centerName": rethreadCenterName.text.trim(),
      "pickupLogistics": rethreadPickupLogistics.text.trim(),
      "dateOfDamage": rethreadDateofDamage.text.trim(),
      "estimatedReturnDate": rethreadReturnDate.text.trim()
    };

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.sendForRethread,
      body,
      loading: true,
    );

    if (responseMap["success"] != true) {
      return;
    }

    final data = responseMap["data"];
    if (data == null) return;

    clearRethreadForm();


    final rethread = data["retread"];

    print(rethread);

    reportDialog(
      context,
      //serialNo: puncture["serialNumber"]?.toString() ?? "",
      // mountedPosition: puncture["mountedPosition"]?.toString() ?? "",
      // puncture: puncture["punctureCount"]?.toString() ?? "",
      // cut: puncture["cutCount"]?.toString() ?? "",
      // bulge: puncture["bulgeCount"]?.toString() ?? "",
      // serviceFees: puncture["cost"] is num ? puncture["cost"].toDouble() : 0,
      // totalAmount: puncture["cost"] is num ? puncture["cost"].toDouble() : 0,
      dateReported: formatDate(rethread['dateOfDamage']?.toString() ?? ""),
      mountedPosition: rethread['mountedPosition']?.toString() ?? "",
      serialNo: rethread['serialNumber']?.toString() ?? "",
      totalAmount: rethread["cost"] is num ? rethread["cost"].toDouble() : 0,

    );
  }


  Future<String?> pickDate(
      BuildContext context, TextEditingController controller) async {

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.yellow,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {

      // 🔥 Backend EXACT format
      isoFormat =
          "${pickedDate.toUtc().toIso8601String().split('.').first}.000Z";

      // 🔥 UI me simple date
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);

      print("Controller Display: ${controller.text}");
      print("ISO for Backend: $isoFormat");

      return isoFormat;
    }

    return null;
  }


  //Report Damage Api Call
  Future<void> reportTireDamage(BuildContext context) async {
    try {
      // Build the body
      final body = {
        'tireSerialNumber': tireSerialNumber.text,
        'location': mountedPosition5.value.trim(),
        'damageType': {
          // Make sure you use .value if damageType is RxString
          '${damageType.value}': noOfDamage.value,
        },
        'severity': severity.value.trim(), // e.g., "high"
        'dateOfEntry': isoFormat, // in ISO format: 2025-11-17T22:00:00.000Z
        'note': tireNoteController.text.trim(), // optional note
      };


      // Make the API call
      final responseMap = await baseService.basePostAPI(
        ApiEndPoints.tiresDamageReport,
        body,
        loading: true,
      );

      // Check API response
      print("===== Tire Damage API Response =====");
      print(responseMap);
      print("===================================");

      if (responseMap["success"] != true) {
        return;
      }

      final data = responseMap["data"];
      if (data == null) return;

      // Clear form and navigate
      clearTireReport();
      showDamageAlertDialog(context);
      // Get.offAllNamed('/bottomnavbar');
      // home();

    } catch (e) {
      print("Error reporting tire damage: $e");
    }
  }

  Future<void> reportWheelDamage(BuildContext context) async {
    try {
      // Build the body
      final body = {
        'wheelSerialNumber': wheelSerialNumber.text,
        'location': mountedPosition6.value.trim(),
        'damageType': {
          '${damageType1.value}': noOfDamage1.value,
        },
        'severity': severity1.value.trim(), // e.g., "high"
        'dateOfEntry': isoFormat, // in ISO format: 2025-11-17T22:00:00.000Z
        'note': wheelNoteController.text.trim(), // optional note
      };

      // ✅ Print body for debugging
      print("===== Wheel Damage API Body =====");
      print("wheelSerialNumber: ${body['wheelSerialNumber']}");
      print("location: ${body['location']}");
      print("damageType: ${body['damageType']}");
      print("severity: ${body['severity']}");
      print("dateOfEntry: ${body['dateOfEntry']}");
      print("note: ${body['note']}");
      print("===============================");

      // Make the API call
      final responseMap = await baseService.basePostAPI(
        ApiEndPoints.wheelDamageReport,
        body,
        loading: true,
      );

      // Check API response
      print("===== Wheel Damage API Response =====");
      print(responseMap);
      print("===================================");

      if (responseMap["success"] != true) {
        return;
      }

      final data = responseMap["data"];
      if (data == null) return;

      // Clear form and show alert
      clearWheelReport();
      showDamageAlertDialog(context);

    } catch (e) {
      print("Error reporting wheel damage: $e");
    }
  }


// 💡 Updated History and Report Get Api
  Future<void> GetHistoryAndReport({int page = 1,String? quickRange,String? startDate, String? endDate}) async {
    try {
      isLoading.value = true;
      currentHistoryPage.value = page;

      final responseData = await baseService.baseGetAPI(
        ApiEndPoints.getHistoryAndReportUrl(
          page: page,
          limit: 10,
          quickRange: quickRange,
          startDate: startDate,
          endDate: endDate,
        ),
      );

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      historyModel.value = HistoryAndReportModel.fromJson(responseData);

      // --- ✅ Correct Pagination Variable Update ---

      // 1. Access the 'data' object first
      final data = responseData["data"] ?? {};

      // 2. Access 'pagination' object from within 'data'
      final meta = data["pagination"] ?? {};

      print("I-------am here $meta"); // This should now print the pagination data

      // 3. Update variables using the API's key names
      totalHistoryPages.value = meta["totalPages"] ?? 1;
      // API uses 'page' key for current page
      currentHistoryPage.value = meta["page"] ?? page;
      // API provides 'hasNextPage' directly
      hasNextHistoryPage.value = meta["hasNextPage"] ?? (currentHistoryPage.value < totalHistoryPages.value);

    } catch (e) {
      print("❌ History() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }

// 💡 Pagination methods still call GetAllTire, using the page argument for state management
// 💡 History/Report Pagination methods
  void loadNextHistoryPage() {
    if (hasNextHistoryPage.value) {
      GetHistoryAndReport(page: currentHistoryPage.value + 1);
    }
  }

  void loadPrevHistoryPage() {
    if (currentHistoryPage.value > 1) {
      GetHistoryAndReport(page: currentHistoryPage.value - 1);
    }
  }





  void clearPunctureForm() {
    punctureSerialController.clear();
    mountedPosition4.value = "";
    noOfPuncture.clear();
    noOfCuts.clear();
    noOfBulge.clear();
    isoFormat = "";
    punctureDateController.clear();
    costController.clear();
  }

  void clearRethreadForm() {
    rethreadSerialNo.clear();
    rethreadMountedPosition.clear();
    rethreadCenterName.clear();
    rethreadAvgCost.clear();
    rethreadPickupLogistics.clear();
    rethreadDateofDamage.clear();
    rethreadReturnDate.clear();
    isoFormat = "";
    mountedPosition7.value="";
  }

  void clearTireForm() {
    uploadedImageUrl = "";
    selectedImage1.value = null;
    customerEmailController.clear();
    serialNumberController.clear();
    tiredateController.clear();
    selectedBrand.value = "";
    selectedTireSize.value = "";
    selectedPlyRating.value = "";
    tireHealth2.value = "";
    status.value = "";
    vehicleNumberController.clear();
    mountedPosition2.value = "";
    tirebrandField.clear();
    tireplyField.clear();
    tiresizeField.clear();
    tireHealth.clear();
  }
  void clearWheelForm() {
    // Image
    uploadedImageUrl = "";
    selectedImage2.value = null;

    // Text fields
    customerEmailControllerWheel.clear();
    serialNumberControllerWheel.clear();
    vehicleNumberControllerWheel.clear();

    // Dropdowns / Rx values
    wheelConditionField.clear();
    wheelSizeField.clear();
    wheelMaterialField.clear();
    mountedPosition3.value = "";
    wheelStatus.value = "";

    // Date
    isoFormat = "";
    tiredateController2.clear(); // agar date show kar rahe ho TextField me
  }

  void clearTireReport(){
    tireSerialNumber.clear();
    tireNoteController.clear();
    tiredateController3.clear();
    mountedPosition5.value = "";
    severity.value = "";
    noOfDamage.value = 0;
    damageType.value = "";
    isoFormat = "";
  }
  void clearWheelReport(){
    wheelSerialNumber.clear();
    wheeldateController.clear();
    wheelNoteController.clear();
    mountedPosition6.value = "";
    severity1.value = "";
    noOfDamage1.value = 0;
    damageType1.value = "";
    isoFormat = "";
  }


  @override
  void dispose() {
    // TODO: implement dispose
    vehicleNumberController.dispose();
    customerEmailController.dispose();
    serialNumberController.dispose();
    tiredateController.dispose();
    customerEmailControllerWheel.dispose();
    serialNumberControllerWheel.dispose();
    vehicleNumberControllerWheel.dispose();
    tiredateController2.dispose();
    tiredateController3.dispose();
    tireSerialNumber.dispose();
    tireNoteController.dispose();
    wheelSerialNumber.dispose();
    wheeldateController.dispose();
    wheelNoteController.dispose();
    punctureSerialController.dispose();
    noOfPuncture.dispose();
    noOfCuts.dispose();
    noOfBulge.dispose();
    punctureDateController.dispose();
    costController.dispose();
    super.dispose();
  }

}
