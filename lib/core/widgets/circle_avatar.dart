import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  final String photo;
  double? height;
  double? width;
  AppCircleAvatar({super.key, required this.photo, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: CachedNetworkImage(
        imageUrl: photo,
        height: height,
        width: width,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
