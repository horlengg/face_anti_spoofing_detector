Pod::Spec.new do |s|
  s.name             = 'face_anti_spoofing_detector'
  s.version          = '0.0.4'
  s.summary          = 'A Flutter plugin for passive face liveness detection.'
  s.description      = <<-DESC
Flutter plugin that provides passive liveness detection for facial recognition systems.
  DESC
  s.homepage         = 'https://github.com/horlengg/face_anti_spoofing_detector'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }

  s.source_files     = 'Classes/**/*'

  s.resource_bundles = {
    'face_anti_spoofing_detector' => ['Resources/**/*']
  }

  s.dependency 'Flutter'
  s.platform         = :ios, '12.0'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',

    'HEADER_SEARCH_PATHS' => '$(inherited) "${PODS_TARGET_SRCROOT}/ncnn.xcframework/ios-arm64/ncnn.framework/Headers"',

    'GCC_PREPROCESSOR_DEFINITIONS[sdk=iphoneos*]' => '$(inherited) HAS_NCNN=1',
    'GCC_PREPROCESSOR_DEFINITIONS[sdk=iphonesimulator*]' => '$(inherited) HAS_NCNN=0',

    # 🔥 FIXED PATH (important)
    'FRAMEWORK_SEARCH_PATHS[sdk=iphoneos*]' => '$(inherited) "${PODS_TARGET_SRCROOT}/ncnn.xcframework/ios-arm64" "${PODS_TARGET_SRCROOT}/openmp.xcframework/ios-arm64"',

    # 🔥 correct linking
    'OTHER_LDFLAGS[sdk=iphoneos*]' => '$(inherited) -framework ncnn -framework openmp -lc++'
  }

  s.swift_version = '5.0'
end