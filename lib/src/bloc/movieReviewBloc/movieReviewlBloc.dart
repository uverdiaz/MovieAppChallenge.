

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/src/model/movieReview.dart';

import '../../service/apiServices.dart';
import 'movieReviewEvent.dart';
import 'movieReviewState.dart';


class MovieReviewBloc extends Bloc<MovieReviewEvent, MovieReviewState> {
  MovieReviewBloc() : super(MovieReviewLoading());

  @override
  Stream<MovieReviewState> mapEventToState(MovieReviewEvent event) async* {
    if (event is MovieReviewEventStated) {
      yield* _mapMovieEventStartedToState(event.id);
    }
  }

  Stream<MovieReviewState> _mapMovieEventStartedToState(int id) async* {
    final apiRepository = ApiService();
    yield MovieReviewLoading();
    try {
      List<MovieReview> movieDetail = await apiRepository.getMovieReviews(id);

      yield MovieReviewLoaded(movieDetail);
    } on Exception catch (e) {
      print(e);
      yield MovieReviewError();
    }
  }
}