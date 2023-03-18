import 'package:equatable/equatable.dart';

abstract class MovieReviewEvent extends Equatable {
  const MovieReviewEvent();
}

class MovieReviewEventStated extends MovieReviewEvent {
  final int id;

  MovieReviewEventStated(this.id);

  @override
  List<Object> get props => [];
}