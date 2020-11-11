import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'MapPreviewEvent.dart';
part 'MapPreviewState.dart';

class MapPreviewBloc extends Bloc<MapPreviewEvent, MapPreviewState> {
  MapPreviewBloc() : super(MapPreviewState.initial());

  @override
  Stream<MapPreviewState> mapEventToState(
    MapPreviewEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
