import 'package:nexplore/core/network/ApiResult.dart';
import 'package:nexplore/features/movie/model/MovieResponse.dart';

import '../../../core/network/api_services.dart';

class MovieRepository {
  final ApiServices _apiServices;

  MovieRepository(this._apiServices);

  Future<ApiResult<MoviesResponse>> getMovies() async {
    return await _apiServices.fetchNowShowingMovies();
  }

  Future<ApiResult<MoviesResponse>> getPopularMovies() async {
    return await _apiServices.fetchPopularMovies();
  }
}
