import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceTypeDto.dart';

class AddPlaceScreenState extends Equatable {
  final String name;
  final String description;
  final List<String> imagePaths;
  final bool isValid;
  final AddPlaceScreenFormStatus loadingStatus;
  final List<PlaceTypeDto> availablePlaceTypes;
  final PlaceTypeDto selectedPlaceType;
  AddPlaceScreenState({
    this.name,
    this.description,
    this.imagePaths,
    this.isValid,
    this.loadingStatus,
    this.availablePlaceTypes,
    this.selectedPlaceType,
  });

  factory AddPlaceScreenState.initial() {
    return AddPlaceScreenState(
        name: "",
        description: "",
        isValid: false,
        imagePaths: List(),
        loadingStatus: AddPlaceScreenFormStatus.invalid,
        availablePlaceTypes: List(),
        selectedPlaceType: null);
  }

  AddPlaceScreenState copyWith({
    String name,
    String description,
    List<String> imagePaths,
    bool isValid,
    AddPlaceScreenFormStatus loadingStatus,
    List<PlaceTypeDto> availablePlaceTypes,
    PlaceTypeDto selectedPlaceType,
  }) {
    return AddPlaceScreenState(
      name: name ?? this.name,
      description: description ?? this.description,
      imagePaths: imagePaths ?? this.imagePaths,
      isValid: isValid ?? this.isValid,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      availablePlaceTypes: availablePlaceTypes ?? this.availablePlaceTypes,
      selectedPlaceType: selectedPlaceType ?? this.selectedPlaceType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePaths': imagePaths,
      'isValid': isValid,
      'loadingStatus': loadingStatus,
      'availablePlaceTypes':
          availablePlaceTypes?.map((x) => x?.toMap())?.toList(),
      'selectedPlaceType': selectedPlaceType?.toMap(),
    };
  }

  factory AddPlaceScreenState.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AddPlaceScreenState(
      name: map['name'],
      description: map['description'],
      imagePaths: List<String>.from(map['imagePaths']),
      isValid: map['isValid'],
      loadingStatus: map['loadingStatus'],
      availablePlaceTypes: List<PlaceTypeDto>.from(
          map['availablePlaceTypes']?.map((x) => PlaceTypeDto.fromMap(x))),
      selectedPlaceType: PlaceTypeDto.fromMap(map['selectedPlaceType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPlaceScreenState.fromJson(String source) =>
      AddPlaceScreenState.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      description,
      imagePaths,
      isValid,
      loadingStatus,
      availablePlaceTypes,
      selectedPlaceType,
    ];
  }
}

enum AddPlaceScreenFormStatus { invalid, valid, loading, done }
