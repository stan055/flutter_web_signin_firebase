import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/screens/home_screen.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:flutter_web_signin/widgets/app_bar_list.dart';
import 'package:flutter_web_signin/widgets/drawer.dart';
import 'package:flutter_web_signin/widgets/leading.dart';

class MyJournal extends StatefulWidget {
  @override
  _MyJournalState createState() => _MyJournalState();
}

class _MyJournalState extends State<MyJournal> {
  
  QuerySnapshot snapshot;
  List<ListPrintingOfSnapshot> listOfSnapshot = new List<ListPrintingOfSnapshot>(); 
  bool circularProgres = true;
  ColorScale _colorScale;
  Widget circularOrText = CircularProgressIndicator();

  @override
  void initState(){
    
    _colorScale = new ColorScale();
    
    super.initState();
    
    readData();

  }

  final GlobalKey<ScaffoldState> scaffoldstate = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double globalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldstate,
       appBar: AppBar(
          elevation: 0,
          titleSpacing: 0.0,
          backgroundColor: Colors.transparent,
          leading:  Container(height: 25, child: Leading(globalKey: scaffoldstate)),
          
          title: Container(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _colorScale.createScale(globalWidth)),
          )),
          drawer: Container(
            color: Colors.black,
            child: MyDrawer()
          ),
          body: circularProgres? 
          Container(
          decoration: backgroundDecorationHome,
            child: Center(
                child: circularOrText,
              ),
          ) :
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: backgroundDecorationHome,
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    child: Column(children: <Widget>[
                            Container(
                              width: 560.0,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: listOfSnapshot.length,
                                itemBuilder: (context, index){
                                  int _reverseIndex = listOfSnapshot.length - index -1;
                                   return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Card(
                                        elevation: 4.0,
                                        child: ListTile(
                                          onTap: () => {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(listPrintingItem: listOfSnapshot[_reverseIndex].listPrinting)))
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Text(' №' + listOfSnapshot[_reverseIndex].count.toString() + '\t'),
                                                  Text(listOfSnapshot[_reverseIndex].documentId, 
                                                    style: TextStyle( fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black87)),
                                                ],),
                                                 Container(
                                                    width: 23.0,
                                                    height: 23.0,
                                                    child: RaisedButton(
                                                      elevation: 3.0,
                                                      onPressed: () 
                                                      async {
                                                         await deleteItem(snapshot.documents[_reverseIndex].documentID, _reverseIndex);
                                                      },
                                                     padding: EdgeInsets.all(0.0),
                                                    shape: RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(15.0),),
                                                                    color: Colors.white,
                                                                    child: Icon(Icons.delete_forever,
                                                                         color: Colors.black87,
                                                                          size: 17.0,
                                                                    )),
                                                         ),
                                              ],
                                            ),
                                          ),
                                          subtitle: _buildListPinting(_reverseIndex),
                                        ),
                                      ),
                                    ),
                                  );
                                                                    
                                },
                        ),
                            )
                    ],),
                  ),
                ),
              )
            )
            )
    );
  }



//Читаем базу firestore аккаунта
  readData() async{
    try{

     snapshot = await Firestore.instance.collection(EMAIL).getDocuments();
     
     for(int i=0; i<snapshot.documents.length; i++){
      listOfSnapshot.add(
        ListPrintingOfSnapshot(
        snapshot.documents[i].documentID, 
        snapshot.documents[i].data['count'], 
        snapshot.documents[i].data['array'])
         );
     }

      setState(() {
        circularProgres = false;

      });

    }catch(err){
      setState(() {
        circularOrText = Text('Ошибка Баз Данных', style: TextStyle(color: Colors.red),);
        print(err);
      });

    }
}


//Удаляем Item с базы Firebase
  deleteItem(String id, int index) async{
    try{

      await Firestore.instance.collection(EMAIL).document(id).delete();    
            listOfSnapshot.removeAt(index);
               setState(() {
                          });
    }catch(err){
      print(err);
    }
}


  Widget _buildListPinting(int index){
    ListPrintingOfSnapshot _listPrintingOfSnapshot = listOfSnapshot[index];
    return Column(children: <Widget>[
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 7.0),
        itemCount: _listPrintingOfSnapshot.listPrinting.length,
        itemBuilder: (context, _index){
            return Container(
              width: 520,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                          Icon(Icons.bookmark, color:_listPrintingOfSnapshot.listPrinting[_index].color,),
                          Text(
                              '(' + _listPrintingOfSnapshot.listPrinting[_index].index.toString() +  ') ' +
                              _listPrintingOfSnapshot.listPrinting[_index].name +
                              ' / ' +
                              _listPrintingOfSnapshot.listPrinting[_index].printing.toString() +  'шт / ' +
                              'В.' +  _listPrintingOfSnapshot.listPrinting[_index].height.toString() +
                              ' x Ш.' +  _listPrintingOfSnapshot.listPrinting[_index].width.toString() +
                              ' / ' +   _listPrintingOfSnapshot.listPrinting[_index].grammar.toString() + 'г/м2',
                               style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 15, color: Colors.grey[600]),
                             ),
                          
    ]),
              ),
            );
        }
        )
    ],);
  }

}



//class List из Snapshota
class ListPrintingOfSnapshot{
  List<PrintingItem> listPrinting = new List<PrintingItem>();
  int count;
  String documentId;

  ListPrintingOfSnapshot(String _documentId, int _count, List<dynamic> _listMap){
    documentId = _documentId;
    count = _count;

    for(int i = 0; i<_listMap.length; i++){
      PrintingItem printingItem = new PrintingItem
    ( 
     _listMap[i]['name'],
     _listMap[i]['printing'],
     _listMap[i]['factor'],
     _listMap[i]['height'],
     _listMap[i]['iheight'],
     _listMap[i]['width'],
     _listMap[i]['iwidth'],
     _listMap[i]['grammar'],
     _listMap[i]['index'],
     _listMap[i]['color']
    );

     listPrinting.add(printingItem);
    }
  }
}