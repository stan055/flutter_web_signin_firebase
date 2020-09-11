import 'package:flutter/cupertino.dart';

class PositionedItemIndex{
  int index;
  int left;
  int bottom;
  int top;
  int right;
  Widget widget;

  PositionedItemIndex({this.index, this.left, this.bottom, this.top, this.right, this.widget});
}