import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../services/report_service.dart';

class ReportGarbageScreen extends StatefulWidget {
  const ReportGarbageScreen({super.key});

  @override
  State<ReportGarbageScreen> createState() => _ReportGarbageScreenState();
}

class _ReportGarbageScreenState extends State<ReportGarbageScreen> {
  File? image;
  String issueType = '';
  String description = '';
  double? lat;
  double? lng;
  bool loading = false;

  final picker = ImagePicker();
  final reportService = ReportService();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => image = File(picked.path));
    }
  }

  Future<void> getLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  Future<void> submit() async {
    if (image == null || issueType.isEmpty || lat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
      return;
    }

    setState(() => loading = true);

    await reportService.submitReport(
      image: image!,
      issueType: issueType,
      lat: lat!,
      lng: lng!,
      description: description,
    );

    setState(() => loading = false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Garbage')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                ),
                child: image == null
                    ? const Center(child: Text('Tap to add photo'))
                    : Image.file(image!, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              children: [
                choice('Plastic'),
                choice('Illegal Dumping'),
                choice('Overflow Bin'),
                choice('Street Litter'),
                choice('Hazardous'),
                choice('Other'),
              ],
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Use current location'),
            ),

            const SizedBox(height: 8),
            if (lat != null)
              Text('Location captured'),

            const SizedBox(height: 16),

            TextField(
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: 'Additional details'),
              onChanged: (v) => description = v,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loading ? null : submit,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Report'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget choice(String text) {
    final selected = issueType == text;
    return ChoiceChip(
      label: Text(text),
      selected: selected,
      onSelected: (_) {
        setState(() => issueType = text);
      },
    );
  }
}
