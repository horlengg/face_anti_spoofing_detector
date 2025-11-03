import 'package:flutter_test/flutter_test.dart';
import 'package:liveness_detector/liveness_detector.dart';
import 'package:liveness_detector/liveness_detector_platform_interface.dart';
import 'package:liveness_detector/liveness_detector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLivenessDetectorPlatform
    with MockPlatformInterfaceMixin
    implements LivenessDetectorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LivenessDetectorPlatform initialPlatform = LivenessDetectorPlatform.instance;

  test('$MethodChannelLivenessDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLivenessDetector>());
  });

  test('getPlatformVersion', () async {
    LivenessDetector livenessDetectorPlugin = LivenessDetector();
    MockLivenessDetectorPlatform fakePlatform = MockLivenessDetectorPlatform();
    LivenessDetectorPlatform.instance = fakePlatform;

    expect(await livenessDetectorPlugin.getPlatformVersion(), '42');
  });
}
