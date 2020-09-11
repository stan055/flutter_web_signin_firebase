import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';

class PositionWidget {
  PrintingItem printingItem;
  double bottom;
  double left;

  PositionWidget({this.printingItem, this.bottom, this.left});

  create() {
    return Positioned(
      bottom: bottom,
      left: left,
      child: Container(
        width: printingItem.width.toDouble(),
        height: printingItem.height.toDouble(),
        color: printingItem.color,
      ),
    );
  }
}