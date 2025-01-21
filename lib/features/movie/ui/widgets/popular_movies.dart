import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexplore/features/movie/logic/popular/popular_movies_cubit.dart';
import 'package:nexplore/features/movie/logic/popular/popular_movies_state.dart';

import '../../../../core/di/module.dart';
import '../../../../core/network/constants.dart';
import '../../../../core/themes/TextStyles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../model/MovieResponse.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<PopularMoviesCubit>()..emitStates(),
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
          child: SizedBox(
              width: double.infinity,
              height: 330,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular', style: TextStyles.popular),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorName.borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text(
                          'See All',
                          style: TextStyles.seeAll,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 283,
                  child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                    builder: (context, state) {
                      if (state is PopularMovieLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PopularMovieSuccess) {
                        MoviesResponse moviesResponse =
                            state.data as MoviesResponse;
                        List<Results>? results = moviesResponse.results;
                        return ListView.builder(
                          itemCount: results!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(right: 8, bottom: 8),
                            child: SizedBox(
                              width: 143,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 128,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '$imageUrl${results[index].posterPath}'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text('${results[index].title}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.movieName),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Assets.images.star.svg(),
                                          SizedBox(
                                            width: 1.5,
                                          ),
                                          Text(
                                            '${results[index].voteAverage}',
                                            style: TextStyles.movieRate,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Wrap(
                                        children: List.generate(
                                          results[index].genreIds!.length > 3
                                              ? 3
                                              : results[index].genreIds!.length,
                                          (i) => Container(
                                            margin: EdgeInsets.only(right: 8),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 12),
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorName.lightIndigoColor,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Text(
                                              '${results[index].genreIds![i]}',
                                              style: TextStyles.tags,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Assets.images.clock.svg(),
                                          SizedBox(
                                            width: 1.5,
                                          ),
                                          Text(
                                            '${results[index].releaseDate}',
                                            style: TextStyles.movieRate,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (state is PopularMovieError) {
                        return Center(child: Text(state.error.status_message));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ])),
        ));
  }
}
