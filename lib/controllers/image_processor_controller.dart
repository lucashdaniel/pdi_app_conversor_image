import 'dart:typed_data';
import 'package:flutter_application_1/models/image_processor_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv_dart/opencv.dart' as cv;

class ImageController {
  final ImageProcessor _processor = ImageProcessor();
  Uint8List? originalImage;
  Uint8List? processedImage;
  Future<cv.Mat?> pickImageFromSource(ImageSource source) async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: source);

    if (img != null) {
      final mat = cv.imread(img.path);
      originalImage = cv.imencode(".png", mat).$2;
      return mat;
    }
    return null;
  }

  Future<void> processImage(cv.Mat mat, String method) async {
    switch (method) {
      case 'Conversão de Cor':
        processedImage =
            cv.imencode(".png", await _processor.convertToGray(mat)).$2;
        break;
      case 'Filtro':
        processedImage =
            cv.imencode(".png", await _processor.applyGaussianBlur(mat)).$2;
        break;
      case 'Detecção de Borda':
        processedImage =
            cv.imencode(".png", await _processor.detectEdges(mat)).$2;
        break;
      case 'Binarização':
        processedImage = cv.imencode(".png", await _processor.binarize(mat)).$2;
        break;
      case 'Morfologia Matemática':
        processedImage =
            cv.imencode(".png", await _processor.applyMorphology(mat)).$2;
        break;
      default:
        throw Exception("Método inválido: $method");
    }
  }

  void reset() {
    originalImage = null;
    processedImage = null;
  }

  void setOriginalImage(cv.Mat matImage) {
    originalImage = cv.imencode(".png", matImage).$2;
  }
}
