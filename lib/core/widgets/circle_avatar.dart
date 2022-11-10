import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  final String photo;
  const AppCircleAvatar(
      {super.key,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: CachedNetworkImage(
        imageUrl: photo,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
