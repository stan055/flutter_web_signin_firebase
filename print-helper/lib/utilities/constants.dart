import 'package:flutter/material.dart';
import 'package:flutter_web_signin/utilities/SettingsClass.dart';

const double INDENT_BOTTOM = 10;
const double INDENT_TOP = 10;
const double INDENT_LEFT_RIGHT = 10;
const double A1_HEIGHT = 610 + INDENT_BOTTOM*2;
const double A1_WIDTH = 890 + INDENT_BOTTOM*2;

const double A2_HEIGHT = 435 + INDENT_BOTTOM*2;
const double A2_WIDTH = 630 + INDENT_BOTTOM*2;

const double A3_HEIGHT = 315 + INDENT_BOTTOM*2;
const double A3_WIDTH = 435 + INDENT_BOTTOM*2;

const double B1_HEIGHT = 670 + INDENT_BOTTOM*2;
const double B1_WIDTH = 990 + INDENT_BOTTOM*2;

const double B2_HEIGHT = 480 + INDENT_BOTTOM*2;
const double B2_WIDTH = 690 + INDENT_BOTTOM*2;

const double B3_HEIGHT = 340 + INDENT_BOTTOM*2;
const double B3_WIDTH = 480 + INDENT_BOTTOM*2;

const int STROKE = 0;
const double STEP = 10.0;
const bool STEP_SWICH = false;
int VARIABLE_COUNT1 = 0;
int VARIABLE_COUNT2 = 0;
int VARIABLE_COUNT3 = 0;
String EMAIL = '';


SettingsCanvas settingsCanvas = SettingsCanvas(
    FLIP_ITEM: false,
    SORT_LARGEST: false,
    LEFT_HORIZONTAL: false,
    LEFT_TOP: false,
    RIGHT_HORIZONTAL: false,
    RIGHT_TOP: false,
    START_WIDTH_HEIGHT: false,
    INCREMENT_PROGRESSIVE_HEIGHT_WIDTH: false,
    FLIP_LIST_TO_HEIGHT: false,
    FLIP_LIST_TO_WIDTH: false,
    CREATE_AREA_LIST: true,
    SORT_INDEX: false,
    SIMPLE_LINE_LAYOUT: false,
    AUTO_SETTINGS: false,
);


final kHintTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
  fontSize: 15
);

final textFormStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
  fontSize: 16,
);

final kLabelStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.w100,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey[50],
  borderRadius: BorderRadius.circular(3.0),
  border: Border.all(
    color: Colors.grey[300],
    width: 1.0
  )
  
  // boxShadow: [
  //   BoxShadow(
  //     color: Colors.black12,
  //     blurRadius: 1.0,
  //     offset: Offset(0, 2),
  //   ),
  // ],
);

final kBoxDecorationHomeForm = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(4.0),
  border: Border.all(
    color: Colors.grey[300],
    width: 1.0
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 1.0,
      offset: Offset(1, 1),
    ),
  ],
);

//Фон login screen
final backgroundDecoration = BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfffdfdfd),
              Color(0xfffdfdfd),
              Color(0xfffdfdfd),
              Color(0xfffdfdfd),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        );

//Фон home screen 
final backgroundDecorationHome = BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x11fdf6f3),
              Color(0x11fdf6f3),
              Color(0x11fdf6f3),
              Color(0x11fdf6f3),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        );


final tStylePositionItem = TextStyle(
                      color: Colors.black87,
                      shadows: [
                         Shadow( 
                      color: Colors.white.withOpacity(1.0), 
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                     )],);