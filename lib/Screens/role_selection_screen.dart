import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'user_dashboard.dart';
import 'volunteer_dashboard.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();

    Future<void> selectRole(String role) async {
      await userService.saveUserRole(role);

      if (role == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VolunteerDashboard()),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Role')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.report, color: Colors.green),
              title: const Text('Report Garbage'),
              subtitle: const Text('Help keep your community clean'),
              onTap: () => selectRole('user'),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.volunteer_activism, color: Colors.green),
              title: const Text('Collect Garbage'),
              subtitle: const Text('Volunteer to clean the community'),
              onTap: () => selectRole('volunteer'),
            ),
          ],
        ),
      ),
    );
  }
}
