import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarPicker extends StatelessWidget {
  ProfileAvatarPicker({super.key, required this.onImagePicked});
  final void Function(File file) onImagePicked;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: openImagePicker,
        label: Text('Choose your image'),
      ),
    );
  }

  void openImagePicker() async {
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image == null) {
      return;
    }
    onImagePicked(File(image.path));
  }
}
