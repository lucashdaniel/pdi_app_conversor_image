import 'package:flutter/material.dart';
import 'dart:typed_data';

class ImageDisplay extends StatelessWidget {
  final String label;
  final Uint8List? image;
  const ImageDisplay({
    super.key,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) return const SizedBox();
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Image.memory(
          image!,
          width: double.infinity,
          height: 300,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
