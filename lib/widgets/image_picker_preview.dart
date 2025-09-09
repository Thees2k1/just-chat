import 'dart:io';

// ignore: implementation_imports
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPreview extends StatefulWidget {
  const ImagePickerPreview({super.key});

  @override
  State<ImagePickerPreview> createState() => _ImagePickerPreviewState();
}

class _ImagePickerPreviewState extends State<ImagePickerPreview> {
  File? previewFile;
  void _pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      previewFile = File(pickedImage.path);
    });
  }
  bool isUploaded =false;
  String? imageUrl ;

  void _uploadImage() async {
    try {
      Cloudinary cloudinary = Cloudinary.fromCloudName(
        cloudName: "<your_cloud_name>",
      );
      final response = await cloudinary.uploader().upload(
        previewFile!,
        params: UploadParams(uploadPreset: "<your_upload_preset>", type: "raw"),
      );
      if(response?.data !=null){
        setState(() {
          isUploaded =true;
          imageUrl = response!.data!.url;
        });

      }
    } catch (e) {
      debugPrint("Upload error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        isUploaded ? CircleAvatar(
          radius: 48,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundImage: NetworkImage(imageUrl!),
        ): CircleAvatar(
          radius: 48,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundImage:  previewFile != null ? FileImage(previewFile!) : null,
        ),

        SizedBox(height: 8),
        Row(
          children: [
            TextButton.icon(
              onPressed: _pickedImage,
              label: Text(
                'Add image',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              icon: Icon(
                Icons.image,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (previewFile != null) ...[
              SizedBox(width: 4),
              TextButton.icon(
                onPressed: _uploadImage,
                label: Text(
                  'Upload image',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                icon: Icon(
                  Icons.image,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
