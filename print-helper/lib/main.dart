import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/home_screen.dart';
import 'package:flutter_web_signin/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {  
  runApp(
     Phoenix(
       child: MyApp()
     )
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      home: 
   //   HomePage(listPrintingItem: new List<PrintingItem>(),)
       AuthService().handleAuth()
    );
  }
}

