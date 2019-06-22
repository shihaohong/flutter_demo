import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/cached_image.dart';

class CircularImage extends StatelessWidget {

  final double width;
  final double height;
  final double circular;
  final String imageURL;

  const CircularImage({
    this.width = 40, 
    this.height = 40, 
    this.circular = 20,
    @required this.imageURL
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(circular),
        child: CachedImage(imageUrl: imageURL),
      ),
    );
  }
}