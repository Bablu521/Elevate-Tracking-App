import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  const CustomCachedNetworkImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imageUrl!,
            color: color,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : const Icon(Icons.error);
  }
}
