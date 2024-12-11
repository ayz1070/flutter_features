import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors.dart';
import '../../bloc/review_add_bloc.dart';
import '../../bloc/review_add_event.dart';

class ReviewStars extends StatefulWidget {
  final double? initialRating;
  final Function(double) onRatingChanged;

  const ReviewStars({Key? key, this.initialRating, required this.onRatingChanged}) : super(key: key);

  @override
  _ReviewStarsState createState() => _ReviewStarsState();
}

class _ReviewStarsState extends State<ReviewStars> {
  double? _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating ?? 0.0;
  }

  void _updateRating(BuildContext context, double rating) {
    setState(() {
      _currentRating = rating;
    });
    widget.onRatingChanged(rating);
    context.read<ReviewAddBloc>().add(StarRatingChanged(rating));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        IconData icon;
        Color color;

        // 현재 별의 색상 및 상태 결정
        if (_currentRating! >= starIndex) {
          icon = Icons.star_rate_rounded;
          color = AppColors.iconStarPrimaryColor;
        } else if (_currentRating! >= starIndex - 0.5) {
          icon = Icons.star_half_rounded;
          color = AppColors.iconStarPrimaryColor;
        } else {
          icon = Icons.star_border_rounded;
          color = AppColors.iconStarSecondaryColor;
        }

        return GestureDetector(
          onTapDown: (details) {
            final box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            final isHalf = localPosition.dx < box.size.width / 2;
            final rating = isHalf ? starIndex - 0.5 : starIndex.toDouble();
            _updateRating(context, rating);
          },
          child: Icon(
            icon,
            color: color,
            size: 35,
          ),
        );
      }),
    );
  }
}