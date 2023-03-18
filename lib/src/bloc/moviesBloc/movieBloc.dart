

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/model/movies.dart';

import '../../service/apiServices.dart';
import 'movieEvent.dart';
import 'movieState.dart';


class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final service = ApiService();
    yield MovieLoading();
    try {
      List<Movies> movieList = [];
      if (movieId == 0) {
        movieList = await service.getNowPlayingMovie();
      }
      else {
        movieList = await service.getMovieByGender(movieId);
      }
      yield MovieLoaded(movieList);
    } on Exception catch (e) {
      print(e);
      yield MovieError();
    }
  }
}