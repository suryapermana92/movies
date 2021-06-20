import 'model/movie_list.dart';

abstract class MoviesEvent {}

class InitEvent extends MoviesEvent {}
class FetchNextPageEvent extends MoviesEvent {}
class SelectMovie extends MoviesEvent {
   final Movie? selectedMovie;
   SelectMovie({
    this.selectedMovie
  });
}
