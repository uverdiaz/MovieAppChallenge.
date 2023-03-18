import 'package:equatable/equatable.dart' show Equatable;
import '../../model/movieDetail.dart';


abstract class MovieFavoriteState extends Equatable {
  const MovieFavoriteState();

  @override
  List<Object> get props => [];
}

class MovieFavoriteLoading extends MovieFavoriteState {}

class MovieFavoriteLoaded extends MovieFavoriteState {
  final List<MovieDetail> movieList;
  final List<String> movieId;

  const MovieFavoriteLoaded(this.movieList,this.movieId);
  @override
  List<Object> get props => [movieList,movieId];
}

class MovieFavoriteError extends MovieFavoriteState {}