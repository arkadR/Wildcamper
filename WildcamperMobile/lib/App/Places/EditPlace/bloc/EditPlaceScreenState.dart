part of 'EditPlaceScreenBloc.dart';

class EditPlaceScreenState extends Equatable {
  final String title;
  final String description;
  final List<int> removedImages;
  final bool isChanged;
  final List<String> addedImagePaths;
  final List<int> initialImageIds;
  final FormStatus loadingStatus;

  EditPlaceScreenState({
    this.title,
    this.description,
    this.removedImages,
    this.isChanged,
    this.addedImagePaths,
    this.initialImageIds,
    this.loadingStatus,
  });

  factory EditPlaceScreenState.initial(Place place) {
    return EditPlaceScreenState(
        title: place.name,
        description: place.description,
        addedImagePaths: List(),
        isChanged: false,
        removedImages: List(),
        initialImageIds: place.images.map((i) => i.photoId).toList(),
        loadingStatus: FormStatus.invalid);
  }

  bool get isValid {
    return title.isNotEmpty &&
        description.isNotEmpty &&
        (initialImageIds.length -
                removedImages.length +
                addedImagePaths.length) >
            0;
  }

  EditPlaceScreenState copyWith({
    String title,
    String description,
    List<int> removedImages,
    bool isChanged,
    List<String> addedImagePaths,
    List<int> initialImageIds,
    FormStatus loadingStatus,
  }) {
    return EditPlaceScreenState(
      title: title ?? this.title,
      description: description ?? this.description,
      removedImages: removedImages ?? this.removedImages,
      isChanged: isChanged ?? this.isChanged,
      addedImagePaths: addedImagePaths ?? this.addedImagePaths,
      initialImageIds: initialImageIds ?? this.initialImageIds,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      description,
      removedImages,
      isChanged,
      addedImagePaths,
      initialImageIds,
      loadingStatus,
    ];
  }
}
