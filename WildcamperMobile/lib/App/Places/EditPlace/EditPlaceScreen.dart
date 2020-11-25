import 'dart:io';

import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../FormStatus.dart';
import 'bloc/EditPlaceScreenBloc.dart';

class EditPlaceScreen extends StatelessWidget {
  final Place place;
  const EditPlaceScreen({Key key, @required this.place}) : super(key: key);

  EditPlaceScreenBloc bloc(BuildContext ctx) =>
      BlocProvider.of<EditPlaceScreenBloc>(ctx);

  @override
  Widget build(BuildContext _) {
    return BlocProvider<EditPlaceScreenBloc>(
        create: (context) => EditPlaceScreenBloc(place),
        child: BlocBuilder<EditPlaceScreenBloc, EditPlaceScreenState>(
            builder: (context, state) =>
                BlocListener<EditPlaceScreenBloc, EditPlaceScreenState>(
                  listener: (context, state) {
                    if (state.loadingStatus == FormStatus.done) {
                      Navigator.pop(context);
                    }
                  },
                  child: Scaffold(
                      appBar: AppBar(
                        title: Text("Edit place"),
                        actions: <Widget>[
                          _getAppBarAction(context, state.loadingStatus)
                        ],
                      ),
                      body: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(16.0),
                          children: <Widget>[
                            TextFormField(
                                initialValue: state.title,
                                decoration: InputDecoration(
                                    labelText: 'Title',
                                    errorText: state.title.isEmpty
                                        ? "Please enter a title"
                                        : null),
                                maxLength: 50,
                                maxLengthEnforced: true,
                                onChanged: (value) =>
                                    bloc(context).add(TitleChanged(value))),
                            TextFormField(
                                initialValue: state.description,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration:
                                    InputDecoration(labelText: 'Description'),
                                maxLength: 500,
                                onChanged: (value) => bloc(context)
                                    .add(DescriptionChanged(value))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Pictures:', textScaleFactor: 1.5)),
                            SizedBox(height: 10),
                            GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [
                                  ..._getOldImageWidgets(context, state),
                                  ..._getNewImageWidgets(context, state),
                                  _getNewImagePlaceholder(context)
                                ])
                          ])),
                )));
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
          onPressed: () => BlocProvider.of<EditPlaceScreenBloc>(context)
              .add(SaveChangesButtonPressed()),
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

  List<Widget> _getOldImageWidgets(
      BuildContext context, EditPlaceScreenState state) {
    return place.images
        .where((image) => state.removedImages.contains(image.photoId) == false)
        .map(
            (image) => Stack(alignment: AlignmentDirectional.topEnd, children: [
                  Center(child: Image.memory(image.bytes)),
                  GestureDetector(
                    onTap: () =>
                        bloc(context).add(ImageRemoved(imageId: image.photoId)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.cancel),
                    ),
                  )
                ]))
        .toList();
  }

  List<Widget> _getNewImageWidgets(
      BuildContext context, EditPlaceScreenState state) {
    return state.addedImagePaths
        .map((path) => Stack(alignment: AlignmentDirectional.topEnd, children: [
              Center(child: Image.file(File(path))),
              GestureDetector(
                onTap: () => bloc(context).add(ImageRemoved(path: path)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.cancel),
                ),
              )
            ]))
        .toList();
  }

  Widget _getNewImagePlaceholder(BuildContext context) {
    return GestureDetector(
      onTap: () => bloc(context).add(AddImageButtonClicked()),
      child: Container(
        color: Colors.grey[200],
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
