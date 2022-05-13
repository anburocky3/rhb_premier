import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rhb_premier/sharedPreferences/Const.dart';

class RoundedAvatar extends StatelessWidget {
  final String? image;
  final double? height;

  const RoundedAvatar({Key? key, required this.image, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? CachedNetworkImage(
            imageUrl: Const.PROFILE_PIC + image!,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: height,
            fit: BoxFit.cover,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset('assets/userprofile.jpg'));
  }
}
