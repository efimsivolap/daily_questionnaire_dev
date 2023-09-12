class QuestionModel {
  final String title;
  final String? subtitle;
  final int maxStars;
  final bool canWriteReview;

  QuestionModel({
    required this.title,
    this.subtitle,
    required this.maxStars,
    required this.canWriteReview,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      title: json['title'],
      subtitle: json['subtitle'],
      maxStars: json['maxStars'],
      canWriteReview: json['canWriteReview'] ?? false,
    );
  }
}
