import 'package:equatable/equatable.dart';

import '../../model/movieReview.dart';

abstract class MovieReviewState extends Equatable {
  const MovieReviewState();

  @override
  List<Object> get props => [];
}

class MovieReviewLoading extends MovieReviewState {}

class MovieReviewError extends MovieReviewState {}

class MovieReviewLoaded extends MovieReviewState {
  final List<MovieReview> review;
  const MovieReviewLoaded(this.review);

  @override
  List<Object> get props => [review];
}

