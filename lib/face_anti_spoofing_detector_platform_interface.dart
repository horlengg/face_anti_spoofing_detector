
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'face_anti_spoofing_detector_method_channel.dart';

abstract class FaceAntiSpoofingDetectorPlatform extends PlatformInterface {
  /// Constructs a FaceAntiSpoofingDetectorPlatform.
  FaceAntiSpoofingDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FaceAntiSpoofingDetectorPlatform _instance = MethodChannelFaceAntiSpoofingDetector();

  /// The default instance of [FaceAntiSpoofingDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFaceAntiSpoofingDetector].
  static FaceAntiSpoofingDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FaceAntiSpoofingDetectorPlatform] when
  /// they register themselves.
  static set instance(FaceAntiSpoofingDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> initialize() {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<bool> destroy() {
    throw UnimplementedError('destroy() has not been implemented.');
  }

  Future<double?> detectLiveness({
    required Uint8List yuvBytes,
    required int previewWidth,
    required int previewHeight,
    required int orientation,
    required Rect faceContour
  }) async {
    throw UnimplementedError('detectLiveness() has not been implemented.');
  }
}
