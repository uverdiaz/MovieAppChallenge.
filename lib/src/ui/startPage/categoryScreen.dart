import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/model/movies.dart';

import '../../bloc/GenderBloc/genderBloc.dart';
import '../../bloc/GenderBloc/genderEvent.dart';
import '../../bloc/GenderBloc/genderState.dart';
import '../../bloc/moviesBloc/movieBloc.dart';
import '../../bloc/moviesBloc/movieEvent.dart';
import '../../bloc/moviesBloc/movieState.dart';
import '../../model/gender.dart';
import '../widgets/itemMovie.dart';

class CategoryScreen extends StatefulWidget {
  final int selectedGender;

  CategoryScreen({this.selectedGender = 28});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  int selectedGender = 28;
  double rating = 0;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenderBloc>(
          create: (_) => GenderBloc()..add(const GenderEventStarted()),
        ),
        BlocProvider<MovieBloc>(
          create: (_) =>
              MovieBloc()..add(MovieEventStarted(selectedGender, '')),
        ),
      ],
      child: _buildGender(context),
    );
  }

  Widget _buildGender(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: BlocBuilder<GenderBloc, GenderState>(
              builder: (context, state) {
                if (state is GenderLoading) {
                  return Center(
                    child: Platform.isAndroid
                        ? const CircularProgressIndicator()
                        : const CupertinoActivityIndicator(),
                  );
                } else if (state is GenderLoaded) {
                  List<Gender> genres = state.genreList;
                  return SizedBox(
                    height: 55,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const VerticalDivider(
                        color: Colors.transparent,
                        width: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        Gender genre = genres[index];
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Gender gender = genres[index];
                                  selectedGender = gender.id;
                                  context.read<MovieBloc>().add(
                                      MovieEventStarted(selectedGender, ''));
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 145,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (genre.id == selectedGender)
                                        ? const Color(0xFF1377E4)
                                        : const Color(0xFF292A29),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  color: (genre.id == selectedGender)
                                      ? const Color(0xFF1377E4)
                                      : const Color(0xFF292A29),
                                ),
                                child: Text(
                                  genre.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'muli',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<MovieBloc, MovieState>(
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
        ],
      ),
    );
  }
}
