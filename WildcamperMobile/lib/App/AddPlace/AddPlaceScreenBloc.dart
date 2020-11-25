import 'package:WildcamperMobile/Domain/repositories/IPlaceTypeRepository.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../FormStatus.dart';
import 'AddPlaceScreenEvent.dart';
import 'AddPlaceScreenState.dart';

import '../../Infrastructure/Extensions/StringExtensions.dart';

class AddPlaceScreenBloc
    extends Bloc<AddPlaceScreenEvent, AddPlaceScreenState> {
  AddPlaceScreenBloc({@required this.location})
      : super(AddPlaceScreenState.initial()) {
    _placeTypesRepository
        .getPlaceTypes()
        .then((types) => add(PlaceTypesLoaded(types)));
  }

  final IPlacesRepository _placesRepository =
      GetIt.instance<IPlacesRepository>();

  final IPlaceTypeRepository _placeTypesRepository =
      GetIt.instance<IPlaceTypeRepository>();
  final _picker = ImagePicker();

  final LatLng location;

  @override
  Stream<AddPlaceScreenState> mapEventToState(
      AddPlaceScreenEvent event) async* {
    if (event is PlaceTypesLoaded) {
      yield state.copyWith(
          availablePlaceTypes: event.placeTypes,
          selectedPlaceType: event.placeTypes.first);
    }
    if (event is NameChanged) {
      var name = event.name.truncateTo(50);
      var isValid = _validate(name, state.imagePaths);
      yield state.copyWith(name: name, isValid: isValid);
    }
    if (event is DescriptionChanged) {
      var description = event.description.truncateTo(500);
      yield state.copyWith(description: description);
    }
    if (event is PlaceTypeChanged) {
      yield state.copyWith(selectedPlaceType: event.placeType);
    }
    if (event is SaveButtonClicked) {
      final isValid = _validate(state.name, state.imagePaths);
      if (isValid == false)
        throw Exception("Form was submitted in a bad state");

      yield state.copyWith(loadingStatus: FormStatus.loading);

      await _placesRepository.addPlace(state.name, state.description, location,
          state.imagePaths, state.selectedPlaceType.placeTypeId);
      yield state.copyWith(loadingStatus: FormStatus.done);
      // Navigator.pop(context);
    }
    if (event is AddImageButtonClicked) {
      var imagePath = await _getImage();
      if (imagePath != null) {
        var imagePaths = [...state.imagePaths, imagePath];
        var isValid = _validate(state.name, imagePaths);
        yield state.copyWith(
            imagePaths: imagePaths,
            loadingStatus: isValid ? FormStatus.valid : state.loadingStatus);
      }
    }
  }

  bool _validate(String name, List<String> imagePaths) {
    return name.isNotEmpty && imagePaths.isNotEmpty;
  }

  Future<String> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }
}
