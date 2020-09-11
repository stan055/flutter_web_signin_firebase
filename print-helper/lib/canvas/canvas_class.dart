import 'package:flutter/material.dart';
import 'package:flutter_web_signin/canvas/add_left_horizontal.dart';
import 'package:flutter_web_signin/canvas/add_right_horizontal.dart';
import 'package:flutter_web_signin/canvas/add_top_left_horizontal.dart';
import 'package:flutter_web_signin/canvas/add_top_right_horizontal.dart';
import 'package:flutter_web_signin/canvas/cloneListPrintItems.dart';
import 'package:flutter_web_signin/canvas/getListWidgetPositioned.dart';
import 'package:flutter_web_signin/canvas/positionedItem.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/utilities/SettingsClass.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:random_color/random_color.dart';

class MyCanvas{
  Map<double, List<bool>> canvas = new Map<double, List<bool>>(); //Карта холста
  List<PrintingItem> listPrintingItem; // Лист Itemov
  List<PrintingItem> editedPrintingItem; // Лист редактированый Itemov
  List<PrintingItem> areaListPrintigItem;
  double maxWeight = 0;  
  double canvasWidth, canvasHeight;
  List<PositionedItemIndex> listPositioned = new List<PositionedItemIndex>(); //Лист Позиций
  List<Widget> listResultPrinting = new List<Widget>(); //Лист результата расчетов Тиражей позиций
  double resultPrinting = 0; //Расчетный тираж
  
//Конструктор
  MyCanvas(List<PrintingItem> listPrintingItem, double x, double y){
    this.listPrintingItem =  calculationFactor(listPrintingItem);
    canvasWidth = x;
    canvasHeight = y;
     weightCalculation(); // Расчет весов

//Заполняем canvas false - мы
    renewCanvas(x, y);
  }

//Заполняем canvas false - мы
renewCanvas(double x, double y){

    for (double i = 0; i < x; i++) {
      List<bool> _canvasItem = <bool>[];
      for (int ii = 0; ii < y; ii++) {
        _canvasItem.add(false);
      }
      canvas[i] = _canvasItem;
    }
}

 List<Widget> get getlistPositioned => getListWidgetPositioned(listPositioned);

// New list with calculation Factor
List<PrintingItem>  calculationFactor(List<PrintingItem> _listPrintingItem) {
    List<PrintingItem> _resultList = List<PrintingItem>();
    _listPrintingItem.forEach((item)  {
        for(int i=1; i<=item.factor; i++){
          
         Color _newColor = item.color;
          try{ 
            int x = 5;
            MyColor _myColor = getColorNameFromColor(item.color);
            RandomColor _randomColor = RandomColor();
            _newColor = _randomColor.randomColor(
              colorHue: ColorHue.custom(Range(_myColor.getHue - i +x, _myColor.getHue + i +x)), 
              colorSaturation: ColorSaturation.custom(Range(_myColor.getSaturation - x, _myColor.getSaturation + i +x)),
              colorBrightness: ColorBrightness.custom(Range(_myColor.getLightness - x, _myColor.getLightness + i +x))
              );
            // colorHue: ColorHue.custom(Range(_myColor.getHue,_myColor.getHue + (i + 5)))
            }  // New color 
          catch(e) { print(e); } 
          _resultList.add(
            PrintingItem(
                item.name,
                item.printing,
                i,  // New factor
                item.height,
                item.iheight,
                item.width,
                item.iwidth,
                item.grammar,
                item.index,
                _newColor.value
              )
          );
        }
     });
     return _resultList;
  }


//Расчет весов
  weightCalculation(){
  int min = 10000000;

//Поиск минимального числа
  for(int i=0; i<listPrintingItem.length; i++){
    listPrintingItem[i].count = 0; //обнуляем счетчики количества на листе
    if(min > listPrintingItem[i].printing){
       min = listPrintingItem[i].printing;
    } 
  }

//Расчет весов
  for(int i=0; i<listPrintingItem.length; i++){
    listPrintingItem[i].ratioWeight = listPrintingItem[i].printing / min;
    listPrintingItem[i].variableWeight = listPrintingItem[i].ratioWeight;
    // Максимальный вес
    if(maxWeight < listPrintingItem[i].ratioWeight)
      maxWeight = listPrintingItem[i].ratioWeight;
    }

}


// Создаем лист изменненный по весам
createEditedList(){
  List<PrintingItem> _editedPrintingItem = new List<PrintingItem>();
  
  for(int i=0; i<maxWeight; i++){
    for(int j=0; j<listPrintingItem.length; j++){
      
      if(listPrintingItem[j].variableWeight > 0.4){
        _editedPrintingItem.add(listPrintingItem[j]);

        listPrintingItem[j].variableWeight--;

      }
    }
  }
  return _editedPrintingItem;
}


