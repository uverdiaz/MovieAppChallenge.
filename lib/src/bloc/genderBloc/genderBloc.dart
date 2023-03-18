import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/gender.dart';
import '../../service/apiServices.dart';
import 'genderEvent.dart';
import 'genderState.dart';


class GenderBloc extends Bloc<GenderEvent, GenderState> {
  GenderBloc() : super(GenderLoading());

  @override
  Stream<GenderState> mapEventToState(GenderEvent event) async* {
    if (event is GenderEventStarted) {
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<GenderState> _mapMovieEventStateToState() async* {
    final service = ApiService();
    yield GenderLoading();
    try {
      List<Gender> genreList = await service.getGenderList();

      yield GenderLoaded(genreList);
    } on Exception catch (e) {
      print(e);
      yield GenderError();
    }
  }
}