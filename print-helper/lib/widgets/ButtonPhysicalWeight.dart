import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';

class ButtonPhysicalWeight extends StatelessWidget {

  final List<PrintingItem> listPrintingItem;
  ButtonPhysicalWeight({Key key, this.listPrintingItem}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'Просчет Веса',
            child: Icon(Icons.fitness_center),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) =>
                  _alertDialog(context)
                )

            },
          );
  }

    Widget _alertDialog(BuildContext context){
    return  AlertDialog(
              title: Text('Просчет Физического Веса', style: TextStyle(fontWeight: FontWeight.bold),),
              content: SingleChildScrollView(
                              child: Container(
                  height: 470,
                  width: 400,
                  child: ListView.builder(
                    itemCount: listPrintingItem.length,
                    itemBuilder: (BuildContext context, int index){
                      double resultWeight = ((listPrintingItem[index].height * listPrintingItem[index].width / 100000 * listPrintingItem[index].printing) * listPrintingItem[index].grammar / 10000);
                      return 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Text('(${listPrintingItem[index].index}) ${listPrintingItem[index].name}:', style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black87)),
                          Text(
                          ' Вес одной позиции: ' + resultWeight.toStringAsFixed(2) + ' кг' + '\n'
                          ' Вес всех позиций: ' + resultWeight.toStringAsFixed(2) + ' x ${listPrintingItem[index].factor} = ' + (resultWeight * listPrintingItem[index].factor).toStringAsFixed(2) + ' кг ',
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)
                            )                      
                        ],),
                      );
                    },
                    ),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 3.0,
                  child: Text('Закрыть'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
              );
  }


}