import 'package:flutter/material.dart';

class ReviewedStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;

  const ReviewedStars({
    Key? key,
    required this.rating,
    this.starSize = 18,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        IconData icon;
        if (index < rating.floor()) {
          icon = Icons.star;
        } else if (index < rating && rating % 1 >= 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(
          icon,
          color: color,
          size: starSize,
        );
      }),
    );
  }
}