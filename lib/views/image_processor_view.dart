import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/image_processor_controller.dart';
import 'package:flutter_application_1/views/widgets/image_display.dart';
import 'package:flutter_application_1/views/widgets/method_dropdown.dart';
import 'package:flutter_application_1/views/widgets/processing_buttons.dart';
import 'package:flutter_application_1/views/widgets/image_picker_widget.dart';
import 'package:opencv_dart/opencv.dart' as cv;

class ImageProcessorView extends StatefulWidget {
  const ImageProcessorView({Key? key}) : super(key: key);

  @override
  _ImageProcessorViewState createState() => _ImageProcessorViewState();
}

class _ImageProcessorViewState extends State<ImageProcessorView> {
  final ImageController _controller = ImageController();
  final List<String> methods = [
    'Conversão de Cor',
    'Filtro',
    'Detecção de Borda',
    'Binarização',
    'Morfologia Matemática'
  ];
  String? selectedMethod;
  bool isProcessing = false;

  void _onImageSelected(cv.Mat? matImage) {
    if (matImage != null) {
      _controller.setOriginalImage(matImage);
      setState(() {});
    }
  }

  Future<void> _applyProcessing() async {
    if (_controller.originalImage == null || selectedMethod == null) {
      _showErrorSnackBar("Selecione a imagem e a transformação desejada");
      return;
    }

    setState(() => isProcessing = true);
    try {
      final matImage = cv.imdecode(_controller.originalImage!, cv.IMREAD_COLOR);
      if (matImage.rows == 0 || matImage.cols == 0) {
        throw Exception("Falha ao converter a imagem para Mat.");
      }
      await _controller.processImage(matImage, selectedMethod!);
      setState(() {});
    } catch (e) {
      _showErrorSnackBar("Erro ao processar imagem: $e");
    } finally {
      setState(() => isProcessing = false);
    }
  }

  void _reset() {
    setState(() => _controller.reset());
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ImagePickerWidget(
                  controller: _controller,
                  onImageSelected: _onImageSelected,
                ),
                MethodDropdown(
                  selectedMethod: selectedMethod,
                  methods: methods,
                  onChanged: (method) =>
                      setState(() => selectedMethod = method),
                ),
                ProcessingButtons(
                  isProcessing: isProcessing,
                  onProcess: _applyProcessing,
                  onReset: _reset,
                ),
                ImageDisplay(
                  label: "Imagem Original",
                  image: _controller.originalImage,
                ),
                ImageDisplay(
                  label: "Imagem Processada",
                  image: _controller.processedImage,
                ),
              ],
            ),
          ),
          if (isProcessing) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
