# face_anti_spoofing_detector

face_anti_spoofing_detector is a Flutter plugin that provides passive liveness detection for facial recognition systems — ensuring that the detected face belongs to a live person rather than a photo, video, or mask.

This plugin integrates deep learning–based face anti-spoofing models to perform real-time, passive liveness detection directly on the device, without requiring user interaction.

### 🧩 Model Attribution

The core liveness detection model used in this plugin is adapted from the open-source project [Silent-Face-Anti-Spoofing](https://github.com/minivision-ai/Silent-Face-Anti-Spoofing) by **MiniVision AI**.  
Full credit to the original authors for their excellent research and implementation.


## Getting Started

### import plugin

```dart
import 'package:face_anti_spoofing_detector/face_anti_spoofing_detector.dart';
```

### Initialize Model

```dart
final status = await FaceAntiSpoofingDetector.initialize();
```

### Start detect

```dart

final confidenceScore = await FaceAntiSpoofingDetector.detect(
    yuvBytes: yuvBytes,
    previewWidth: cameraViewSize.width.toInt(),
    previewHeight: cameraViewSize.height.toInt(),
    orientation: 7,
    faceContour : faceContour,
);

```

### Release memory

```dart
final status = await FaceAntiSpoofingDetector.destroy();
```

<br>
<br>
<br>
<br>

## 📬 Contact

If you have any questions, suggestions, or issues, feel free to reach out via my website:

👉 [Website](https://horleng.vercel.app)
