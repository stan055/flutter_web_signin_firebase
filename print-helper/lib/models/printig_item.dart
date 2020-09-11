import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/utilities/constants.dart';


class PrintingItem {
  String name;
  int printing, factor;
  int height, iheight;
  int width, iwidth;
  int grammar;
  Color color;
  int index;
  int count = 0;
  int area;
  bool last;

  double ratioWeight;
  double variableWeight;
    

  PrintingItem(String name, int printing, int factor, int height, int iheight, 
                  int width, int iwidth, int grammar, int index, int color, {this.count}) {

    
    this.name = name;
    this.printing = printing;
    this.factor = factor;
    this.height = height;
    this.iheight = iheight;
    this.width = width;
    this.iwidth = iwidth;
    this.grammar = grammar;
    this.index = index;
    this.color = Color(color);

    area = (height + iheight*2 + STROKE*2) * (width + iwidth*2 + STROKE*2);
    ratioWeight = 0;
  }

 Map toMap(){
   var map = {
     'name': name,
     'printing': printing,
     'factor': factor,
     'height': height,
     'iheight': iheight,
     'width': width,
     'iwidth': iwidth,
     'grammar': grammar,
     'index': index,
     'color': color.value
   };

   return map;
  }

  Widget  getText() {
    Widget result = Text(
                         '#' + this.index.toString()  +
                          '[' + this.factor.toString() + '] ' +
                          this.name +
                          ' / ' +
                          this.printing.toString() +  'шт / ' +
                         'В.' +  this.height.toString() +
                        ' x Ш.' +  this.width.toString() +
                         ' / ' +   this.grammar.toString() + 'г/м2' 
                        + ' / ' + ' ::'  + this.ratioWeight.  toStringAsFixed(1),
                         style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black87),
                       );
    return result;
  }
}
