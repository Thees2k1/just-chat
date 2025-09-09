import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPreview extends StatefulWidget {
  const ImagePickerPreview({super.key});

  @override
  State<ImagePickerPreview> createState() => _ImagePickerPreviewState();
}

class _ImagePickerPreviewState extends State<ImagePickerPreview> {
  File? previewFile;
  void _pickedImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);
  if(pickedImage == null){
    return;
  }
  setState(() {
    previewFile = File(pickedImage.path);
  });
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundImage: previewFile != null ? FileImage(previewFile!) : null,
        ),

        TextButton.icon(
          onPressed: _pickedImage,
          label: Text(
            'Add image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: Icon(Icons.image, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}
