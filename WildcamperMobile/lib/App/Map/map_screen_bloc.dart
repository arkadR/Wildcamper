// import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreenBloc extends Bloc<MapEvent, MapState> {
//   final IPlacesRepository placesRepository;

//   MapScreenBloc({this.placesRepository}) : super(MapUninitializedState());

//   @override
//   Stream<MapState> mapEventToState(MapEvent event) async* {
//     if (event is ControllerCreatedEvent) {
//       yield MapInitializedState();
//     }
//     if (event is MapZoomedEvent) {
//       yield state.copyWith();
//     }
//     if (event is LocationChangedEvent) {}
//   }
// }

// abstract class MapState extends Equatable {
//   final int currentZoom;
//   const MapState({this.currentZoom});

//   List<Object> get props => [currentZoom];

//   MapState copyWith({currentZoom});
// }

// class MapUninitializedState extends MapState {
//   @override
//   MapState copyWith({currentZoom}) {
//     return MapUninitializedState(currentZoom: currentZoom);
//   }
// }

// class MapInitializedState extends MapState {}

// class LocationLoadedState extends MapState {}

// abstract class MapEvent {}

// class ControllerCreatedEvent extends MapEvent {}

// class MapZoomedEvent extends MapEvent {
//   int zoomLevel;
//   MapZoomedEvent({this.zoomLevel});
// }

// class LocationChangedEvent extends MapEvent {
//   LatLng location;
//   LocationChangedEvent({this.location});
// }
