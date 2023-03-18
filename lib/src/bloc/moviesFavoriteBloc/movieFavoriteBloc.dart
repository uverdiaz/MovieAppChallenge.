

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/model/movieDetail.dart';
import 'package:untitled1/src/model/movies.dart';

import '../../service/apiServices.dart';
import 'movieFavoriteEvent.dart';
import 'movieFavoriteState.dart';


class MovieFavoritesBloc extends Bloc<MovieFavoriteEvent, MovieFavoriteState> {
  MovieFavoritesBloc() : super(MovieFavoriteLoading());

  @override
  Stream<MovieFavoriteState> mapEventToState(MovieFavoriteEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query,event.createOrDelete);
    }
  }

  Stream<MovieFavoriteState> _mapMovieEventStateToState(
      int movieId, String query, int createOrDelete) async* {
    final service = ApiService();
    yield MovieFavoriteLoading();
    try {
      List<MovieDetail> movieList = [];
      List<String> movieIdList=[];
      if (createOrDelete == 1) {
        movieIdList.add(movieId.toString());
        final MovieDetail movieDetail = await service.getMovieDetail(movieId);
        movieList.add(movieDetail);
      }
      else {
        movieIdList.remove(movieId.toString());
        final MovieDetail movieDetail = await service.getMovieDetail(movieId);
        movieList.remove(movieDetail);
      }
      yield MovieFavoriteLoaded(movieList,movieIdList);
    } on Exception catch (e) {
      print(e);
      yield MovieFavoriteError();
    }
  }
}