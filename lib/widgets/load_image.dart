

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyepetizer_flutter/util/image_utils.dart';
import 'package:eyepetizer_flutter/util/text_util.dart';
import 'package:flutter/cupertino.dart';

class LoadImage extends StatelessWidget {

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;

  const LoadImage(this.image, {
    Key key,
    this.width,
    this.height,
    this.fit: BoxFit.cover,
    this.format: 'png',
    this.holderImg: 'none'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (TextUtil.isEmpty(image) || image == 'null') {

      return LoadAssetImage(holderImg, height: height, width: width, fit: fit, format: format,);
    } else {
      if (image.startsWith('http')) {
        return CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) => LoadAssetImage(holderImg, height: height, width: width, fit: fit,),
          errorWidget: (context, url, error) => LoadAssetImage(holderImg, height: height, width: width, fit: fit,),
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        return LoadAssetImage(image, height: height, width: width, fit: fit, format: format,);
      }
    }
  }

}

class LoadAssetImage extends StatelessWidget {

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final Color color;

  const LoadAssetImage(this.image, {
    Key key,
    this.width,
    this.height,
    this.fit,
    this.format: 'png',
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
      color: color,
      //忽略图片语义
      excludeFromSemantics: true,
    );
  }

}