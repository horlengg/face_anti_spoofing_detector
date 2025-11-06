
// export 'models/face_contour.dart';
// export 'face_anti_spoofing_detector_platform_interface.dart';


import 'package:face_anti_spoofing_detector/face_anti_spoofing_detector_platform_interface.dart';
import 'package:flutter/services.dart';

class FaceAntiSpoofingDetector {

  static Future<bool> initialize() async {
    return FaceAntiSpoofingDetectorPlatform.instance.initialize();
  }


  static Future<bool> destroy() {
    return FaceAntiSpoofingDetectorPlatform.instance.destroy();
  }


  static Future<double?> detect({
    required Uint8List yuvBytes, 
    required int previewWidth, 
    required int previewHeight, 
    required int orientation, 
    required Rect faceContour
  }) async {
      return FaceAntiSpoofingDetectorPlatform.instance.detectLiveness(
        yuvBytes: yuvBytes,
        previewHeight: previewHeight,
        previewWidth: previewWidth,
        faceContour: faceContour,
        orientation: orientation
      );
  }

}