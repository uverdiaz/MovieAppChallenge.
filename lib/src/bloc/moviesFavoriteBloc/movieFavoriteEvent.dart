import 'package:equatable/equatable.dart';

abstract class MovieFavoriteEvent extends Equatable {
  const MovieFavoriteEvent();
}

class MovieEventStarted extends MovieFavoriteEvent {
  final int movieId;
  final String query;
  final int createOrDelete;

  const MovieEventStarted(this.movieId, this.query,this.createOrDelete);

  @override
  List<Object> get props => [];
}