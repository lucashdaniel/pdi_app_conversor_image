import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/controllers/image_processor_controller.dart';

class ImagePickerWidget extends StatelessWidget {
  final ImageController controller;
  final Function onImageSelected;

  const ImagePickerWidget({
    Key? key,
    required this.controller,
    required this.onImageSelected,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final matImage = await controller.pickImageFromSource(source);
      if (matImage != null) {
        onImageSelected(matImage);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao abrir a câmera ou galeria: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage(context, ImageSource.gallery),
          icon: const Icon(Icons.image),
          label: const Text("Escolher da Galeria"),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () => _pickImage(context, ImageSource.camera),
          icon: const Icon(Icons.camera_alt),
          label: const Text("Tirar Foto"),
        ),
      ],
    );
  }
}
