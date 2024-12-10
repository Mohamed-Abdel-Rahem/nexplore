import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexplore/core/network/constants.dart';
import 'package:nexplore/features/details/ui/widgets/common_details_section.dart';
import 'package:nexplore/features/details/ui/widgets/movie_rating_widget.dart';
import 'package:nexplore/features/details/ui/widgets/overview_section.dart';
import 'package:nexplore/features/details/ui/widgets/title_section.dart';
import 'package:nexplore/features/movie/model/MovieResponse.dart';

import '../../../../gen/assets.gen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Results movie = ModalRoute.of(context)?.settings.arguments as Results;
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 300.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            background: Stack(fit: StackFit.passthrough, children: [
          Image.network(
            '$imageUrl${movie.backdropPath}',
            fit: BoxFit.cover,
          ),
          Center(child: Assets.images.play.svg(width: 50.w, height: 50.h))
        ])),
      ),
      SliverPadding(
        padding: EdgeInsets.all(24.r),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              TitleSection(movie.title!),
              SizedBox(height: 8.h),
              MovieRatingWidget(movie.voteAverage!),
              SizedBox(height: 16.h),
              CommonDetailsSection(movie),
              SizedBox(height: 32.h),
              OverviewSection(movie.overview!),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      )
    ]));
  }
}
