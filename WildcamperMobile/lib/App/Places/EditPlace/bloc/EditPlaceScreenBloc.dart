import 'dart:async';

import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../../../FormStatus.dart';

part 'EditPlaceScreenEvent.dart';
part 'EditPlaceScreenState.dart';

class EditPlaceScreenBloc
    extends Bloc<EditPlaceScreenEvent, EditPlaceScreenState> {
  EditPlaceScreenBloc(this.place) : super(EditPlaceScreenState.initial(place));

  final _picker = ImagePicker();
  final IPlacesRepository _placesRepository =
      GetIt.instance<IPlacesRepository>();

  final Place place;

  @override
  Stream<EditPlaceScreenState> mapEventToState(
    EditPlaceScreenEvent event,
  ) async* {
    if (event is TitleChanged) {
      var newState = state.copyWith(title: event.title);
      yield newState.copyWith(
          loadingStatus:
              newState.isValid ? FormStatus.valid : FormStatus.invalid);
    }
    if (event is DescriptionChanged) {
      var newState = state.copyWith(description: event.description);
      yield newState.copyWith(
          loadingStatus:
              newState.isValid ? FormStatus.valid : state.loadingStatus);
    }
    if (event is ImageRemoved) {
      if (event.imageId != null) {
        var img = state.removedImages.toList()..add(event.imageId);
        var newState = state.copyWith(removedImages: img);
        yield newState.copyWith(
            loadingStatus:
                newState.isValid ? FormStatus.valid : FormStatus.invalid);
      } else {
        var img = state.addedImagePaths.toList()..remove(event.path);
        var newState = state.copyWith(addedImagePaths: img);
        yield newState.copyWith(
            loadingStatus:
                newState.isValid ? FormStatus.valid : FormStatus.invalid);
      }
    }
    if (event is AddImageButtonClicked) {
      var imagePath = await _getImage();
      if (imagePath != null) {
        var img = state.addedImagePaths.toList()..add(imagePath);
        var newState = state.copyWith(addedImagePaths: img);
        yield newState.copyWith(
            loadingStatus:
                newState.isValid ? FormStatus.valid : FormStatus.invalid);
      }
    }
    if (event is SaveChangesButtonPressed) {
      yield state.copyWith(loadingStatus: FormStatus.loading);
      await _placesRepository.updatePlace(place.placeId, state.title,
          state.description, state.removedImages, state.addedImagePaths);
      yield state.copyWith(loadingStatus: FormStatus.done);
    }
  }

  Future<String> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }
}
