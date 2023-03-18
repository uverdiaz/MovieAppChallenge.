import 'package:equatable/equatable.dart';
import 'package:untitled1/src/model/gender.dart';

abstract class GenderState extends Equatable {
  const GenderState();

  @override
  List<Object> get props => [];
}

class GenderLoading extends GenderState {}

class GenderLoaded extends GenderState {
  final List<Gender> genreList;
  const GenderLoaded(this.genreList);

  @override
  List<Object> get props => [genreList];
}

class GenderError extends GenderState {}