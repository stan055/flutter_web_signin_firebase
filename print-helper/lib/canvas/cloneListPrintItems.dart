 
 import 'package:flutter_web_signin/models/printig_item.dart';

cloneListPrintItems(List<PrintingItem> original, List<PrintingItem> copies){
    copies.clear();
    original.forEach((element) {
            copies.add(new PrintingItem(
               element.name,
               element.printing,
               element.factor,
               element.height,
               element.iheight,
               element.width,
               element.iwidth,
               element.grammar,
               element.index,
               element.color.value,
               count: element.count
             ));
             });
}
 
           