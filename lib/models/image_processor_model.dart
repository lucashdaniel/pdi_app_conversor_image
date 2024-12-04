import 'package:opencv_dart/opencv.dart' as cv;

class ImageProcessor {
  Future<cv.Mat> convertToGray(cv.Mat mat) async {
    return await cv.cvtColorAsync(mat, cv.COLOR_BGR2GRAY);
  }

  Future<cv.Mat> applyGaussianBlur(cv.Mat mat) async {
    return await cv.gaussianBlurAsync(mat, (7, 7), 1.5, sigmaY: 1.5);
  }

  Future<cv.Mat> detectEdges(cv.Mat mat) async {
    return await cv.cannyAsync(mat, 100, 200);
  }

  Future<cv.Mat> binarize(cv.Mat mat) async {
    final result = await cv.thresholdAsync(mat, 127, 255, cv.THRESH_BINARY);
    return result.$2;
  }

  Future<cv.Mat> applyMorphology(cv.Mat mat) async {
    final kernel = cv.getStructuringElement(cv.MORPH_RECT, (5, 5));
    return await cv.morphologyExAsync(mat, cv.MORPH_CLOSE, kernel);
  }
}
