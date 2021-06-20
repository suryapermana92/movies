import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/event.dart';
import 'package:movies/movies/model/movie_list.dart';

import '../bloc.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movie, this.imageWidth = 500})
      : super(key: key);

  final Movie movie;
  final int imageWidth;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);

    final textTheme = Theme.of(context).textTheme;
    final imagePath = movie.backdropPath == null
        ? 'https://cdn.bodybigsize.com/wp-content/uploads/2020/02/noimage-12.png'
        : 'http://image.tmdb.org/t/p/w${imageWidth}${movie.backdropPath!}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bloc.add(SelectMovie(selectedMovie: movie));
            Navigator.of(context).pushNamed('/movie-detail');
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3), //
                  )
                ]
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(0, 1),
                              end: Alignment(0, 0),
                              colors: [Colors.black, Colors.transparent])),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              movie.title,
                              style: textTheme.headline6,
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(movie.title,style: textTheme.headline6,textAlign: TextAlign.center,),
                      // SizedBox(height: 8,),
                      Text("TMDB Score: ${movie.voteAverage}"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Release: ",
                        style: textTheme.bodyText1,
                      ),
                      Text(
                        "${movie.releaseDate.toString().split(" ")[0]}",
                        style: textTheme.caption,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Overview",
                        style: textTheme.bodyText1,
                      ),
                      Text("${movie.overview}", style: textTheme.caption),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
