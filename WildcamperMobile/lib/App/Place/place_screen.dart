import 'package:WildcamperMobile/App/Widgets/image_view.dart';
import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatefulWidget {
  final Place place;

  const PlaceScreen({Key key, @required this.place}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlaceScreenState();
}

class PlaceScreenState extends State<PlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
          title: Text(widget.place.name),
          snap: true,
          floating: true,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(
                  itemCount: widget.place.photoPathsDev?.length ?? 0,
                  controller: PageController(),
                  itemBuilder: (_, i) {
                    return GestureDetector(
                        child: Positioned.fill(
                            child: Image(
                          image: AssetImage(widget.place.photoPathsDev[i]),
                          fit: BoxFit.fill,
                        )),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageView(
                                    imagePaths: widget.place.photoPathsDev,
                                    initialIndex: i))));
                  }))),
      SliverFillRemaining(
        child: Container(
          child: Text(widget.place.name),
          color: Colors.white,
        ),
      )
    ]);
  }
}
