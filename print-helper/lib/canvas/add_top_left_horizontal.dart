import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/canvas/positionedItem.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:flutter_web_signin/utilities/flip_item.dart';

//Добавление виджета согласно его весу с верху с лева на лево по горизонтали
addWidgetToListWithWeightTopLeftHorizontal(int incrementWidth, int incrementHeight, int startWidth, int startHeight, double canvasHeight, double canvasWidth, PrintingItem printingItem,
                                                     Map<double, List<bool>> canvas, List<PositionedItemIndex> listPositioned, bool vertical, bool flip){

  Map<String, int> topLeftResponse = new Map<String, int>();

  if(vertical){

    for (int iwidth = startWidth; iwidth < canvasWidth; iwidth = iwidth + incrementWidth) {

      for (int iheight = startHeight; iheight >= 0; iheight--) {
        
            if (!canvas[iwidth][iheight]) {

                    int _maxHeight = iheight - printingItem.height - (printingItem.iheight*2) - (STROKE*2) ;
                    int _maxWidth = iwidth + printingItem.width + (printingItem.iwidth*2) + (STROKE*2);
                    if(_maxHeight >= 0 && _maxWidth <= canvasWidth){

                        if(!canvas[_maxWidth-1][_maxHeight+1]){

                //Проверяем есть ли свободное место
                if(placeCheck(_maxHeight, _maxWidth, iwidth, iheight, canvas))
                 {
                //Добавляем виджет в listPositioned
                _addWidgetToList(iwidth, iheight, canvasWidth, canvasHeight, printingItem, listPositioned);

                //Счетчик количества на листе
                printingItem.count++;
                // Заполнение canvas холста фигурой
                _fillingCanvas(iwidth, iheight, printingItem, canvas);
                
                topLeftResponse['incrementWidth'] = printingItem.width + (printingItem.iwidth*2) + (STROKE*2);
                topLeftResponse['incrementHeight'] = 1;
                topLeftResponse['success'] = 0;
                topLeftResponse['startWidth'] = iwidth;
                topLeftResponse['startHeight'] = iheight;
                return topLeftResponse;
              }
            }
            }  
        }
      }
      startHeight = (canvasHeight ~/1 - 1);
    }
   if(flip){
     flipItem(printingItem);
     topLeftResponse = addWidgetToListWithWeightTopLeftHorizontal(1, 1, 0, (canvasHeight ~/1 - 1), canvasHeight, canvasWidth, printingItem, 
                                              canvas, listPositioned, vertical, false);
     return topLeftResponse;
   } else {
       topLeftResponse['incrementWidth'] = 1;
       topLeftResponse['incrementHeight'] = 1;     
       topLeftResponse['success'] = 1;
       topLeftResponse['startWidth'] = 0;
       topLeftResponse['startHeight'] = (canvasHeight ~/1 - 1);
       return topLeftResponse;
   }

  } else {
       for (int iheight = startHeight; iheight >= 0; iheight = iheight - incrementHeight) {
    
        for (int iwidth = 0; iwidth < canvasWidth; iwidth++) {
        
            if (!canvas[iwidth][iheight]) {

                    int _maxHeight = iheight - printingItem.height - (printingItem.iheight*2) - (STROKE*2) ;
                    int _maxWidth = iwidth + printingItem.width + (printingItem.iwidth*2) + (STROKE*2);
                    if(_maxHeight >= 0 && _maxWidth <= canvasWidth){

                        if(!canvas[_maxWidth-1][_maxHeight+1]){

                //Проверяем есть ли свободное место
                if(placeCheck(_maxHeight, _maxWidth, iwidth, iheight, canvas))
                 {
                //Добавляем виджет в listPositioned
                _addWidgetToList(iwidth, iheight, canvasWidth, canvasHeight, printingItem, listPositioned);

                //Счетчик количества на листе
                printingItem.count++;
                // Заполнение canvas холста фигурой
                _fillingCanvas(iwidth, iheight, printingItem, canvas);
                
                topLeftResponse['incrementWidth'] = 1;
                topLeftResponse['incrementHeight'] = printingItem.height + (printingItem.iheight*2) + (STROKE*2);
                topLeftResponse['success'] = 0;
                topLeftResponse['startWidth'] = iwidth;
                topLeftResponse['startHeight'] = iheight;
                return topLeftResponse;
              }
            }
            }  
        }
      }
      startWidth = 0;
    }
   if(flip){
     flipItem(printingItem);
     topLeftResponse = addWidgetToListWithWeightTopLeftHorizontal(1, 1, 0, (canvasHeight ~/1 - 1), canvasHeight, canvasWidth, printingItem, 
                                              canvas, listPositioned, vertical, false);
     return topLeftResponse;
   } else {
       topLeftResponse['incrementWidth'] = 1;
       topLeftResponse['incrementHeight'] = 1;     
       topLeftResponse['success'] = 1;
       topLeftResponse['startWidth'] = 0;
       topLeftResponse['startHeight'] = (canvasHeight ~/1 - 1);
       return topLeftResponse;
   }
   
  }


}

  //Проверка на свободное место с лево на право по горизонтали c верху
