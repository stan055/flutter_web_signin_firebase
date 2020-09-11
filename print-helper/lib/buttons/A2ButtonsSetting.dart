import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/a2_screen.dart';
import 'package:flutter_web_signin/utilities/constants.dart';

class A2ActionButtonSetting extends StatelessWidget {
  final List<PrintingItem> listPrintingItem;

  A2ActionButtonSetting({Key key, this.listPrintingItem}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'Setting',
            child: Icon(Icons.settings),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) =>
                  _alertDialog(context)
                )

            },
          );
  }

  Widget _alertDialog(BuildContext context){
    return  AlertDialog(
              title: Text('Настройки Раскладки', style: TextStyle(fontWeight: FontWeight.bold),),
              content: SettingCheckBox(),
              actions: <Widget>[
                MaterialButton(
                  elevation: 3.0,
                  child: Text('Применить'),
                  onPressed: (){
                    settingsCanvas.AUTO_SETTINGS = false;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => A2Screen(listPrintingItem: listPrintingItem)));
                  },
                ),
                 MaterialButton(
                  elevation: 3.0,
                  child: Text('Закрыть'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
              );
  }
}


class SettingCheckBox extends StatefulWidget {
  @override
  _HomeCheckBoxState createState() => _HomeCheckBoxState();
}

class _HomeCheckBoxState extends State<SettingCheckBox> {
  
  void onChangeBoxFlip(bool value){
    setState((){
            settingsCanvas.FLIP_ITEM = value;
    });
  }  

  void onChangeBoxSortLargest(bool value){
    setState((){
            settingsCanvas.SORT_LARGEST = value;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Column (children: <Widget>[
      Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Переворот фигуры по надобности', style: TextStyle(fontSize: 12),),
     
        value: settingsCanvas.FLIP_ITEM,
        onChanged: (bool value){
          onChangeBoxFlip(value);
        },
        ),
      ),

      Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Сортировка по индексу', style: TextStyle(fontSize: 12),),
     
        value: settingsCanvas.SORT_INDEX,
        onChanged: (bool value){
            setState(() {
              settingsCanvas.SORT_INDEX = value;
            });
        },
        ),
      ),

      Container(
        height: 50.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Сортировка по площади', style: TextStyle(fontSize: 12),),
        value: settingsCanvas.SORT_LARGEST,
        onChanged: (bool value){
          onChangeBoxSortLargest(value);
        },
        ),
      ),

      Container(
        height: 50.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Прогрессивный инкремент(економит время + может упорядочить раскладку)', style: TextStyle(fontSize: 12),),
        value: settingsCanvas.INCREMENT_PROGRESSIVE_HEIGHT_WIDTH,
        onChanged: (bool value){
          setState(() {
              settingsCanvas.INCREMENT_PROGRESSIVE_HEIGHT_WIDTH = value;
            });
        },
        ),
      ),

      Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Начинать с последней координаты(економит время)', style: TextStyle(fontSize: 12),),
     
        value: settingsCanvas.START_WIDTH_HEIGHT,
        onChanged: (bool value){
            setState(() {
              settingsCanvas.START_WIDTH_HEIGHT = value;
            });
        },
        ),
      ),

            Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Переворот всего списка по высоте', style: TextStyle(fontSize: 12),),
        value: settingsCanvas.FLIP_LIST_TO_HEIGHT,
        onChanged: (bool value){
          setState(() {
              settingsCanvas.FLIP_LIST_TO_WIDTH = false;
              settingsCanvas.FLIP_LIST_TO_HEIGHT = value;
            });
        },
        ),
      ),

      Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Переворот всего списка по ширине', style: TextStyle(fontSize: 12),),
     
        value: settingsCanvas.FLIP_LIST_TO_WIDTH,
        onChanged: (bool value){
            setState(() {
              settingsCanvas.FLIP_LIST_TO_HEIGHT = false;
              settingsCanvas.FLIP_LIST_TO_WIDTH = value;
            });
        },
        ),
      ),

      Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Раскладка по расчету площади', style: TextStyle(fontSize: 12),),
     
        value: settingsCanvas.CREATE_AREA_LIST,
        onChanged: (bool value){
            setState(() {
              settingsCanvas.CREATE_AREA_LIST = value;
            });
        },
        ),
      ),

      Container(
        height: 40.0,
        width: 350.0,
        child: CheckboxListTile(
        title: Text('Простая построчная раскладка с левого клапана(По умолчанию с углов)', style: TextStyle(fontSize: 12),),
     
        value: settingsCanvas.SIMPLE_LINE_LAYOUT,
        onChanged: (bool value){
            setState(() {
              settingsCanvas.SIMPLE_LINE_LAYOUT = value;
            });
        },
        ),
      ),
//-----------------Направление Раскладки-----------------------------//
      Container(
        padding: EdgeInsets.only(top: 12.0),
        child: Column(
          children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Text('Направления Раскладки(по умолчанию по горизонтали):'),
           ),
          Row(children: <Widget>[
                  Container(
          height: 50.0,
          width: 200.0,
          child: CheckboxListTile(
             subtitle: Text('Левый хвост по вертикали', style: TextStyle(fontSize: 12),),
          value: settingsCanvas.LEFT_TOP,
          onChanged: (bool value){
                        setState(() {
              settingsCanvas.LEFT_TOP = value;
            });
          },
      ),
                  ),
       Container(
          height: 50.0,
          width: 200.0,
          child: CheckboxListTile(
             subtitle: Text('Правый хвост по вертикали', style: TextStyle(fontSize: 12),),
          value: settingsCanvas.RIGHT_TOP,
          onChanged: (bool value){
                setState(() {
              settingsCanvas.RIGHT_TOP = value;
            });
          },
      ),
                  )
          ],),
            Row(children: <Widget>[
                  Container(
          height: 50.0,
          width: 200.0,
          child: CheckboxListTile(
             subtitle: Text('Левый клапан по вертикали', style: TextStyle(fontSize: 12),),
          value: settingsCanvas.LEFT_HORIZONTAL,
          onChanged: (bool value){
                        setState(() {
              settingsCanvas.LEFT_HORIZONTAL = value;
            });
          },
      ),
                  ),
         Container(
          height: 50.0,
          width: 200.0,
          child: CheckboxListTile(
          subtitle: Text('Правый клапан по вертикали', style: TextStyle(fontSize: 12),),
          value: settingsCanvas.RIGHT_HORIZONTAL,
          onChanged: (bool value){
            setState(() {
              settingsCanvas.RIGHT_HORIZONTAL = value;
            });
          },
      ),
                  )
          ],),
        ],),
      )
    ],);
  }
}