import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppCircleAvatar extends StatelessWidget {
  final String photo;
  double? height;
  double? width;
  Color? color;
  AppCircleAvatar(
      {super.key,
      required this.photo,
      this.height,
      this.width,
      this.color = Colors.amber});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: CachedNetworkImage(
        imageUrl: photo,
        height: height,
        width: width,
        placeholder: (context, url) => SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: color,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
