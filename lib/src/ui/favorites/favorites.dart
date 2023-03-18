import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/moviesBloc/movieBloc.dart';
import '../../bloc/moviesBloc/movieEvent.dart';
import '../../bloc/moviesBloc/movieState.dart';
import '../widgets/itemMovie.dart';
import '../../model/movies.dart';
class Favorites extends StatefulWidget {
  const Favorites();

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  int selectedGender = 878;
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {

    return BlocProvider<MovieBloc>(
      create: (_) =>
      MovieBloc()..add(MovieEventStarted(selectedGender, ''))
      ,child: _buildFavorite(context),
    );
  }

  Widget _buildFavorite(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 27,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center();
                } else if (state is MovieLoaded) {
                  List<Movies> movieList = state.movieList;
                  print(movieList.length);
                  return SizedBox(
                    height: (movieList.length / 2) * 270,
                    child: GridView.builder(
                      itemCount: movieList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 270,
                      ),
                      itemBuilder: (context, index) {
                        Movies movie = movieList[index];
                        rating = double.parse(movie.voteAverage);
                        return modelItemMovie(movie, rating);
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
