import 'package:flutter/material.dart';
import 'package:tire_eagle/constants/constants_widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/png/scan.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 100), // Just spacing for testing
            customText(text: "Hamza"),
          ],
        ),
      ),
    );
  }
}
