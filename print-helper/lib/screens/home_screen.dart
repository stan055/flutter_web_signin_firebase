import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_signin/utilities/check_width_height.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:flutter_web_signin/widgets/ButtonPhysicalWeight.dart';
import 'package:flutter_web_signin/widgets/action_button_save.dart';
import 'package:flutter_web_signin/widgets/action_button_setting.dart';
import 'package:flutter_web_signin/widgets/app_bar_list.dart';
import 'package:flutter_web_signin/widgets/drawer.dart';
import 'package:flutter_web_signin/widgets/home_action_button.dart';
import 'package:flutter_web_signin/widgets/home_checkbox.dart';
import 'package:flutter_web_signin/widgets/leading.dart';
import 'package:flutter_web_signin/widgets/snack_bar_home_screen.dart';
import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {

  List<PrintingItem> listPrintingItem = new List<PrintingItem>();
 
  HomePage({ this.listPrintingItem });
  

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  String _name;
  int _printing = 0;
  int _height = 0, _iheight = 0;
  int _width = 0, _iwidth = 0;
  int _factor = 1;
  int _grammar = 0;
  List<PrintingItem> listPrintingItem;
  TextEditingController _controllerFactor = TextEditingController.fromValue(TextEditingValue(text: '1'));


  @override
  void initState(){
    listPrintingItem = widget.listPrintingItem;
    checkEmail();

    super.initState();

  }

checkEmail() async{
      if(EMAIL == '') {
      FirebaseUser user =  await FirebaseAuth.instance.currentUser();
      EMAIL = user.email;
    }
  }



  ColorScale colorScale = new ColorScale();

  final formKey = new GlobalKey<FormState>();

    final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    double globalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
          elevation: 0,
          titleSpacing: 0.0,
          backgroundColor: Color(0x55aaaaaa),
          leading:  Container(
            child: Leading(globalKey: _scaffoldstate)
            ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[ Container(
                decoration: BoxDecoration(
              image: DecorationImage(
               image: AssetImage('assets/logo_ecostream-techno.jpg'),
             fit: BoxFit.cover,
             ),),
            height: 56,
            width: 110,
              ) ]
              ),
          ),
      drawer: Container(
        color: Colors.black,
        child: MyDrawer()
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundDecoration,
        child: Container(
          width: 1120.0,
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: 540.0,
                  height: 530.0,
                  decoration: kBoxDecorationHomeForm,
                  child:
                  Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[     
                    Container(
                      width: 420.0,
                      child: 
                    Column(children: <Widget>[
                      Text(
                    'Добавьте Позиции',
                    style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'OpenSans',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Row( children: <Widget>[ 
                        Text('Название:      ', style: textFormStyle,),
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          width: 280.0,
                          child: TextFormField(
                            validator: (value) =>
                                value.isEmpty ? 'Заполните поле' : null,
                            style: textFormStyle,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 22.0)
                              ),
                            onChanged: (text) {
                              setState(() {
                                _name = text;
                              });
                            },
                          ),
                        ),]
                      ),
                      Row(children: <Widget>[
                        Text('Высота мм:    ', style: textFormStyle,),
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          width: 85.0,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 22.0)
                              ),
                              validator: (value) =>
                                  !checkHeight(value) ? 'Некоректное значение' : null,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _height = int.parse(text);
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 6.0, left: 15.0, right: 15.0),
                            child: Icon(Icons.add, color: Colors.grey[400], size: 15,),),
                          Text('Вылеты:  ', style: textFormStyle,),
                           Container(
                           padding: EdgeInsets.only(bottom: 20),
                            width: 20.0,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 22.0)
                              ),
                              validator: (value) =>
                                  !checkIndent(value) ? 'Некоректное значение' : null,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _iheight = int.parse(text);
                                });
                              },
                            ),
                          ),
                      ],),
                      Row(
                        children: <Widget>[
                        Text('Ширина мм:   ', style: textFormStyle,),

                          Container(
                           margin: EdgeInsets.only(bottom: 20),
                            width: 85.0,
                            child: TextFormField(
                              validator: (value) =>
                                  !checkWidth(value) ? 'Некоректное значение' : null,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20.0)
                              ),
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _width = int.parse(text);
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 6.0, left: 15.0, right: 15.0),
                            child: Icon(Icons.add, color: Colors.grey[400], size: 15,),),
                          Text('Вылеты:  ', style: textFormStyle,),
                              Container(
                            width: 20.0,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              validator: (value) =>
                                  !checkIndent(value) ? 'Некоректное значение' : null,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20.0)
                              ),
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _iwidth = int.parse(text);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                        Row(children: <Widget>[
                          Text('Вес г/м2:        ', style: textFormStyle,),
                          Container(
                           margin: EdgeInsets.only(bottom: 20),
                            width: 85.0,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top:20.0)
                              ),
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _grammar = int.parse(text);
                                });
                              },
                            ),
                          ),
                        ],),
                      Row(
                        children: <Widget>[
                          Text('Тираж:            ', style: textFormStyle,),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            width: 85.0,
                            child: TextFormField(
                              validator: (value) =>
                                 checkPrinting(value) ? 'Некоректное значение' : null,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20.0)
                              ),
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _printing = int.parse(text);
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 6.0, left: 15.0, right: 15.0),
                            child: Icon(Icons.close, color: Colors.grey[400], size: 15,),),
                          Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            width: 20.0,
                            child: TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? null : null,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              controller: _controllerFactor,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20.0)
                              ),
                              style: textFormStyle,
                              onChanged: (text) {
                                setState(() {
                                  _factor = int.parse(text);
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 280.0),
                            width: 130,
                            child: RaisedButton(
                                elevation: 2.0,
                                onPressed: () {
                                  if (checkFields()) {
                                    RandomColor _randomColor = RandomColor();
                                    listPrintingItem.add(PrintingItem(
                                        _name, _printing, _factor, _height, _iheight, 
                                          _width, _iwidth, _grammar, listPrintingItem.length+1,
                                             _randomColor.randomColor().value));

                                    setState(() {
                                      MySnackBarScreen( _scaffoldstate, _name  + '   Добавлено!', Colors.green );

                                    });
                                  }
                                },
                                padding: EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                  size: 30,
                                )),
                          )
                    ],
                  ),
                ),
                    ],),)

                ],),),

                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 530.0,
                    height: 530.0,
                    decoration: kBoxDecorationHomeForm,
                    child: _buildPrintingList()),
                )
              ],
            ),
              HomeCheckBox()  // Переключатель Автоматической Подборки Настроек
            ] 
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HomeActionButtonSetting(),
          SizedBox(height: 8.0,),
          ButtonPhysicalWeight(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonA3(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonA2(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonA1(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonB3(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonB2(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonB1(listPrintingItem: listPrintingItem,),
          SizedBox(height: 8.0,),
          HomeActionButtonSave(listPrintingItem: listPrintingItem, scaffoldstate: _scaffoldstate,),
          SizedBox(height: 8.0,),
          HomeActionButtonAll(listPrintingItem: listPrintingItem,),
          
         
      ],)
       
    );
  }
  Widget _buildPrintingList() {
  TextEditingController _height, _iheight, _width, _iwidth, _grammar, _printing, _factor, _name ;
  double _textFieldHeight = 32;
  double _textFieldBottom = 18;
  double _textFieldFontSize = 14;

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listPrintingItem.length,
        itemBuilder: (context, index) {
          
          _height = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].height.toString()) );
          _iheight = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].iheight.toString()) );
          _width = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].width.toString()) );
          _iwidth = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].iwidth.toString()) );
          _grammar = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].grammar.toString()) );
          _printing = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].printing.toString()) );
          _factor = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].factor.toString()) );
          _name = TextEditingController.fromValue( TextEditingValue(text: listPrintingItem[index].name));

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2.0,
              child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 360.0,
                          child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                              child: Row(children: <Widget>[
                            Icon(Icons.bookmark, color: listPrintingItem[index].color,),
                            Text(
                            '(' + listPrintingItem[index].index.toString() + ') ' 
                        ,     textAlign: TextAlign.center,
                             style: TextStyle(color: Colors.black87, fontStyle: FontStyle.italic, ),
                             ),
                            Container(
                          width: 200.0,
                          height: _textFieldHeight,
                              child: TextField(
                                style: TextStyle(fontSize: _textFieldFontSize),
                                controller: _name,
                                decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                                  border: InputBorder.none
                                ),
                                onChanged: (text) {
                                  listPrintingItem[index].name = text;
                              },
                          ),
                            ),
                          ],),
                          ),
                        ),
                     

                    Container(
                      width: 23.0,
                      height: 23.0,
                      child: RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () => setState(() {
                                     listPrintingItem.removeAt(index);
                                        refreshListIndex();
                                  }),
                                    padding: EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.black87,
                                      size: 17.0,
                                    )),
                    ),

                    ],)
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: 
                    Column(children: <Widget>[
                      Row(children: <Widget>[
                        Text( 'Высота:  '),
                        Container(
                          width: 35,
                          height: _textFieldHeight,
                          child: TextField(
                            style: TextStyle(fontSize: _textFieldFontSize),
                            controller: _height,
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                               border: InputBorder.none
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].height = int.parse(text);
                            },
                          ),
                        ),

                       Text('  +  '),
                        Container(
                          width: 20,
                          height: _textFieldHeight,
                          child: TextField(
                            controller: _iheight,
                            style: TextStyle(fontSize: _textFieldFontSize),
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                               border: InputBorder.none,
                               contentPadding: EdgeInsets.only(bottom: _textFieldBottom)
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].iheight = int.parse(text);
                            },
                          ),
                        ),

                        Text('   Ширина:  '),
                        Container(
                          width: 35,
                          height: _textFieldHeight,
                          child: TextField(
                            controller: _width,
                            style: TextStyle(fontSize: _textFieldFontSize),
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                               border: InputBorder.none
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].width = int.parse(text);
                            },
                          ),
                        ),

                        Text('  +  '),
                        Container(
                          width: 20,
                          height: _textFieldHeight,
                          child: TextField(
                            controller: _iwidth,
                            style: TextStyle(fontSize: _textFieldFontSize),
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                               border: InputBorder.none
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].iwidth = int.parse(text);
                            },
                          ),
                        ),
                        SizedBox(width: 30.0,),
                         Container(
                          width: 27,
                          height: _textFieldHeight,
                          child: TextField(
                            controller: _grammar,
                            style: TextStyle(fontSize: _textFieldFontSize),
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                               border: InputBorder.none
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].grammar = int.parse(text);
                            },
                          ),
                        ),
                        Text(' гр/м2'),
                      ],),
                      Row(children: <Widget>[
                        Text('Тираж:  '),
                        Container(
                          height: _textFieldHeight,
                          width: 60,
                          child: TextField(
                            controller: _printing,
                            style: TextStyle(fontSize: _textFieldFontSize),
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                               border: InputBorder.none
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].printing = int.parse(text);
                            },
                          ),
                        ),
                        Text('  x '),
                         Container(
                           height: _textFieldHeight,
                          width: 20,
                          child: TextField(
                            controller: _factor,
                            style: TextStyle(fontSize: _textFieldFontSize),
                            inputFormatters: <TextInputFormatter>[ WhitelistingTextInputFormatter.digitsOnly ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: _textFieldBottom),
                              border: InputBorder.none
                            ),
                            onChanged: (text) {
                               listPrintingItem[index].factor = int.parse(text);
                            },
                          ),
                        ),
                      ],)
                    ],),
                  //   Text(
                  //       'Высота:  ' +
                  //       listPrintingItem[index].height.toString() + ' +' +
                  //       listPrintingItem[index].iheight.toString() + 

                  //       '\t  Ширина:  ' +
                  //       listPrintingItem[index].width.toString() + ' +' +
                  //       listPrintingItem[index].iwidth.toString()  + '\t   ' +
                  //       listPrintingItem[index].grammar.toString() +  'г/м2' +
                  //       '\n'

                  //       'Тираж:  ' +
                  //       listPrintingItem[index].printing.toString() + '  x' +
                  //       listPrintingItem[index].factor.toString()

                  //       , style: TextStyle(height: 1.6, fontWeight: FontWeight.w600),),
                  // ),
                  ),
            ),
           ) );
        });
  }

  refreshListIndex(){
    for(int i=0; i<listPrintingItem.length; i++){
      listPrintingItem[i].index = i+1;
    }
  }
}
