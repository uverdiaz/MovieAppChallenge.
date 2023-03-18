import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/bloc/movieReviewBloc/movieReviewlBloc.dart';
import 'package:untitled1/src/model/movieReview.dart';
import 'package:readmore/readmore.dart';
import 'package:untitled1/src/ui/movieDetail/reviewModel.dart';
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
                                image: DecorationImage(
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
                            const SizedBox(width: 15,),
                            Container(
                              height: 40.0,
                              width: 100.0 * movieDetail.genres.length,
                              padding: const EdgeInsets.only(top: 5),
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
                                height: 35,
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
                            const SizedBox(
                              width: 10,
                            )
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
                            Column(
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
                            const SizedBox(
                              height: 13,
                            ),
                            SizedBox(
                              height: 18 * (movieDetail.overview.length / 50),
                              child: ReadMoreText(
                                movieDetail.overview,
                                trimLines: 5,
                                style: const TextStyle(color: Colors.grey),
                                colorClickableText: Colors.blue,
                                trimMode: TrimMode.Length,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: const TextStyle(
                                    fontSize:  14.8, fontWeight: FontWeight.bold),
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
              List <MovieReview> movieListReview = state.review.isNotEmpty ? state.review : [];
              print(state.review);
              if (movieListReview.isNotEmpty){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20,top: 10 ),
                      child: SizedBox(
                        height: 20,
                        child: Text(
                          'Review',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: movieListReview.length.toDouble() * 200.0,
                      child: ListView.builder(
                        itemCount: movieListReview.length.toInt(),
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        itemBuilder: (context, index) {
                          MovieReview movie = movieListReview[index];
                          var rating = movie.rating.toString() != 'null' ? double.parse(movie.rating.toString()).toDouble(): 0.0;
                          return Column(
                            children: [
                              modelItemMovieReview(movie, rating),

                              const Divider(
                                height: 40,
                                thickness: 1,
                                indent: 85,
                                endIndent: 21,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }else{
                return Container();
              }

            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