bool  placeCheck(int _maxHeight, int _maxWidth, int x, int y, Map<double, List<bool>> canvas){
        bool stepHeightBool = true;
        bool stepWidthBool = true; //Переменные для настройки шага
        int stepHeight = 1;   //Переменные для настройки шага
        int stepWidth = 1;   //Переменные для настройки шага

        for(int height = y; height > _maxHeight; height = height - stepHeight){

             //Настройка шага высоты
            if(stepHeightBool){
              double hMod = (height - (_maxHeight+1)) % STEP;
              if(hMod == 0.0){
                stepHeight = STEP~/1;
                stepHeightBool = false;
              }
            }

          for(int width = x; width < _maxWidth; width = width + stepWidth){ VARIABLE_COUNT1++;

            //Настройка шага ширины
            if(stepWidthBool){
              double hMod = (_maxWidth-1 - width) % STEP;
              if(hMod == 0.0){
                stepWidth = STEP~/1;
                stepWidthBool = false;
              }
            }

            if(canvas[width][height]){
              return false;
            }
          }
        }
      
      return true;
  }


//Добавляем виджет в List с лево на право с верху по горизонтали
_addWidgetToList(int x, int y, double canvasWidth, double canvasHeight, PrintingItem printingItem, List<PositionedItemIndex> listPositioned){
              listPositioned.add(PositionedItemIndex(
                index: printingItem.index,
                bottom: (y - STROKE - printingItem.iheight) ~/1 - printingItem.height,
                left: (x + STROKE + printingItem.iwidth ),
                right: (x + STROKE + printingItem.iwidth ) + printingItem.width,
                top: (y - STROKE - printingItem.iheight) ~/1,
                
                widget: Positioned(
                  top:  canvasHeight - 1 - (y - STROKE - printingItem.iheight),
                  left: (x + STROKE + printingItem.iwidth ).toDouble(),
                  child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(0),
                        padding: EdgeInsets.all(0),                    
                                      child: Container(
                      width:  printingItem.width.toDouble(),
                      height: printingItem.height.toDouble(),
                      color: printingItem.color,
                      child: Text((printingItem.index).toString() + '[' + printingItem.factor.toString() + ']',
                       textAlign: TextAlign.center, 
                      style: tStylePositionItem
                      ),
                    ),
                  ),
              )
              ));
  
}


//Заполнение canvas фигурой лево на право c верху по горизонтали
_fillingCanvas(int x, int y, PrintingItem printingItem, Map<double, List<bool>> canvas ){
    int maxHeight = y - printingItem.height - (printingItem.iheight*2) - (STROKE*2);
    int maxWidth = x + printingItem.width + (printingItem.iwidth*2) + (STROKE*2);

        for(int iHeight = y; iHeight > maxHeight; iHeight--){
          for(int iWidth = x; iWidth < maxWidth; iWidth++){
            canvas[iWidth][iHeight] = true;
          }
        }
  }

