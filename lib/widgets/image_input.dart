import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(
        Icons.camera,
      ),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (selectedImage != null) {
      content = GestureDetector(
          onTap: _takePicture,
          child: Image.file(
            selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ));
    }

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withAlpha(40))),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
