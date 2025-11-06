import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'face_anti_spoofing_detector_platform_interface.dart';

/// An implementation of [LivenessDetectorPlatform] that uses method channels.
class MethodChannelFaceAntiSpoofingDetector extends FaceAntiSpoofingDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.leng.dev/liveness_detector');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> initialize() async {
    final result = await methodChannel.invokeMethod<bool>('initialize');
    return result ?? false;
  }

  @override
  Future<bool> destroy() async {
    final result = await methodChannel.invokeMethod<bool>('destroy');
    return result ?? false;
  }

  @override
  Future<double?> detectLiveness({
    required Uint8List yuvBytes, 
    required int previewWidth, 
    required int previewHeight, 
    required int orientation, 
    required Rect faceContour
  }) async {
    final result = await methodChannel.invokeMethod(
        'detect_liveness',
        {
          'yuvBytes': yuvBytes,
          'previewWidth': previewWidth,
          'previewHeight': previewHeight,
          'orientation': orientation,
          'faceBox': {
            'left': faceContour.left.toInt(),
            'top': faceContour.top.toInt(),
            'right': faceContour.right.toInt(),
            'bottom': faceContour.bottom.toInt(),
          }
        },
      );
      return result;
  }

}
