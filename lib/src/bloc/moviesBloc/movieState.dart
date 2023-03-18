import 'package:equatable/equatable.dart' show Equatable;
import '../../model/movies.dart';


abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movies> movieList;
  const MovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieError extends MovieState {}