import 'package:WildcamperMobile/App/Widgets/image_view.dart';
import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PlaceScreen extends StatefulWidget {
  final int placeId;

  const PlaceScreen({Key key, @required this.placeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlaceScreenState();
}

class PlaceScreenState extends State<PlaceScreen> {
  final IPlacesRepository _placesRepository =
      GetIt.instance<IPlacesRepository>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _placesRepository.getPlaceById(widget.placeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return _buildLoadedView(snapshot.data);
          else
            return CircularProgressIndicator();
        });
  }

  Widget _buildLoadedView(Place place) {
    return CustomScrollView(slivers: [
      SliverAppBar(
          title: Text(place.name),
          snap: true,
          floating: true,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(
                  itemCount: place.images?.length ?? 0,
                  controller: PageController(),
                  itemBuilder: (_, i) {
                    return GestureDetector(
                        child: Positioned.fill(
                            child: Image.memory(
                          place.images[i].bytes,
                          fit: BoxFit.fill,
                        )),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageView(
                                    images: place.images
                                        .map((img) => img.bytes)
                                        .toList(),
                                    initialIndex: i))));
                  }))),
      SliverFillRemaining(
        child: Container(
          child: Text(place.name),
          color: Colors.white,
        ),
      )
    ]);
  }
}
