import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nexplore/core/network/api_services.dart';
import 'package:nexplore/core/network/dio_factory.dart';
import 'package:nexplore/features/details/logic/casting/movie_cast_cubit.dart';
import 'package:nexplore/features/movie/logic/popular/popular_movies_cubit.dart';
import 'package:nexplore/features/movie/repo/movie_repo.dart';

import '../../features/details/repo/movie_details_repo.dart';
import '../../features/movie/logic/now_showing/movie_cubit.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Register your dependencies here
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());
  getIt.registerSingleton<ApiServices>(ApiServicesImpl(getIt()));
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository(getIt()));
  getIt.registerLazySingleton<MovieDetailsRepository>(
      () => MovieDetailsRepository(getIt()));
  getIt.registerSingleton<MovieCubit>(MovieCubit(getIt()));
  getIt.registerSingleton<PopularMoviesCubit>(PopularMoviesCubit(getIt()));
  getIt.registerSingleton<MovieCastCubit>(MovieCastCubit(getIt()));
}
