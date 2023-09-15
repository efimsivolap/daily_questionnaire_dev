import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.maxStars,
    required this.existingStars,
  });

  final int maxStars;
  final int existingStars;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stars = [];
    for (int i = 1; i <= maxStars; i++) {
      if (i <= existingStars) {
        stars.add(
          const Icon(
            Icons.star,
            color: Color.fromRGBO(0, 186, 244, 1),
            size: 38,
          ),
        );
      } else {
        stars.add(
          const Icon(
            Icons.star,
            color: Color(0xFFEDEDED),
            size: 38,
          ),
        );
      }
    }
    return Row(children: stars);
  }
}
