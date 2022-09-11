// THis simply checks whether the img is SVG or PNG and shows the relevant widget--------
//---------------------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as p;

Widget pngOrsvg(Widget svgPictureNetwork, String imgUrl) {
  {
    final extension = p.extension(imgUrl);
    if (extension == ".png" || extension == ".jpg" || extension == ".jpeg") {
      svgPictureNetwork = Container(
          constraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
          ),
          child: Image.network(
            imgUrl,
            fit: BoxFit.contain,
          ));
    } else {
      svgPictureNetwork = Container(
          constraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
          ),
          child: SvgPicture.network(
            imgUrl,
            fit: BoxFit.contain,
            placeholderBuilder: (_) => CircularProgressIndicator(),
          ));
    }
  }
  return svgPictureNetwork;
}
