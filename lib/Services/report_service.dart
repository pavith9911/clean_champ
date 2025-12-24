import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReportService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> submitReport({
    required File image,
    required String issueType,
    required double lat,
    required double lng,
    String? description,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Upload image
    final ref = _storage
        .ref()
        .child('reports')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(image);
    final imageUrl = await ref.getDownloadURL();

    // Save report
    await _db.collection('reports').add({
      'userId': user.uid,
      'imageUrl': imageUrl,
      'issueType': issueType,
      'location': {'lat': lat, 'lng': lng},
      'description': description ?? '',
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
