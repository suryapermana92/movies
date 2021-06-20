import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/event.dart';
import 'package:movies/movies/model/movie_list.dart';

import '../bloc.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movie, this.imageWidth = 185}) : super(key: key);

  final Movie movie;
  final int imageWidth;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);

    final textTheme = Theme.of(context).textTheme;
    final imagePath = movie.backdropPath == null ? 'https://cdn.bodybigsize.com/wp-content/uploads/2020/02/noimage-12.png' : 'http://image.tmdb.org/t/p/w${imageWidth}${movie.backdropPath!}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
          borderRadius: BorderRadius.circular(16),

          child: InkWell(
            borderRadius: BorderRadius.circular(16),

            onTap: () {
              bloc.add(SelectMovie(selectedMovie: movie));
              Navigator.of(context).pushNamed('/movie-detail');
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 185,

                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.network(imagePath)),
                      SizedBox(height: 8,),
                      Text(movie.title,style: textTheme.headline6,textAlign: TextAlign.center,),
                      SizedBox(height: 8,),
                      Text("TMDB Score: ${movie.voteAverage}/10")
                    ],
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Release: ", style: textTheme.bodyText1,),
                      Text("${movie.releaseDate.toString().split(" ")[0]}", style: textTheme.caption,),
SizedBox(height: 16,),
                      Text("Overview",style: textTheme.bodyText1,),
                      Text("${movie.overview}",style: textTheme.caption)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}