  //Проверка на свободное место с лева на право по горизонтали
bool  placeCheck(int x, int y, PrintingItem item){
    int _maxHeight = y + item.height + item.iheight + (STROKE*2) ;
    int _maxWidth = x + item.width + item.iwidth + (STROKE*2);
      

      if(_maxHeight > canvasHeight || _maxWidth > canvasWidth){
        return false;
      } else {
        for(int iHeight = y; iHeight < _maxHeight; iHeight++){
          for(int iWidth = x; iWidth < _maxWidth; iWidth++){
            if(canvas[iWidth][iHeight]){
              return false;
            }
          }
        }
      }
      return true;
  }


//Переворот всего лита фигур по ширине
flipListToWidth(){
  for(int i=0; i<editedPrintingItem.length; i++){
    if(editedPrintingItem[i].height > editedPrintingItem[i].width){
      int height = editedPrintingItem[i].height;
      editedPrintingItem[i].height = editedPrintingItem[i].width;
      editedPrintingItem[i].width = height;
    }
  }
}

//Переворот всего лита фигур по Высоте
flipListToHeight(){
  for(int i=0; i<editedPrintingItem.length; i++){
    if(editedPrintingItem[i].height < editedPrintingItem[i].width){
      int height = editedPrintingItem[i].height;
      editedPrintingItem[i].height = editedPrintingItem[i].width;
      editedPrintingItem[i].width = height;
    }
  }
}

//Переворот одной фигуры
flipItem(PrintingItem printingItem){
      int height = printingItem.height;
      printingItem.height = printingItem.width;
      printingItem.width = height;
}

//Сортировка по индексу
sortIndex(){
     editedPrintingItem..sort((a,b)
       { 
        
        return ((a.index < b.index) ? -1 : ((a.index > b.index) ? 1 : 0)); 
    
       });
}

//Сортируем по самой большой фигуре
sortLargest(){
   editedPrintingItem..sort((a,b)
       { 
        
        return ((a.area > b.area) ? -1 : ((a.area < b.area) ? 1 : 0)); 
    
       });
 
}

//Лист в котором елементы расположены по расчеты площади, количеством расчитаным: ((canvasHeight * canvasWidth) / areaList)  
areaListCalculation(){
  areaListPrintigItem = new List<PrintingItem>(); 
  
  int areaList = 0;
  editedPrintingItem.forEach((element) {
    areaList = areaList + element.area;  //Площадь всего листа
  });
  
  int count = ((canvasHeight * canvasWidth) / areaList) ~/1; // Площадь холста / площадь листа

  editedPrintingItem.forEach((element) {
    for(int i = 0; i < count; i++){
      areaListPrintigItem.add(
        new PrintingItem(
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
          )
         );
    }
    areaListPrintigItem.last.last = true;  // last element
     
  });
}

calculationClear(){
      listPositioned.clear();                // Очистка листа позицый потом надо будет оптимизировать пропуская этот лист
      listResultPrinting.clear();            // Очистка листа потом надо будет оптимизировать
      renewCanvas(canvasWidth, canvasHeight); // Очистка canvas
      listPrintingItem.forEach((element) {
      element.count = 0; // Обнуление счетчика количества на листе Itemov
      });
}

// Редактирование editedPrintingItem огласно предыдушей раскладке (улучшение)
enhancementEditedPrintingItem(){
  editedPrintingItem.clear();
  listPrintingItem.forEach((element) {
    for(int i = 0; i < element.count; i++){
      editedPrintingItem.add(element);
    }
    element.count = 0; // Обнуление счетчика количества на листе Itemov
  });
  calculationClear();
}

canvasClone(Map<double, List<bool>> canvasClone){
  canvasClone = new Map <double, List<bool>>.from(
    canvas
  );
}



//-------------------------------------------
// Главная провайдер ф-я
calculation(bool autoSetting){

  editedPrintingItem = createEditedList(); // Создайом лист согласно весам

  if(autoSetting){
    Map<double, List<bool>> _trueCanvas; //Карта холста
    List<PrintingItem> _truelistPrintingItem = new List<PrintingItem>();
    List<PositionedItemIndex> _trueListPositioned; //Лист Позиций
    List<Widget> _trueListResultPrinting = new List<Widget>(); //Лист результата расчетов Тиражей позиций
    double _trueResultPrinting = 0.0;
    double _printingVar = 0.0;

    // Step 1
      settingsCanvas = settingsCanvasList[0];  // Новы настройки
      calculationMain();                      // Производим расчет
        
        _printingVar = resultPrinting;
        
           _trueCanvas =   new Map <double, List<bool>>.from( canvas );
           _trueListPositioned = new List<PositionedItemIndex>.from(listPositioned);
           cloneListPrintItems(listPrintingItem, _truelistPrintingItem);
           _trueListResultPrinting = new List<Widget>.from(listResultPrinting); 
           _trueResultPrinting = resultPrinting;
        
          calculationClear();         // Создание нового листа согласно вычислениям, Обнуление item.count, Очистка других листов

    // Step 2
      settingsCanvas = settingsCanvasList[1];  
      calculationMain();

          if(resultPrinting <= _printingVar){
            _printingVar = resultPrinting;
           _trueCanvas =   new Map <double, List<bool>>.from( canvas );
           _trueListPositioned = new List<PositionedItemIndex>.from(listPositioned);
           cloneListPrintItems(listPrintingItem, _truelistPrintingItem);           
           _trueListResultPrinting = new List<Widget>.from(listResultPrinting); 
           _trueResultPrinting = resultPrinting;
          }
          enhancementEditedPrintingItem(); 

    // Step 3
      settingsCanvas = settingsCanvasList[2];
      calculationMain();
        if(resultPrinting <= _printingVar){
          _printingVar = resultPrinting;
          _trueCanvas =   new Map <double, List<bool>>.from( canvas );
          _trueListPositioned = new List<PositionedItemIndex>.from(listPositioned);
          cloneListPrintItems(listPrintingItem, _truelistPrintingItem);          
          _trueListResultPrinting = new List<Widget>.from(listResultPrinting); 
          _trueResultPrinting = resultPrinting;
        }
      calculationClear();

    // step 4
      settingsCanvas = settingsCanvasList[3];
      calculationMain();
        if(resultPrinting < _printingVar){
          _printingVar = resultPrinting;
           _trueCanvas =   new Map <double, List<bool>>.from( canvas );
           _trueListPositioned = new List<PositionedItemIndex>.from(listPositioned);
            cloneListPrintItems(listPrintingItem, _truelistPrintingItem);           
           _trueListResultPrinting = new List<Widget>.from(listResultPrinting); 
           _trueResultPrinting = resultPrinting;
        }
      calculationClear();

    // step 5
      settingsCanvas = settingsCanvasList[4];
      calculationMain();
        if(resultPrinting < _printingVar){
          _printingVar = resultPrinting;
           _trueCanvas =   new Map <double, List<bool>>.from( canvas );
           _trueListPositioned = new List<PositionedItemIndex>.from(listPositioned);
           cloneListPrintItems(listPrintingItem, _truelistPrintingItem);          
           _trueListResultPrinting = new List<Widget>.from(listResultPrinting); 
           _trueResultPrinting = resultPrinting;
        }
      calculationClear();

    // final step
      canvas = _trueCanvas;
      listPositioned = _trueListPositioned;
      listPrintingItem = _truelistPrintingItem;
      listResultPrinting = _trueListResultPrinting;
      resultPrinting = _trueResultPrinting;
  }
  else {
    calculationMain();
  }
}
//--------------------------------------------------
//Просчитываем
calculationMain(){
   
    


    if(settingsCanvas.SORT_INDEX){
      sortIndex(); //Сортировка по индексу
    }
    
    if(settingsCanvas.SORT_LARGEST){
      sortLargest();    //Сортируем по самой большой фигуре
    }

    if(settingsCanvas.CREATE_AREA_LIST){  // Create list with area
       areaListCalculation();
       editedPrintingItem = areaListPrintigItem;
    }



    if(settingsCanvas.FLIP_LIST_TO_HEIGHT){
      flipListToHeight();
    }

    if(settingsCanvas.FLIP_LIST_TO_WIDTH){
      flipListToWidth();
    }



    int i = 0;
    int position = 0;

    int success = 0; 
    bool flip = settingsCanvas.FLIP_ITEM;
    
    // double _leftHorizontalWidth = canvasWidth;
    // double _leftHorizontalVariableWidth;

    Map<String, int> leftHorizontalResponse = {'startWidth': 0, 'startHeight': 0, 'success': 0, 'incrementHeight': 1, 'incrementWidth': 1};
    Map<String, int> rightHorizontalResponse = {'startWidth': (canvasWidth ~/1 - 1), 'startHeight': 0, 'success': 0,  'incrementHeight': 1, 'incrementWidth': 1};
    Map<String, int> topRightResponse = {'startWidth': (canvasWidth ~/1 - 1), 'startHeight': (canvasHeight ~/1 - 1), 'success': 0,  'incrementHeight': 1, 'incrementWidth': 1};
    Map<String, int> topLeftResponse = {'startWidth': 0, 'startHeight': (canvasHeight ~/1 - 1), 'success': 0,  'incrementHeight': 1, 'incrementWidth': 1};




    while(success < editedPrintingItem.length){

      position = editedPrintingItem[i].index;
      
      if(!settingsCanvas.START_WIDTH_HEIGHT) {
        leftHorizontalResponse['startWidth'] = 0;
        leftHorizontalResponse['startHeight'] = 0;
        
        rightHorizontalResponse['startWidth'] = (canvasWidth ~/1 - 1);
        rightHorizontalResponse['startHeight'] = 0;

        topRightResponse['startWidth'] = (canvasWidth ~/1 - 1);
        topRightResponse['startHeight'] = (canvasHeight ~/1 - 1);

        topLeftResponse['startWidth'] = 0;
        topLeftResponse['startHeight'] = (canvasHeight ~/1 - 1);
      }
      if(!settingsCanvas.INCREMENT_PROGRESSIVE_HEIGHT_WIDTH){
        leftHorizontalResponse['incrementHeight'] = 1;
        leftHorizontalResponse['incrementWidth'] = 1;

        rightHorizontalResponse['incrementWidth'] = 1;
        rightHorizontalResponse['incrementHeight'] = 1;

        topRightResponse['incrementWidth'] = 1;
        topRightResponse['incrementHeight'] = 1;

        topLeftResponse['incrementWidth'] = 1;
        topLeftResponse['incrementHeight'] = 1;
      }
      
      if(!settingsCanvas.SIMPLE_LINE_LAYOUT){
        switch(position){

        case 1:
        case 5:
        case 9:
        leftHorizontalResponse = addWidgetToListWithWeightLeftHorizontal(leftHorizontalResponse['incrementWidth'], leftHorizontalResponse['incrementHeight'], leftHorizontalResponse['startWidth'], leftHorizontalResponse['startHeight'],
          canvasHeight, canvasWidth, editedPrintingItem[i], listPrintingItem[editedPrintingItem[i].index -1], canvas, listPositioned, settingsCanvas.LEFT_HORIZONTAL, flip);
       //   print( " startWidth: ${leftHorizontalResponse['startWidth']}  startHeight: ${leftHorizontalResponse['startHeight']} ");
        success = success + leftHorizontalResponse['success'];
        break;
        
        case 7:
        case 3:
        case 11:
        rightHorizontalResponse = addWidgetToListWithWeightRightHorizontal(rightHorizontalResponse['incrementWidth'], rightHorizontalResponse['incrementHeight'], rightHorizontalResponse['startWidth'], rightHorizontalResponse['startHeight'],
          canvasHeight, canvasWidth , editedPrintingItem[i], listPrintingItem[editedPrintingItem[i].index -1], canvas, listPositioned, settingsCanvas.RIGHT_HORIZONTAL, flip);
      //    print( " startWidth: ${rightHorizontalResponse['startWidth']}  startHeight: ${rightHorizontalResponse['startHeight']} ");
        success = success + rightHorizontalResponse['success'];
        break;

        case 2:
        case 6:
        case 10:
          topRightResponse = addWidgetToListWithWeightTopRightHorizontal(topRightResponse['incrementWidth'], topRightResponse['incrementHeight'], topRightResponse['startWidth'], topRightResponse['startHeight'],
          canvasHeight, canvasWidth , editedPrintingItem[i], listPrintingItem[editedPrintingItem[i].index -1], canvas, listPositioned, settingsCanvas.RIGHT_TOP, flip);
       //   print( " startWidth: ${topRightResponse['startWidth']}  startHeight: ${topRightResponse['startHeight']} ");
        success = success + topRightResponse['success'];
        break;

        case 8:
        case 4:
        case 12: 
          topLeftResponse = addWidgetToListWithWeightTopLeftHorizontal(topLeftResponse['incrementWidth'], topLeftResponse['incrementHeight'], topLeftResponse['startWidth'], topLeftResponse['startHeight'],
          canvasHeight, canvasWidth , editedPrintingItem[i], canvas, listPositioned, settingsCanvas.LEFT_TOP, flip);
       //   print( " startWidth: ${topLeftResponse['startWidth']}  startHeight: ${topLeftResponse['startHeight']} ");
        success = success + topLeftResponse['success'];
        break;
        
        default:
          topLeftResponse = addWidgetToListWithWeightTopLeftHorizontal(topLeftResponse['incrementWidth'], topLeftResponse['incrementHeight'], topLeftResponse['startWidth'], topLeftResponse['startHeight'],
          canvasHeight, canvasWidth , editedPrintingItem[i], canvas, listPositioned, settingsCanvas.LEFT_TOP, flip);
     //     print( " startWidth: ${topLeftResponse['startWidth']}  startHeight: ${topLeftResponse['startHeight']} ");
        success = success + topLeftResponse['success'];
        break;
        break;
      }        
        } else {
          switch(position){
              
              default:
              leftHorizontalResponse = addWidgetToListWithWeightLeftHorizontal(leftHorizontalResponse['incrementWidth'], leftHorizontalResponse['incrementHeight'], leftHorizontalResponse['startWidth'], leftHorizontalResponse['startHeight'],
                canvasHeight, canvasWidth, editedPrintingItem[i], listPrintingItem[i], canvas, listPositioned, settingsCanvas.LEFT_HORIZONTAL, flip);
            //   print( " startWidth: ${leftHorizontalResponse['startWidth']}  startHeight: ${leftHorizontalResponse['startHeight']} ");
              success = success + leftHorizontalResponse['success'];
              break;
          }
        }


      i++;
      if(i == editedPrintingItem.length) i = 0;
    }
  //print('VARIABLE_COUNT1: ' + VARIABLE_COUNT1.toString() + '   VARIABLE_COUNT2: ' + VARIABLE_COUNT2.toString()+ '   VARIABLE_COUNT3: ' + VARIABLE_COUNT3.toString());
    calculatingPrinting();
}


