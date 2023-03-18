import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../movieDetail/movieDetail.dart';
import '../../bloc/moviesBloc/movieBloc.dart';
import '../../bloc/moviesBloc/movieState.dart';
import '../../model/movies.dart';
import 'categoryScreen.dart';

class StartPage extends StatelessWidget {
  const StartPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              );
            } else if (state is MovieLoaded) {
              List<Movies> movies = state.movieList;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      Movies movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movie),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                height:
                                    MediaQuery.of(context).size.height / 4.8,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Platform.isAndroid
                                        ? const CircularProgressIndicator()
                                        : const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) => Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/img_not_found.jpg'),
                                    ),
                                  ),
                                ),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4.8,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                      left: 15,
                                    ),
                                    child: Text(
                                      movie.title.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'muli',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 0.85,
                      enlargeCenterPage: true,
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Error ');
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              CategoryScreen()
            ],
          ),
        )
      ],
    );
  }
}
