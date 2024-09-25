import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';



Future<Size> getImageSize(ImageProvider imageProvider) async {
  final Completer<Size> completer = Completer();
  final ImageStream imageStream = imageProvider.resolve(const ImageConfiguration());
  final listener = ImageStreamListener((ImageInfo info, bool _) {
    final myImage = info.image;
    completer.complete(Size(myImage.width.toDouble(), myImage.height.toDouble()));
  });
  imageStream.addListener(listener);
  return completer.future;
}
