import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  try {
    print("Testing image package...");
    int targetSize = 512;
    img.Image canvas = img.Image(width: targetSize, height: targetSize, numChannels: 4);
    for (var p in canvas) {
      p.setRgba(0, 0, 0, 0);
    }
    print("Success!");
  } catch (e) {
    print("Error: $e");
  }
}
