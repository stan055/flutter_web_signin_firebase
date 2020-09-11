import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/home_screen.dart';
import 'package:flutter_web_signin/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/utilities/constants.dart';

class AuthService {
  //Handle Authentication
  handleAuth() {
    return StreamBuilder<FirebaseUser> (
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if(user == null){
            return LoginPage();  
          }
          return HomePage(listPrintingItem: new List<PrintingItem>());
        } else {
          return LoginPage();
        }
      },
    );
  }

  //Sign Out
  signOut(BuildContext context) async {
    try{
       await FirebaseAuth.instance.signOut();
        print('SignOut');
        Phoenix.rebirth(context);

    }catch(err){
      print(err);
    }

  }

  //Sign in
 signIn(email, password, BuildContext context) async {
   await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      EMAIL = email;
      print('Signed in');
    }).catchError((e) {
      print(e);
      showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Ошибка подключения'),
          content: Text('Неверный email или password'),
          actions: <Widget>[
            FlatButton(child: Text('Закрыть'),
            onPressed: (){
              Navigator.of(context).pop();
            },)
          ],
        );
      }

      );

    });

  }
  
}
