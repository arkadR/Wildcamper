import 'dart:io';

import 'package:WildcamperMobile/App/AddPlace/AddPlaceScreenBloc.dart';
import 'package:WildcamperMobile/App/AddPlace/AddPlaceScreenEvent.dart';
import 'package:WildcamperMobile/App/MapPreview/MapPreview.dart';
import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceTypeDto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../FormStatus.dart';
import 'AddPlaceScreenState.dart';

class AddPlaceScreen extends StatelessWidget {
  final LatLng location;

  const AddPlaceScreen({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    AddPlaceScreenBloc bloc(BuildContext ctx) =>
        BlocProvider.of<AddPlaceScreenBloc>(ctx);

    return BlocProvider<AddPlaceScreenBloc>(
        create: (context) => AddPlaceScreenBloc(location: location),
        child: BlocListener<AddPlaceScreenBloc, AddPlaceScreenState>(
            listener: (context, state) {
              if (state.loadingStatus == FormStatus.done) {
                Navigator.pop(context);
              }
            },
            child: BlocBuilder<AddPlaceScreenBloc, AddPlaceScreenState>(
                builder: (context, state) => Scaffold(
                    appBar: AppBar(
                      title: Text("Add a place"),
                      actions: <Widget>[
                        _getAppBarAction(context, state.loadingStatus)
                      ],
                    ),
                    body: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16.0),
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                "Type: ",
                                textScaleFactor: 1.2,
                              ),
                              state.availablePlaceTypes.isNotEmpty
                                  ? DropdownButton<PlaceTypeDto>(
                                      value: state.selectedPlaceType,
                                      items: state.availablePlaceTypes
                                          .map((type) =>
                                              DropdownMenuItem<PlaceTypeDto>(
                                                  value: type,
                                                  child: Text(type.name)))
                                          .toList(),
                                      onChanged: (value) => bloc(context)
                                          .add(PlaceTypeChanged(value)))
                                  : SizedBox(),
                            ],
                          ),
                          TextField(
                              decoration: InputDecoration(
                                  labelText: 'Title',
                                  errorText: state.name.isEmpty
                                      ? "Please enter a title"
                                      : null),
                              maxLength: 50,
                              maxLengthEnforced: true,
                              onChanged: (value) =>
                                  bloc(context).add(NameChanged(name: value))),
                          TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                              maxLength: 500,
                              onChanged: (value) => bloc(context)
                                  .add(DescriptionChanged(description: value))),
                          Container(
                              height: 200,
                              child: MapPreview(location: location)),
                          SizedBox(height: 30),
                          Align(
                              alignment: Alignment.topLeft,
                              child:
                                  Text('Add pictures:', textScaleFactor: 1.5)),
                          SizedBox(height: 10),
                          GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: [
                                ...state.imagePaths
                                    .map((path) => Container(
                                        color: Colors.grey[200],
                                        child: Image.file(File(path))))
                                    .toList(),
                                GestureDetector(
                                  onTap: () => bloc(context)
                                      .add(AddImageButtonClicked()),
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Icon(Icons.add_a_photo),
                                  ),
                                )
                              ])
                        ])))));
  }

  Widget _getAppBarAction(BuildContext context, FormStatus status) {
    switch (status) {
      case FormStatus.invalid:
        return FlatButton(
          textColor: Colors.white,
          onPressed: null,
          child: Text("Save"),
        );
        break;

      case FormStatus.valid:
        return FlatButton(
          textColor: Colors.white,
          onPressed: () => BlocProvider.of<AddPlaceScreenBloc>(context)
              .add(SaveButtonClicked()),
          child: Text("Save"),
        );
        break;
      case FormStatus.loading:
      case FormStatus.done:
        return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        break;
    }
    throw Exception("Invalid form status");
  }
}
