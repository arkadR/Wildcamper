import 'dart:io';

import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddPlaceScreen extends StatefulWidget {
  final LatLng location;

  const AddPlaceScreen({Key key, @required this.location}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddPlaceScreenState();
}

class AddPlaceScreenState extends State<AddPlaceScreen> {
  final _placesRepository = GetIt.instance<IPlacesRepository>();
  List<File> _uploadedImages = List();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a place"),
          actions: <Widget>[
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)))
                : FlatButton(
                    textColor: Colors.white,
                    onPressed:
                        _validateData() ? () => _saveChanges(context) : null,
                    child: Text("Save"),
                  ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) => setState(() {}),
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  controller: _descriptionController),
              Text(widget.location.toString()),
              Expanded(
                  child: GridView.count(crossAxisCount: 3, children: [
                ..._uploadedImages.map((file) => Image.file(file)).toList(),
                GestureDetector(
                  child: Icon(Icons.add_a_photo),
                  onTap: _getImage,
                )
              ]))
            ])));
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _uploadedImages.add(File(pickedFile.path));
      }
    });
  }

  bool _validateData() {
    // if (_formKey.currentState?.validate() ?? false == false) return false;
    // if (_uploadedImages.isEmpty) return false;

    return true;
  }

  Future _saveChanges(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    var name = _nameController.text;
    var description = _descriptionController.text;
    var photoPaths = _uploadedImages.map((img) => img.path);
    await _placesRepository.addPlace(
        name, description, widget.location, photoPaths);
    Navigator.pop(context);
  }
}
