import 'package:employee_attendance_tracker/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final UserModel user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard - ${user.role.toString().split('.').last}'),
      ),
      body: Column(
        children: [
          if (user.permissions?.canScan == true)
            ElevatedButton(
              onPressed: () => scanCode(),
              child: const Text('Scan Code'),
            ),
          if (user.permissions?.canViewCode == true)
            ElevatedButton(
              onPressed: () => viewCode(),
              child: const Text('View Code'),
            ),
          if (user.permissions?.canGenerateReport == true)
            ElevatedButton(
              onPressed: () => generateReport(),
              child: const Text('Generate Report'),
            ),
        ],
      ),
    );
  }

  void scanCode() {
    // Scan functionality here
  }

  void viewCode() {
    // View code functionality here
  }

  void generateReport() {
    // Report generation functionality here
  }
}
