import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  var currentIndex = 0.obs;
  var selectedIndexTab = 0.obs;
  var inventoryIndexTab = 0.obs;
  var reportIndexTab = 0.obs;
  var addNewTab = 0.obs;
  String? selectedValue;
  var inventorySelectedIndex = 1.obs;
  PageController? _pageController;
  RxString selectedPosition = ''.obs;
  List<String> positions = [];
  void changePage(int index) {
    currentIndex.value = index;
    if (_pageController?.hasClients ?? false) {
      _pageController!.jumpToPage(index);
    } else {
      debugPrint("⚠️ PageController not set or not attached");
    }
  }

  void setPageController(PageController controller){
    _pageController = controller;
  }

  void selectTabSearch(int index) {
    selectedIndexTab.value = index;
  }

  void selectInventoryValue(int index) {
    inventoryIndexTab.value = index;
  }
  void reportValuetoggle(int index) {
    reportIndexTab.value = index;
  }
  void addNewToggle(int index) {
    addNewTab.value = index;
  }
  final List<String> addTab = [
    "Add New Tire",
    "Add New Wheel",
  ];

  final List<String> notificationTabs = [
    "All",
    "Maintenance",
    "Warning",
    "Replacement",
    "Filter",
  ];
  final List<String> inventoryTabs = [
    "In Use",
    "In Stock",
    "In Disposed",
  ];
  final List<String> reportTabs = [
    "Last Week",
    "Last Month",
    "Filter",
  ];
}
