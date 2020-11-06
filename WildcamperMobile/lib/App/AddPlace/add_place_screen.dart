import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPlaceScreen extends StatefulWidget {
  final LatLng location;

  const AddPlaceScreen({Key key, @required this.location}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddPlaceScreenState();
}

class AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a place"),
        ),
        body: Column(children: [
          Text("Name"),
          TextField(controller: _nameController),
          Text("Description"),
          Text(widget.location.toString())
        ]));
  }
}
