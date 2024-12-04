import 'package:flutter/material.dart';

class ProcessingButtons extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback onProcess;
  final VoidCallback onReset;

  const ProcessingButtons({
    super.key,
    required this.isProcessing,
    required this.onProcess,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isProcessing ? null : onProcess,
          child: const Text("Processar Imagem"),
        ),
        OutlinedButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          label: const Text("Apagar Conversão"),
        ),
      ],
    );
  }
}
