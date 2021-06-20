import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/utils.dart';

import 'bloc.dart';
import 'model/movie_list.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  List<Widget> _buildGenre(List<int> genre, context) {
    List<Widget> genreList = [];
    for (var i = 0; i < genre.length; i++) {
      genreList.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.black),
        child: Text(
          Utils.getGenreString(genre[i]),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ));
    }
    return genreList;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);
    Movie movie = bloc.selectedMovie;
    final imagePath = movie.backdropPath == null
        ? 'https://cdn.bodybigsize.com/wp-content/uploads/2020/02/noimage-12.png'
        : 'http://image.tmdb.org/t/p/w${500}${movie.backdropPath!}';
    final posterPath = movie.posterPath == null
        ? 'https://cdn.bodybigsize.com/wp-content/uploads/2020/02/noimage-12.png'
        : 'http://image.tmdb.org/t/p/w${500}${movie.posterPath!}';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 600.0,
            pinned: true,
            backgroundColor:Colors.black,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
                background: Image.network(
                  posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )),
          ),
          new SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    children: _buildGenre(movie.genreIds!, context),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Release Date: ",
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    "${movie.releaseDate.toString().split(" ")[0]}",
                    style: textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Overview:",
                    style: textTheme.bodyText1,
                  ),
                  Text("${movie.overview}", style: textTheme.bodyText2),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Popularity",
                    style: textTheme.bodyText1,
                  ),
                  Text("${movie.popularity}", style: textTheme.bodyText2),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "TMDB Score",
                    style: textTheme.bodyText1,
                  ),
                  Text("${movie.voteAverage}/10 from ${movie.voteCount} votes",
                      style: textTheme.bodyText2),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Original Language",
                    style: textTheme.bodyText1,
                  ),
                  Text("${movie.originalLanguage}", style: textTheme.bodyText2),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Adult Rated?",
                    style: textTheme.bodyText1,
                  ),
                  Text("${movie.adult! ? "Yes" : "No"}",
                      style: textTheme.bodyText2),
                  SizedBox(
                    height: 300,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