  //Вычисление тиража
  calculatingPrinting(){
    
    //Вычисляем Самый большой Тираж
    listPrintingItem.forEach((element) { 
      double printingDividedCount = element.printing / element.count;
      if(resultPrinting < printingDividedCount)
        resultPrinting = printingDividedCount;
      });

    for(int i=0; i< listPrintingItem.length; i++){

      listResultPrinting.add( Row(
          children: <Widget>[
        Icon(
          Icons.turned_in,
          color: listPrintingItem[i].color,
        ),
        Expanded(
                  child: Text(
            '#' + (listPrintingItem[i].index).toString() + 
            '[' + listPrintingItem[i].factor.toString() + ']'
            + listPrintingItem[i].name 
            + ' на листе: ' 
            + listPrintingItem[i].count.toString() + ', '
            + 'на выходе: '
            + (listPrintingItem[i].count * resultPrinting).toStringAsFixed(1)
            , style: TextStyle(fontSize: 17),
          ),
        ),
                    ]));
    }
}

}

//-------------------------------------------------------------------------------------------------------------------------------------
//Код для раскладки по умной ширине ширины 

      // switch(position){
        
      //   case 1:
      //   case 5:
      //   case 9:

      //   int _width;
      //   if((_width = addWidgetToListWithWeightLeftHorizontal(canvasHeight, _leftHorizontalWidth, editedPrintingItem[i], canvas, listPositioned, false, flip)) == -1) {
      //      success++;
      //   } else if (_width > 0){
      //       _leftHorizontalVariableWidth = (_width * 1.0);  
      //     }
      //     if(_width == 0){
      //       _leftHorizontalWidth = _leftHorizontalVariableWidth;
      //     } 

      //   break;

