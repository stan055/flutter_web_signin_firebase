import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/home_screen.dart';

class ActionButtonHomeScreen extends StatelessWidget {
  final List<PrintingItem> listPrintingItem;

  ActionButtonHomeScreen({Key key, this.listPrintingItem})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'Next',
            child: Icon(Icons.home),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(listPrintingItem:listPrintingItem)));
            },
          );
  }
}