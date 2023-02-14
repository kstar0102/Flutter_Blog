import 'dart:convert';

class CommentItemColor {
  final String value;
  final String colorHex;
  CommentItemColor({
    required this.value,
    required this.colorHex,
  });

  CommentItemColor copyWith({
    String? value,
    String? colorHex,
  }) {
    return CommentItemColor(
      value: value ?? this.value,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'colorHex': colorHex,
    };
  }

  factory CommentItemColor.fromMap(Map<String, dynamic> map) {
    return CommentItemColor(
      value: map['value'] ?? '',
      colorHex: map['colorHex'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentItemColor.fromJson(String source) =>
      CommentItemColor.fromMap(json.decode(source));

  @override
  String toString() => 'CommentItemColor(value: $value, colorHex: $colorHex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentItemColor &&
        other.value == value &&
        other.colorHex == colorHex;
  }

  @override
  int get hashCode => value.hashCode ^ colorHex.hashCode;
}
