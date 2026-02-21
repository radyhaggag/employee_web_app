import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttachmentsSection extends StatelessWidget {
  const AttachmentsSection({
    super.key,
    required this.onAddAttachment,
    required this.attachments,
  });

  final Function(List<File>) onAddAttachment;
  final List<File> attachments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Attachments",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _pickAttachment,
          icon: const Icon(Icons.attach_file),
          label: const Text("Add Attachment"),
        ),
        const SizedBox(height: 8),
        // Display attachments if needed
        if (attachments.isNotEmpty)
          Text("${attachments.length} attachment(s) added"),
      ],
    );
  }

  Future<void> _pickAttachment() async {
    if (kIsWeb) {
      await _pickInWeb();
    } else {
      await _pickInMobile();
    }
  }

  Future<void> _pickInMobile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      onAddAttachment(files);
    }
  }

  Future<void> _pickInWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<Uint8List> fileBytes = result.files
          .map((file) => file.bytes!)
          .toList();

      onAddAttachment(
        fileBytes.map((bytes) => File(bytes.toString())).toList(),
      );
    }
  }
}
