import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'AddPlaceScreenEvent.dart';
import 'AddPlaceScreenState.dart';

class AddPlaceScreenBloc
    extends Bloc<AddPlaceScreenEvent, AddPlaceScreenState> {
  AddPlaceScreenBloc({@required this.location})
      : super(AddPlaceScreenState.initial());

  final IPlacesRepository _placesRepository =
      GetIt.instance<IPlacesRepository>();
  final _picker = ImagePicker();

  final LatLng location;

  @override
  Stream<AddPlaceScreenState> mapEventToState(
      AddPlaceScreenEvent event) async* {
    if (event is NameChanged) {
      var isValid = _validate(event.name, state.imagePaths);
      yield state.copyWith(name: event.name, isValid: isValid);
    }
    if (event is DescriptionChanged) {
      yield state.copyWith(description: event.description);
    }
    if (event is SaveButtonClicked) {
      final isValid = _validate(state.name, state.imagePaths);
      if (isValid == false)
        throw Exception("Form was submitted in a bad state");

      yield state.copyWith(loadingStatus: AddPlaceScreenFormStatus.loading);

      await _placesRepository.addPlace(
          state.name, state.description, location, state.imagePaths);
      yield state.copyWith(loadingStatus: AddPlaceScreenFormStatus.done);
      // Navigator.pop(context);
    }
    if (event is AddImageButtonClicked) {
      var imagePath = await _getImage();
      if (imagePath != null) {
        var imagePaths = [...state.imagePaths, imagePath];
        var isValid = _validate(state.name, imagePaths);
        yield state.copyWith(
            imagePaths: imagePaths,
            loadingStatus:
                isValid ? AddPlaceScreenFormStatus.valid : state.loadingStatus);
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
