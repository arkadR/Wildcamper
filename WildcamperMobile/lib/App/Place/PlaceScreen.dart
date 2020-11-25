import 'package:WildcamperMobile/App/MapPreview/MapPreview.dart';
import 'package:WildcamperMobile/App/Widgets/image_view.dart';
import 'package:WildcamperMobile/Domain/model/Rating.dart';
import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:WildcamperMobile/Domain/model/user.dart';
import 'package:WildcamperMobile/Infrastructure/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

import 'AddReviewSection.dart';
import 'bloc/PlaceScreenBloc.dart';

class PlaceScreen extends StatelessWidget {
  final int placeId;
  const PlaceScreen({Key key, this.placeId}) : super(key: key);

  PlaceScreenBloc bloc(BuildContext ctx) =>
      BlocProvider.of<PlaceScreenBloc>(ctx);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlaceScreenBloc>(
        create: (context) => PlaceScreenBloc(placeId),
        child: BlocBuilder<PlaceScreenBloc, PlaceScreenState>(
            builder: (context, state) => Scaffold(
                floatingActionButton: state.place == null
                    ? null
                    : FloatingActionButton(
                        onPressed: () {
                          openMapsSheet(context, state.place);
                        },
                        child: Icon(Icons.navigation)),
                body: state.place == null
                    ? Center(child: CircularProgressIndicator())
                    : CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                            SliverAppBar(
                                title: Text(state.place.name),
                                snap: true,
                                floating: true,
                                pinned: true,
                                expandedHeight: 200,
                                flexibleSpace: FlexibleSpaceBar(
                                    background: PageView.builder(
                                        itemCount:
                                            state.place.images?.length ?? 0,
                                        controller: PageController(),
                                        itemBuilder: (_, i) {
                                          return GestureDetector(
                                              child: Positioned.fill(
                                                  child: Image.memory(
                                                state.place.images[i].bytes,
                                                fit: BoxFit.fill,
                                              )),
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageView(
                                                              images: state
                                                                  .place.images
                                                                  .map((img) =>
                                                                      img.bytes)
                                                                  .toList(),
                                                              initialIndex:
                                                                  i))));
                                        }))),
                            InfoSection(state: state),
                            MapSection(location: state.place.location),
                            state.showAddRating
                                ? AddReviewSection(
                                    place: state.place,
                                    onSubmit: () =>
                                        bloc(context).add(PlaceLoadRequested()))
                                : SliverToBoxAdapter(child: SizedBox.shrink()),
                            RatingsSection(
                                ratings: state.place.ratings,
                                userId: GetIt.instance<UserProvider>()
                                    .getCurrentUser()
                                    .uid,
                                users: state.users,
                                onRemove: (ratingId) =>
                                    bloc(context).add(ReviewRemoved(ratingId))),
                          ]))));
  }

  openMapsSheet(context, Place place) async {
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: Coords(
                            place.location.latitude, place.location.longitude),
                        title: place.name,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class InfoSection extends StatelessWidget {
  final PlaceScreenState state;

  const InfoSection({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
      ListTile(
        title: Text(state.street ?? ""),
        leading: Icon(Icons.location_on),
      ),
      ListTile(
        title: Text(state.city ?? ""),
        leading: Icon(Icons.location_city),
      ),
      ListTile(
        title: Text(state.region ?? ""),
        leading: Icon(Icons.satellite),
      ),
      ListTile(
        title: Text(state.distanceText),
        leading: Icon(Icons.directions_walk),
      ),
      Divider(),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text("Description: ", textScaleFactor: 1.5),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(state.place.description),
      )
    ]));
  }
}

class MapSection extends StatelessWidget {
  final LatLng location;

  const MapSection({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          height: 300,
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: MapPreview(location: location))),
    );
  }
}

class RatingsSection extends StatelessWidget {
  final List<Rating> ratings;
  final List<User> users;
  final String userId;
  final Function onRemove;

  const RatingsSection(
      {Key key, @required this.ratings, this.userId, this.onRemove, this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      if (index == ratings.length)
        return SizedBox(height: 200);
      else
        return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: RatingCard(
              rating: ratings[index],
              userName: users
                      ?.singleWhere((u) => u.userId == ratings[index].creatorId)
                      ?.displayedName ??
                  'fdsjhgjh',
              // ratings[index].creatorId,
              onRemove: _getOnRemoveAction(ratings[index], userId),
            ));
    }, childCount: ratings.length + 1));
  }

  Function _getOnRemoveAction(Rating rating, String userId) {
    if (rating.creatorId == userId) {
      return () => onRemove(rating.ratingId);
    } else
      return null;
  }
}

class RatingCard extends StatelessWidget {
  final Rating rating;
  final Function onRemove;
  final String userName;

  const RatingCard({Key key, this.rating, this.onRemove, this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      userName,
                      overflow: TextOverflow.ellipsis,
                    )),
                    RatingBarIndicator(
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                      rating: rating.stars.toDouble(),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    this.onRemove != null
                        ? GestureDetector(
                            onTap: this.onRemove,
                            child: Icon(Icons.cancel),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.topLeft, child: Text(rating.comment)),
              ],
            )),
      ],
    ));
  }
}
