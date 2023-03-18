import 'package:equatable/equatable.dart';

abstract class GenderEvent extends Equatable {
  const GenderEvent();
}

class GenderEventStarted extends GenderEvent {
  const GenderEventStarted();

  @override
  List<Object> get props => [];
}