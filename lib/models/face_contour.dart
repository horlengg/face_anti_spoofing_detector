
class FaceContour {
  final int left;
  final int top;
  final int right;
  final int bottom;

  FaceContour({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  Map<String, int> toMap() => {
    'left': left,
    'top': top,
    'right': right,
    'bottom': bottom,
  };
}
