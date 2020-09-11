
import 'package:flutter/material.dart';

class ColorScale{
  List <Widget> colorScale;

 List <Widget> createScale(double width){
    colorScale = new List<Widget>();

     int count = width ~/ 56;
     
     for(int i=1, j=0; i<count; i++, j++){
       switch(j) {
         case 0:  colorScale.add(Container(height: 23, width: 56, color: Colors.blue,)); break;
         case 1:  colorScale.add(Container(height: 23, width: 56, color: Colors.pink,),); break;
         case 2:  colorScale.add(Container(height: 23, width: 56, color: Colors.yellow[500],)); break;
         case 3:  colorScale.add(Container(height: 23, width: 56, color: Colors.black,)); j=-1; break;
       }
     }
     return colorScale;
  }

}
