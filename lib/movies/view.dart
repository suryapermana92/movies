import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/state.dart';
import 'package:movies/movies/widgets/MovieItem.dart';
import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class MoviesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (BuildContext context, state) {

          return Scaffold(
            appBar: AppBar(
              title: Text('Movies List'),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: Colors.grey[300],

                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Showing ${bloc.moviesList.length} results out of ${bloc.totalResults}'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            hoverThickness: 8,
                            isAlwaysShown: true,
                            radius: Radius.circular(4),

                            thickness:8 ,
                            child: ListView(
                            controller: bloc.movieScrollController,

                            physics: BouncingScrollPhysics(),
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16,),
                                  itemCount: bloc.moviesList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return MovieItem(
                                     movie: bloc.moviesList[index],
                                    );
                                  }),

                            ],
                        ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state is LoadingMovies ? Positioned(
                    bottom: 0,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black54,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(height: 8,),
                            Text('Loading More Data',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                          ],
                        ) ,
                      ),
                    ),
                  ): SizedBox()
                ],
              ),
            ),
          );
        }
    );
  }
}
