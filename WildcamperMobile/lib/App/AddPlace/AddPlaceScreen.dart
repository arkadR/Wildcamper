import 'dart:io';

import 'package:WildcamperMobile/App/AddPlace/AddPlaceScreenBloc.dart';
import 'package:WildcamperMobile/App/AddPlace/AddPlaceScreenEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
              if (state.loadingStatus == AddPlaceScreenFormStatus.done) {
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
                    body: Column(children: [
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Name',
                              errorText: state.name.isEmpty
                                  ? "Please enter a name"
                                  : null),
                          onChanged: (value) =>
                              bloc(context).add(NameChanged(name: value))),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Description'),
                          onChanged: (value) => bloc(context)
                              .add(DescriptionChanged(description: value))),
                      Text(location.toString()),
                      Expanded(
                          child: GridView.count(crossAxisCount: 3, children: [
                        ...state.imagePaths
                            .map((path) => Image.file(File(path)))
                            .toList(),
                        GestureDetector(
                          child: Icon(Icons.add_a_photo),
                          onTap: () =>
                              bloc(context).add(AddImageButtonClicked()),
                        )
                      ]))
                    ])))));
  }

  Widget _getAppBarAction(
      BuildContext context, AddPlaceScreenFormStatus status) {
    switch (status) {
      case AddPlaceScreenFormStatus.invalid:
        return FlatButton(
          textColor: Colors.white,
          onPressed: null,
          child: Text("Save"),
        );
        break;

      case AddPlaceScreenFormStatus.valid:
        return FlatButton(
          textColor: Colors.white,
          onPressed: () => BlocProvider.of<AddPlaceScreenBloc>(context)
              .add(SaveButtonClicked()),
          child: Text("Save"),
        );
        break;
      case AddPlaceScreenFormStatus.loading:
      case AddPlaceScreenFormStatus.done:
        return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        break;
    }
    throw Exception("Invalid form status");
  }
}
