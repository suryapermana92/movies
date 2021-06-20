import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:movies/movies/model/movie_list.dart';
import 'package:movies/movies/movies.service.dart';
import 'package:movies/movies/widgets/MovieItem.dart';

import 'event.dart';
import 'state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesState().init());
  ScrollController movieScrollController = ScrollController();
  bool isLoading = true;
  List<Movie> moviesList = [];
  int currentPage = 1;
  int totalPages = 1;
  int totalResults = 0;
  late Movie selectedMovie;



  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is InitEvent) {
      movieScrollController.addListener(() {
        if(movieScrollController.hasClients) {
          if (movieScrollController.position.pixels ==
              movieScrollController.position.maxScrollExtent) {
            this.add(FetchNextPageEvent());
          }
        }
      });

      yield await fetchMovies();
    } else if (event is FetchNextPageEvent) {
      if(currentPage < totalPages) {
        if(state is !LoadingMovies) {
          yield LoadingMovies();
          yield await fetchNextPageMovies();
        }


      }
     yield LoadingMoviesSuccess();
    } else if(event is SelectMovie) {
      selectedMovie = event.selectedMovie ?? Movie(
          id: 00,
          title: "No Title"
      );
    }
  }

  Future<MoviesState> init() async {

    return state.clone();
  }
  Future<MoviesState> fetchMovies() async {
    try{
      Response response = await MovieService.getMoviesPage(currentPage);
      if(response.statusCode == 200) {

        var decodedJson = jsonDecode(response.body);
        MovieResult newMovieResult = MovieResult.fromMap(decodedJson);
        totalPages = newMovieResult.totalPages!;
        totalResults = newMovieResult.totalResults!;
        moviesList = newMovieResult.results!;
        return LoadingMoviesSuccess();

      } else {
        return LoadingMoviesFailed();
      }
    } catch (e) {
      print(e);
      return LoadingMoviesFailed();
    }
  }

  Future<MoviesState> fetchNextPageMovies() async {
    currentPage++;
    try {
    Response response = await MovieService.getMoviesPage(currentPage);
    if(response.statusCode == 200) {

       var decodedJson = jsonDecode(response.body);
       MovieResult newMovieResult = MovieResult.fromMap(decodedJson);
       moviesList = []..addAll(moviesList)..addAll(newMovieResult.results!);
       return FetchNextPageMoviesSuccess();

      } else {
        return FetchNextPageMoviesFailed();
      }
    } catch (e) {
      print(e);
      return FetchNextPageMoviesFailed();
    }
  }
}
