import 'package:flutter/material.dart';
import 'package:flutter_web_signin/utilities/constants.dart';


class HomeCheckBox extends StatefulWidget {
  @override
  _HomeCheckBoxState createState() => _HomeCheckBoxState();
}

class _HomeCheckBoxState extends State<HomeCheckBox> {
  

  @override
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 750),
                padding: EdgeInsets.only(top: 10,),
                width: 330.0,
                child: SwitchListTile(
                title: const Text('Автоматическая Настройка Раскладки'),
                value: settingsCanvas.AUTO_SETTINGS,
                onChanged: (bool value) { 
                  setState(() 
                  { 
                    settingsCanvas.AUTO_SETTINGS = value; 
                    }); },
                secondary: const Icon(Icons.tune),
              )) 
          ],);

  }
}

