import 'package:flutter/material.dart';
import 'package:flutter_web_signin/buttons/A1ButtonSetting.dart';
import 'package:flutter_web_signin/buttons/ButtonHomeScreen.dart';
import 'package:flutter_web_signin/canvas/canvas_class.dart';
import 'package:flutter_web_signin/models/printig_item.dart';
import 'package:flutter_web_signin/utilities/constants.dart';
import 'package:flutter_web_signin/widgets/app_bar_list.dart';
import 'package:flutter_web_signin/widgets/loadingWidget.dart';


class A1Screen extends StatefulWidget {
  
  A1Screen({Key key, this.listPrintingItem});
  final List<PrintingItem> listPrintingItem;

  @override
  _A1ScreenState createState() => _A1ScreenState();
}

class _A1ScreenState extends State<A1Screen> {
  ColorScale _colorScale;
  MyCanvas _myCanvas;
  bool _canvasChecked = false;
  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _colorScale = new ColorScale();
    super.initState();
  }


Future  _initCanvas() async{ 
  int milliseconds;
  settingsCanvas.AUTO_SETTINGS ? milliseconds = 1200 : milliseconds = 0;
  return Future.delayed(Duration(milliseconds: milliseconds),(){
    _myCanvas = new MyCanvas(widget.listPrintingItem, 
           (A1_WIDTH - (INDENT_LEFT_RIGHT*2)), (A1_HEIGHT - (INDENT_BOTTOM+INDENT_TOP)));
    _myCanvas.calculation(settingsCanvas.AUTO_SETTINGS);
  });

}

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
 
    _initCanvas().then((value) 
    { 
      setState((){
        _canvasChecked = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double globalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
     key: _scaffoldstate,
      body: 
      !_canvasChecked ? 
      loadingWidget :
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundDecorationHome,
        child: Container(child: 
          Column(
              mainAxisAlignment: MainAxisAlignment.center,            
                      children: <Widget>[ Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                _buildA1Widget(),
                Column(children: <Widget>[
                  _buildListPrintingGetText(),
                  _buildCanvasResultPrinting()
                ]),

            ],),]
          )
        ,),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,        
        children: <Widget>[
        A1ActionButtonSetting(listPrintingItem: widget.listPrintingItem),
        SizedBox(height: 8.0,),
        ActionButtonHomeScreen(listPrintingItem: widget.listPrintingItem)

      ])
    );
  }

  Widget _buildListPrintingGetText(){
    return Container(
                  width: 550.0,
                  height: 320.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _myCanvas.listPrintingItem.length,
                  itemBuilder: (context, index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(Icons.bookmark, color: _myCanvas.listPrintingItem[index].color,),
                      Expanded(child: _myCanvas.listPrintingItem[index].getText())
                         
                    ],);
                  }),);
  }

Widget _buildCanvasResultPrinting(){
  return  Container(
                margin: EdgeInsets.only(top:30.0),
                width: 550.0,
                height: 320.0,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _myCanvas.listResultPrinting.length,
                  itemBuilder: (context, index){
                    return _myCanvas.listResultPrinting[index];
                  })
            );
}
Widget _printingText = Text(  'Недостаточно места выберите больший формат', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red[600]),);

  Widget _buildA1Widget(){

    if(_myCanvas.resultPrinting.toString() != 'Infinity'){
       _printingText = Text('Тираж ' + _myCanvas.resultPrinting.toStringAsFixed(1),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]));
       }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: A1_WIDTH,
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Text('A1 ' + '(' + (A1_WIDTH-INDENT_BOTTOM*2).toString() + ' x ' +  (A1_HEIGHT-INDENT_BOTTOM*2).toString() + ')',
            style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black54
            )),
        ],),
        Material(
          elevation: 5,
          child: Container(
            height: A1_HEIGHT ,
            width: A1_WIDTH ,
            color: Colors.white,
            child: Stack(children: <Widget>[
              Positioned(
                bottom: INDENT_BOTTOM,
                left: INDENT_LEFT_RIGHT,
                right: INDENT_LEFT_RIGHT,
                top: INDENT_TOP,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details){
                    int dx = details.localPosition.dx.floor();
                    int dy = ((A1_HEIGHT -20) - details.localPosition.dy) ~/1;
                      _myCanvas.listPositioned.removeWhere((element) {
                        if(element.left <= dx && element.bottom <= dy && element.right >= dx && element.top >= dy){
                          _myCanvas.listPrintingItem[element.index-1].count--;
                          _myCanvas.listResultPrinting .clear();
                          _myCanvas.calculatingPrinting();
                          return true;
                        }
                        return false;
                      } );
                      setState(() {
                      });
                     },                  
                    child: Stack(
                    children: _myCanvas.getlistPositioned,
                  ),
                ),
              ),

            ],)
          ),),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
            Padding(
            padding: EdgeInsets.all(20.0),
            child: _printingText
            )],)
      ],),
    );
  }
  
}