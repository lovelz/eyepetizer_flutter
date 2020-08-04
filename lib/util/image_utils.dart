

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageUtils {

  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl, {String holderImg: 'none'}) {
    if (imageUrl.isEmpty) {
      return getAssetImage(holderImg);
    }
    return CachedNetworkImageProvider(imageUrl);
  }

}