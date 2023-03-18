import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/bloc/movieReviewBloc/movieReviewlBloc.dart';
import 'package:untitled1/src/model/movieReview.dart';
import 'package:untitled1/src/ui/%20movieDetail/reviewModel.dart';

import '../../bloc/movieDetailBloc/movieDetailBloc.dart';
import '../../bloc/movieDetailBloc/movieDetailEvent.dart';
import '../../bloc/movieDetailBloc/movieDetailState.dart';
import '../../bloc/movieReviewBloc/movieReviewEvent.dart';
import '../../bloc/movieReviewBloc/movieReviewState.dart';
import '../../model/movieDetail.dart';
import '../../model/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movies movie;

  const MovieDetailScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          MovieDetailBloc()
            ..add(MovieDetailEventStated(movie.id)),
        ),
        BlocProvider(
          create: (_) =>
          MovieReviewBloc()
            ..add(MovieReviewEventStated(movie.id)),
        ),
      ],
      child: WillPopScope(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildDetailBody(context),
              ],
            ),
          ),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget _buildDetailBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              );
            } else if (state is MovieDetailLoaded) {
              MovieDetail movieDetail = state.detail;
              return Stack(
                children: <Widget>[
                  ClipPath(
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/original/${movieDetail
                            .backdropPath}',
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 3,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        Platform.isAndroid
                            ? const CircularProgressIndicator()
                            : const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            Container(
                              decoration: const BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                  AssetImage('assets/images/img_not_found.jpg'),
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppBar(
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_outlined),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 4.2,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 40.0,
                              width: 110.0 * movieDetail.genres.length,
                              padding: const EdgeInsets.only(top: 5, left: 15),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movieDetail.genres.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 90,
                                      padding: const EdgeInsets.only(top: 10),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF292A29),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        movieDetail.genres[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 5),
                              child: Container(
                                height: 34,
                                width: 90,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF292A29),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 16,
                                      ),
                                    ),
                                    Text(
                                      double.parse(movie.voteAverage).toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    movieDetail.title,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Container(
                              height: 20 * (movieDetail.overview.length / 50),
                              child: Text(
                                movieDetail.overview,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 70,
                            ),
                            const SizedBox(
                              height: 20,
                              child: Text(
                                'Review',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        BlocBuilder<MovieReviewBloc, MovieReviewState>(
          builder: (context, state) {
            if (state is MovieReviewLoading) {
              return const Center();
            } else if (state is MovieReviewLoaded) {
              List<MovieReview> movieList = state.review;
              print(movieList.length);
              return SizedBox(
                height: movieList.length * 300.0,
                child: ListView.builder(
                  itemCount: movieList.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  itemBuilder: (context, index) {
                    MovieReview movie = movieList[index];
                    var rating = double.parse(movie.rating);
                    return Column(
                      children: [
                        modelItemMovieReview(movie, rating),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 85,
                          endIndent: 21,
                          color: Colors.grey,
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
      ],
    );
  }
}
