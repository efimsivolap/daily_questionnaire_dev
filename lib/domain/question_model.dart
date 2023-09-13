import 'package:flutter/foundation.dart' show immutable;

@immutable
class QuestionModel {
  const QuestionModel({
    required this.title,
    this.subtitle,
    required this.maxStars,
    required this.canWriteReview,
  });

  final String title;
  final String? subtitle;
  final int maxStars;
  final bool canWriteReview;

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      maxStars: json['maxStars'] as int,
      canWriteReview: json['canWriteReview'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'maxStars': maxStars,
      'canWriteReview': canWriteReview,
    };
  }
}
