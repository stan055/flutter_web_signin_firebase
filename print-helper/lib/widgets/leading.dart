import 'package:flutter/material.dart';
import 'package:flutter_web_signin/service/auth_service.dart';

class Leading extends StatelessWidget {
GlobalKey<ScaffoldState> globalKey;
  Leading({this.globalKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){ 
               globalKey.currentState.openDrawer();
            },
              child: Container(height: 23, width: 56, color: Colors.transparent,
              child: Container(height: 23, child: Icon(Icons.menu, color: Colors.black87,)),
            ),
          );
  }
}