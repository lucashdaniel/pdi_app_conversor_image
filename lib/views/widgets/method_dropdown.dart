import 'package:flutter/material.dart';

class MethodDropdown extends StatelessWidget {
  final String? selectedMethod;
  final List<String> methods;
  final ValueChanged<String?> onChanged;

  const MethodDropdown({
    super.key,
    required this.selectedMethod,
    required this.methods,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedMethod,
      hint: const Text("Selecione a transformação"),
      items: methods
          .map((method) => DropdownMenuItem(value: method, child: Text(method)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
