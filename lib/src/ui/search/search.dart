import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/moviesBloc/movieBloc.dart';
import '../../bloc/moviesBloc/movieEvent.dart';
import '../../bloc/moviesBloc/movieState.dart';
import '../widgets/itemMovie.dart';
import '../../model/movies.dart';
class Search extends StatefulWidget {
  const Search();

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int selectedGender = 10402;
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
    TextEditingController controllerSearch = TextEditingController();
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 18.0, right: 18.0),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(4.0),
                            color: const Color(0xFF2C2D2C)),
                        child: TextField(
                          controller: controllerSearch,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search",

                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle:
                            TextStyle(fontSize: 20, color: Colors.white),
                            contentPadding:
                            EdgeInsets.only(
                                left: 15.0, top: 5.0),
                          ),
                          onChanged: null,
                          onSubmitted: (term) {},
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 40,
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
