import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddPlaceScreenState extends Equatable {
  final String name;
  final String description;
  final List<String> imagePaths;
  final bool isValid;
  final AddPlaceScreenFormStatus loadingStatus;

  factory AddPlaceScreenState.initial() => AddPlaceScreenState(
      name: "",
      description: "",
      isValid: false,
      imagePaths: List(),
      loadingStatus: AddPlaceScreenFormStatus.invalid);

  AddPlaceScreenState({
    this.name,
    this.description,
    this.imagePaths,
    this.isValid,
    this.loadingStatus,
  });

  AddPlaceScreenState copyWith({
    String name,
    String description,
    List<String> imagePaths,
    bool isValid,
    AddPlaceScreenFormStatus loadingStatus,
  }) {
    return AddPlaceScreenState(
      name: name ?? this.name,
      description: description ?? this.description,
      imagePaths: imagePaths ?? this.imagePaths,
      isValid: isValid ?? this.isValid,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePaths': imagePaths,
      'isValid': isValid,
      'loadingStatus': loadingStatus,
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
    ];
  }
}

enum AddPlaceScreenFormStatus { invalid, valid, loading, done }
