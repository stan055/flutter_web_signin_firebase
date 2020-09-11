import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/home_screen.dart';
import 'package:flutter_web_signin/screens/my_journal.dart';
import 'package:flutter_web_signin/service/auth_service.dart';
import 'package:flutter_web_signin/utilities/constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/logo_ecostream-techno.jpg'),
            fit: BoxFit.cover
            )
          ),
          accountName: Text(''),
          accountEmail: Text(EMAIL, style: TextStyle(color: Colors.black)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Главная'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(listPrintingItem: new List<PrintingItem>(),))),
        ),
       ListTile(
          leading: Icon(Icons.list),
          title: Text('Журнал'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyJournal())),
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child:        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Выход'),
          onTap: () => {
            AuthService().signOut(context),
            print('out...') }
            
          
        ),
          ),
        )
      ],),
    );
  }
}