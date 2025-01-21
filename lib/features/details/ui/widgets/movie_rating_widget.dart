import 'package:flutter/material.dart';

import '../../../../core/themes/TextStyles.dart';
import '../../../../gen/assets.gen.dart';

class MovieRatingWidget extends StatelessWidget {
  final double voteAverage;

  const MovieRatingWidget(this.voteAverage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.images.star.svg(),
        SizedBox(
          width: 1.5,
        ),
        Text(
          '$voteAverage',
          style: TextStyles.movieRate,
        )
      ],
    );
  }
}
