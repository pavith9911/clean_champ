import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRole(String role) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await _db.collection('users').doc(user.uid).set({
      'email': user.email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<String?> getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc =
        await _db.collection('users').doc(user.uid).get();

    return doc.data()?['role'];
  }
}
