import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;
  const ImageView({Key key, this.imagePaths, this.initialIndex})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageViewState();
}

class ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.imagePaths.length,
        controller: PageController(initialPage: widget.initialIndex),
        itemBuilder: (_, i) {
          return Image(image: AssetImage(widget.imagePaths[i]));
        });
  }
}
