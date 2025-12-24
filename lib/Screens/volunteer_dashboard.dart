import 'package:flutter/material.dart';

class VolunteerDashboard extends StatelessWidget {
  const VolunteerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Volunteer Dashboard',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
