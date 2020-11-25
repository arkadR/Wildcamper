part of 'EditPlaceScreenBloc.dart';

abstract class EditPlaceScreenEvent extends Equatable {
  const EditPlaceScreenEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends EditPlaceScreenEvent {
  final String title;

  TitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends EditPlaceScreenEvent {
  final String description;

  DescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class ImageRemoved extends EditPlaceScreenEvent {
  final int imageId;
  final String path;

  ImageRemoved({this.imageId, this.path});

  @override
  List<Object> get props => [imageId, path];
}

class AddImageButtonClicked extends EditPlaceScreenEvent {}

class SaveChangesButtonPressed extends EditPlaceScreenEvent {}