//--------------------------------------------------------------------------------------------------------------------------------------

//   } else {
//       for (int iheight = 0; iheight < canvasHeight; iheight++) {
//         for (int iwidth = 0; iwidth < canvasWidth; iwidth++) {
          
//             if (!canvas[iwidth][iheight]) {

//                     int _maxHeight = iheight + printingItem.height + (printingItem.iheight*2) + (STROKE*2) ;
//                     int _maxWidth = iwidth + printingItem.width + (printingItem.iwidth*2) + (STROKE*2);
//                     if(_maxHeight < canvasHeight && _maxWidth < canvasWidth ){
                      
//                       if(!canvas[_maxWidth-1][_maxHeight-1]){

//                 //Проверяем есть ли свободное место
//                 if(placeCheck(_maxHeight, _maxWidth,  iwidth, iheight, canvas))
//                  {

//                 //Добавляем виджет в listPositioned
//                 addWidgetToList(iwidth, iheight, printingItem, listPositioned);

//                 //Счетчик количества на листе
//                 printingItem.count++;
                
                
//                 // Заполнение canvas холста фигурой
//                 fillingCanvas(iwidth, iheight, printingItem, canvas);

//                 if(iheight == 0){
//                   return _maxWidth;
//                 }
//                 return 0;
//               }
//             }
//             }
//         }

//       }
//     }
//     return -1;
//   }


// }