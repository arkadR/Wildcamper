import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final List<Uint8List> images;
  final int initialIndex;
  const ImageView({Key key, this.images, this.initialIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageViewState();
}

class ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.images.length,
        controller: PageController(initialPage: widget.initialIndex),
        itemBuilder: (_, i) {
          return Image.memory(widget.images[i]);
        });
  }
}
