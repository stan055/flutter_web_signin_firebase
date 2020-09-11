import 'package:flutter/material.dart';
import 'package:flutter_web_signin/canvas/positionedItem.dart';

List<Widget> getListWidgetPositioned(List<PositionedItemIndex> listPositionedIndex){
  List<Widget> resultList = new List<Widget>();
  listPositionedIndex.forEach((element) { 
    resultList.add(element.widget);
  });
  return resultList;
}