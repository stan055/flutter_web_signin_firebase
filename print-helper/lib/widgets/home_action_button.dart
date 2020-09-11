import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/a1_screen.dart';
import 'package:flutter_web_signin/screens/a2_screen.dart';
import 'package:flutter_web_signin/screens/a3_screen.dart';
import 'package:flutter_web_signin/screens/b1_screen.dart';
import 'package:flutter_web_signin/screens/b2_screen.dart';
import 'package:flutter_web_signin/screens/b3_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomeActionButtonAll extends StatelessWidget {
    
  HomeActionButtonAll({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;
  final spinkit = SpinKitCubeGrid(
    color: Colors.grey,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'Next',
            child: Icon(Icons.navigate_next),
            onPressed: () => { 
          //       showDialog(
          //       barrierDismissible: false,
          //       context: context,
          //       builder: (BuildContext context) {
          //               return Dialog(
          //               child: Padding(
          //                 padding: const EdgeInsets.all(18.0),
          //                 child: new Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                      Text("Ожидайте производится вычисления... "),
          //                      spinkit,
                              
          //                   ],
          //                 ),
          //               ),
          //             );
          //       } 
          //       ),
          //         new Future.delayed(new Duration(milliseconds: 1200), () {
          // //           Navigator.push(context, MaterialPageRoute(builder: (_) => TestScreen()));
          //           })
            },
          );
  }

  //   Widget _alertDialog(BuildContext context) {
  //   return  AlertDialog(
  //             title: Text('Настройки Раскладки', style: TextStyle(fontWeight: FontWeight.bold),),
  //             content: Text('alertDialog'),
  //             actions: <Widget>[
  //               MaterialButton(
  //                 elevation: 3.0,
  //                 child: Text('Закрыть'),
  //                 onPressed: (){
  //                   Navigator.of(context).pop();
  //                 },
  //               )
  //             ],
              
  //             );
              
  // }
}



class HomeActionButtonA1 extends StatelessWidget {

  HomeActionButtonA1({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'A1',
            child: Text('A1'),
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_) => A1Screen(listPrintingItem: listPrintingItem)))
            },
          );
  }
}

class HomeActionButtonA2 extends StatelessWidget {
  
  HomeActionButtonA2({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'A2',
            child: Text('A2'),
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_) => A2Screen(listPrintingItem: listPrintingItem)))
            },
          );
  }
}

class HomeActionButtonA3 extends StatelessWidget {
  HomeActionButtonA3({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'A3',
            child: Text('A3'),
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_) => A3Screen(listPrintingItem: listPrintingItem)))
            },
          );
  }
}

class HomeActionButtonB1 extends StatelessWidget {
  HomeActionButtonB1({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'B1',
            child: Text('B1'),
            onPressed: () => {
               Navigator.push(context, MaterialPageRoute(builder: (_) => B1Screen(listPrintingItem: listPrintingItem)))
            },
          );
  }
}


class HomeActionButtonB2 extends StatelessWidget {
  HomeActionButtonB2({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'B2',
            child: Text('B2'),
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_) => B2Screen(listPrintingItem: listPrintingItem)))
            },
          );
  }
}


class HomeActionButtonB3 extends StatelessWidget {
  HomeActionButtonB3({Key key, this.listPrintingItem }) : super(key: key);
  final List<PrintingItem> listPrintingItem;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'B3',
            child: Text('B3'),
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_) => B3Screen(listPrintingItem: listPrintingItem)))
            },
          );
  }
}




//---------------------------------------------------------------------------------------


