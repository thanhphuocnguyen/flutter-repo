import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key, required this.onSaveImage}) : super(key: key);
  final void Function(XFile? image) onSaveImage;
  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  XFile? _pickedPhoto;

  Future<void> _onImagePick() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedPhoto = image;
    });
    widget.onSaveImage(_pickedPhoto);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              _pickedPhoto == null ? null : FileImage(File(_pickedPhoto!.path)),
          backgroundColor: Colors.amber,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            primary: Colors.teal.shade900,
          ),
          onPressed: _onImagePick,
          icon: const Icon(Icons.image),
          label: const Text('Upload avatar'),
        ),
      ],
    );
  }
}
