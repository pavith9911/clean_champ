import 'package:flutter/material.dart';
import 'report_garbage_screen.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.green,
      ),

      body: const Center(
        child: Text(
          'User Dashboard',
          style: TextStyle(fontSize: 22),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Report an Issue'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ReportGarbageScreen(),
            ),
          );
        },
      ),
    );
  }
}
