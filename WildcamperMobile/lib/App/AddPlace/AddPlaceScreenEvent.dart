import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AddPlaceScreenEvent extends Equatable {
  const AddPlaceScreenEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends AddPlaceScreenEvent {
  const NameChanged({@required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends AddPlaceScreenEvent {
  const DescriptionChanged({@required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class AddImageButtonClicked extends AddPlaceScreenEvent {}

class SaveButtonClicked extends AddPlaceScreenEvent {}
