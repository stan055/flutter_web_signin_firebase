import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:flutter_web_signin/widgets/snack_bar_home_screen.dart';

class HomeActionButtonSave extends StatelessWidget {
  
  HomeActionButtonSave({Key key, this.listPrintingItem, this.scaffoldstate}) : super(key: key);
  final List<PrintingItem> listPrintingItem;
  final GlobalKey<ScaffoldState> scaffoldstate;
  

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            heroTag: 'Save',
            child: Icon(Icons.save),
            onPressed: () => {

              saveFirebase()

            },
          );
  }


void saveFirebase () async{
  try {

    if(EMAIL == ''){
      FirebaseUser user =  await FirebaseAuth.instance.currentUser();
      EMAIL = user.email;
    }



     int count = await readIndexCount();
     await writeIndexCount(count);
    
     var array = listToMap();

    await Firestore.instance.collection(EMAIL).
        document(DateTime.now().toIso8601String()).setData( { 'count': count,'array': array});

    MySnackBarScreen( scaffoldstate, '№$count Добавлено в Журнал!' , Colors.green);
    
  } catch (err) {
    print('Caught error: $err');
    MySnackBarScreen( scaffoldstate, 'Ошибка! Сохранения! $err', Colors.red );
  }
}



//Считываем счетчик номера заказ
Future<int> readIndexCount() async{
  DocumentSnapshot snapshot = await Firestore.instance.collection('index_count').document('index').get();
  int count = snapshot.data['count'];
  return count;
}


//Записываем счетчик номера заказа
Future<void> writeIndexCount(int count) async{
   await Firestore.instance.collection('index_count').document('index').setData({  'count': ++count,  });
}


//Делаем Map из listPrintigItem
List<Map> listToMap(){
  List<Map> listMap = new List<Map>();
  for(int i=0; i<listPrintingItem.length; i++){
    listMap.add(listPrintingItem[i].toMap());
  }
  return listMap;
}


}