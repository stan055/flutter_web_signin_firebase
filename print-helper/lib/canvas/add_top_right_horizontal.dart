import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/canvas/positionedItem.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:flutter_web_signin/utilities/flip_item.dart';

//Добавление виджета согласно его весу с верху с права на лево по горизонтали
addWidgetToListWithWeightTopRightHorizontal(int incrementWidth, int incrementHeight, int startWidth, int startHeight, double canvasHeight, double canvasWidth, PrintingItem printingItem, PrintingItem printingItemOrigin,
                                                          Map<double, List<bool>> canvas, List<PositionedItemIndex> listPositioned, bool vertical, bool flip){

  Map<String, int> topRightResponse = new Map<String, int>();

  if(vertical){

    for (int iwidth = startWidth; iwidth >= 0; iwidth = iwidth - incrementWidth) {

      for (int iheight = startHeight; iheight >= 0; iheight--) {
        
            if (!canvas[iwidth][iheight]) {

                    int _maxHeight = iheight - printingItem.height - (printingItem.iheight*2) - (STROKE*2) ;
                    int _maxWidth = iwidth - printingItem.width - (printingItem.iwidth*2) - (STROKE*2);
                    if(_maxHeight >= 0 && _maxWidth >= 0){

                        if(!canvas[_maxWidth+1][_maxHeight+1]){

                //Проверяем есть ли свободное место
                if(placeCheck(_maxHeight, _maxWidth, iwidth, iheight, canvas))
                 {
                //Добавляем виджет в listPositioned
                _addWidgetToList(iwidth, iheight, canvasWidth, canvasHeight, printingItem, listPositioned);

                //Счетчик количества на листе
                printingItemOrigin.count++;
                

                // Заполнение canvas холста фигурой
                _fillingCanvas(iwidth, iheight, printingItem, canvas);
                
                topRightResponse['incrementWidth'] = printingItem.width + (printingItem.iwidth*2) + (STROKE*2);
                topRightResponse['incrementHeight'] = 1;
                topRightResponse['success'] = 0;
                topRightResponse['startWidth'] = iwidth;
                topRightResponse['startHeight'] = iheight;
                return topRightResponse;
              }
            }
            }  
          }
        }
        startHeight = (canvasHeight ~/1 - 1);
      }
    if(flip){
     flipItem(printingItem);
     topRightResponse = addWidgetToListWithWeightTopRightHorizontal(1, 1, (canvasWidth ~/1 - 1), (canvasHeight ~/1 - 1), canvasHeight, canvasWidth, printingItem, printingItemOrigin,
                                              canvas, listPositioned, vertical, false);
     return topRightResponse;
   } else {
       topRightResponse['incrementWidth'] = 1;
       topRightResponse['incrementHeight'] = 1;
       topRightResponse['success'] = 1;
       topRightResponse['startWidth'] = (canvasWidth ~/1 - 1);
       topRightResponse['startHeight'] = (canvasHeight ~/1 - 1);
       return topRightResponse;
   }

  } else {
      
      for (int iheight = startHeight; iheight >= 0; iheight = iheight - incrementHeight) {
    
        for (int iwidth = startWidth; iwidth >= 0; iwidth--) {
        
            if (!canvas[iwidth][iheight]) {

                    int _maxHeight = iheight - printingItem.height - (printingItem.iheight*2) - (STROKE*2) + 1;
                    int _maxWidth = iwidth - printingItem.width - (printingItem.iwidth*2) - (STROKE*2) + 1;
                    if(_maxHeight >= 0 && _maxWidth >= 0){

                        if(!canvas[_maxWidth][_maxHeight]){

                //Проверяем есть ли свободное место
                if(placeCheck(_maxHeight, _maxWidth, iwidth, iheight, canvas))
                 {
                //Добавляем виджет в listPositioned
                _addWidgetToList(iwidth, iheight, canvasWidth, canvasHeight, printingItem, listPositioned);

                //Счетчик количества на листе
                printingItemOrigin.count++;
                

                // Заполнение canvas холста фигурой
                _fillingCanvas(iwidth, iheight, printingItem, canvas);
                

                if(printingItem.last == true){
                  cuttingLine(iheight, printingItem, canvas, listPositioned);
                }

                topRightResponse['incrementWidth'] = 1;
                topRightResponse['incrementHeight'] = printingItem.height + (printingItem.iheight*2) + (STROKE*2);
                topRightResponse['success'] = 0;
                topRightResponse['startWidth'] = iwidth;
                topRightResponse['startHeight'] = iheight;
                return topRightResponse;
              }
            }
            }  
        }
      }
      startWidth = (canvasWidth ~/1 - 1);
    }
    if(flip){
     flipItem(printingItem);
     topRightResponse = addWidgetToListWithWeightTopRightHorizontal(1, 1, (canvasWidth ~/1 - 1), (canvasHeight ~/1 - 1), canvasHeight, canvasWidth, printingItem, printingItemOrigin,
                                              canvas, listPositioned, vertical, false);
     return topRightResponse;
   } else {
       topRightResponse['incrementWidth'] = 1;
       topRightResponse['incrementHeight'] = 1;     
       topRightResponse['success'] = 1;
       topRightResponse['startWidth'] = (canvasWidth ~/1 - 1);
       topRightResponse['startHeight'] = (canvasHeight ~/1 - 1);
       return topRightResponse;
   }
  }


}

  //Проверка на свободное место с права на лево по горизонтали c верху
