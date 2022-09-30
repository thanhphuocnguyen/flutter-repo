import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImagePickerField extends StatefulWidget {
  final Function onSelectImage;
  const ImagePickerField({Key? key, required this.onSelectImage})
      : super(key: key);

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  File? _imageStored;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      if (imageFile != null) {
        _imageStored = File(imageFile.path);
      }
    });
    if (_imageStored == null) {
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_imageStored!.path);
    final savedImage = await _imageStored!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _imageStored == null
              ? const Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _imageStored!,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: () {
                _takePicture();
              },
              icon: const Icon(Icons.camera),
              label: const Text('Take picutre')),
        )
      ],
    );
  }
}
