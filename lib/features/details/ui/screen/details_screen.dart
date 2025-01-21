import 'package:flutter/material.dart';

import 'package:nexplore/core/network/constants.dart';
import 'package:nexplore/features/details/ui/widgets/movie_rating_widget.dart';
import 'package:nexplore/features/details/ui/widgets/overview_section.dart';
import 'package:nexplore/features/details/ui/widgets/title_section.dart';
import 'package:nexplore/features/movie/model/MovieResponse.dart';

import '../../../../gen/assets.gen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  static String id = 'DetailsScreen';

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
    return SafeArea(
      child: Scaffold(
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
            Center(child: Assets.images.play.svg(width: 50, height: 50))
          ])),
        ),
        SliverPadding(
          padding: EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                TitleSection(movie.title!),
                SizedBox(height: 8),
                MovieRatingWidget(movie.voteAverage!),
                SizedBox(height: 32),
                OverviewSection(movie.overview!),
                SizedBox(height: 32),
              ],
            ),
          ),
        )
      ])),
    );
  }
}
