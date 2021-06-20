import 'model/movie_list.dart';

class MoviesState {
  MoviesState init() {
    return MoviesState();
  }
  MoviesState clone() {
    return MoviesState();
  }
}
class LoadingMovies extends MoviesState{}
class LoadingInitialMovies extends MoviesState{}
class LoadingMoviesSuccess extends MoviesState{}
class LoadingMoviesFailed extends MoviesState{}

class FetchNextPageMovies extends MoviesState{}
class FetchNextPageMoviesSuccess extends MoviesState{}
class FetchNextPageMoviesFailed extends MoviesState{}
