import 'package:flutter/material.dart';
import 'package:hotelino/core/utils/networkUrl.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageShower extends StatefulWidget {
  final String myimageUrl;
  const FullScreenImageShower({super.key, required this.myimageUrl});

  @override
  State<FullScreenImageShower> createState() => _FullScreenImageShowerState();
}

class _FullScreenImageShowerState extends State<FullScreenImageShower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          enableRotation: false,
          initialScale: PhotoViewComputedScale.contained * 1,
          backgroundDecoration: BoxDecoration(color: Colors.black),
          imageProvider: NetworkImage(netwrkUrl(widget.myimageUrl)),
        ),
      ),
    );
  }
}
