
import 'package:flutter/material.dart';

class MySnackBarScreen  {

  MySnackBarScreen(GlobalKey<ScaffoldState> _scaffoldstate, String text, Color color){
         _scaffoldstate.currentState.showSnackBar(
              new SnackBar(
                backgroundColor: color,
                  duration: new Duration(seconds: 1),
                  content: new Text( text, textAlign: TextAlign.center,),),);
   }
}




