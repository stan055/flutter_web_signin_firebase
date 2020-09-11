//Переворот одной фигуры
import 'package:flutter_web_signin/models/printig_item.dart';

flipItem(PrintingItem printingItem){
      int height = printingItem.height;
      printingItem.height = printingItem.width;
      printingItem.width = height;
}