bool  placeCheck(int _maxHeight, int _maxWidth, int x, int y, Map<double, List<bool>> canvas){
        bool stepHeightBool = STEP_SWICH;
        bool stepWidthBool = STEP_SWICH; //Переменные для настройки шага
        int stepHeight = 1;   //Переменные для настройки шага
        int stepWidth = 1;   //Переменные для настройки шага

        for(int height = y; height >= _maxHeight; height = height - stepHeight){

            //Настройка шага высоты
            if(stepHeightBool){
              double hMod = (height - (_maxHeight+1)) % STEP;
              if(hMod == 0.0){
                stepHeight = STEP~/1;
                stepHeightBool = false;
              }
            }

          for(int width = x; width >= _maxWidth; width = width - stepWidth){ 


            //Настройка шага ширины
            if(stepWidthBool){
              double hMod = (width - (_maxWidth +1)) % STEP;
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


//Добавляем виджет в List с права на лево с верху по горизонтали
_addWidgetToList(int x, int y, double canvasWidth, double canvasHeight, PrintingItem printingItem, List<PositionedItemIndex> listPositioned){
              listPositioned.add(PositionedItemIndex(
                index: printingItem.index,
                bottom: (y - STROKE - printingItem.iheight) ~/1 - printingItem.height,
                left: (x - STROKE - printingItem.iwidth ) ~/1 - printingItem.width +1,
                right: (x - STROKE - printingItem.iwidth ) ~/1,
                top:  (y - STROKE - printingItem.iheight) ~/1,
                
                widget: Positioned(
                  top:  canvasHeight - (y - STROKE - printingItem.iheight),
                  right: canvasWidth - (x - STROKE - printingItem.iwidth ),
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


//Заполнение canvas фигурой права на лево c верху по горизонтали
_fillingCanvas(int x, int y, PrintingItem printingItem, Map<double, List<bool>> canvas ){
    int maxHeight = y - printingItem.height - (printingItem.iheight*2) - (STROKE*2);
    int maxWidth = x - printingItem.width - (printingItem.iwidth*2) - (STROKE*2);

        for(int iHeight = y; iHeight > maxHeight; iHeight--){
          for(int iWidth = x; iWidth > maxWidth; iWidth--){
            canvas[iWidth][iHeight] = true;
          }
        }
  }


void cuttingLine(int y,PrintingItem printingItem, Map<double, List<bool>> canvas, List<PositionedItemIndex> listPositioned){
        int maxHeight = (y - (STROKE*2) - (printingItem.iheight*2)) - printingItem.height;

            listPositioned.add(
              PositionedItemIndex(
                index: 0,
                widget: Positioned(
                  bottom:  maxHeight .toDouble(),
                  left: 0,
                  right: 0,
                  child: Container(
                  color: Colors.red[700],
                  height: 1.0,
                      ),
              )
              )
                );

        if(printingItem.last == true){
         for(int i=0; i<canvas.length; i++){
           canvas[i][maxHeight] = true;
         } 
        }
}