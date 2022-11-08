import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  final String photo;
  final double maxRadius;
  final double minRadius;
  const AppCircleAvatar(
      {super.key,
      required this.maxRadius,
      required this.minRadius,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: maxRadius,
      backgroundColor: const Color(0xffFDCF09),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(minRadius),
        child: CachedNetworkImage(
          imageUrl: photo,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
