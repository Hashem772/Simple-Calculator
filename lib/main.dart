import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

//
class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
//  String text = "0";
//  double numOne =0 ;
//  double numTow = 0 ;
//  String result =  "";
//  String finalResult = "";
//  String opr = "";
//  String prevopr= "";
//  String label = "";
//  String showeres = "";
//  int one ;
  int? one;
  int? two;
  String textOne='';
  String textTwo='';
  int? res;
  String? opr;
  int? finalRes;
  String label = "";
  String hint = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hashem's Calculator" , style: TextStyle(fontStyle: FontStyle.italic)),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 40,),
            Text(
              hint,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                backgroundColor: Colors.grey,
              ),
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 40,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttons("C", Colors.redAccent, "small", 0),
                buttons("Del", Color(0xffa5a5a5), "small", 0),
                buttons("%", Color(0xffa5a5a5), "small", 0),
                buttons("/", Color(0xffff9800), "small", 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttons("7", Color(0xff323232), "small", 1),
                buttons("8", Color(0xff323232), "small", 1),
                buttons("9", Color(0xff323232), "small", 1),
                buttons("X", Color(0xffff9800), "small", 0)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttons("4", Color(0xff323232), "small", 1),
                buttons("5", Color(0xff323232), "small", 1),
                buttons("6", Color(0xff323232), "small", 1),
                buttons("-", Color(0xffff9800), "small", 0)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttons("1", Color(0xff323232), "small", 1),
                buttons("2", Color(0xff323232), "small", 1),
                buttons("3", Color(0xff323232), "small", 1),
                buttons("+", Color(0xffff9800), "small", 0)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttons("0", Color(0xff323232), "big", 1),
                buttons(".", Color(0xff323232), "small", 1),
                buttons("=", Color(0xffff9800), "small", 0)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buttons(String btnText, Color color, String size, int num) {
    Container? continer;
    if (num == 1 ) {
      //الارقااام
      continer = size == 'big' ? Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              label += btnText;
              if (opr == null) {
                textOne += btnText;
              }
              else {
                textTwo += btnText;
                hint = calc(opr!)!;
//                res = int.parse(hint);
              }
            });
          },
          child: Text(btnText, style: TextStyle(fontSize: 30)),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color),shape:MaterialStateProperty.all( StadiumBorder(),),padding: MaterialStateProperty.all(EdgeInsets.only(left: 82, top: 30, right: 81, bottom: 20),)),
        ),
      ) : Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              label += btnText;
              if (opr == null) {
                textOne += btnText;
              }
              else {
                textTwo += btnText;
                hint = calc(opr!)!;
//                res = int.parse(hint);
              }
            });
          },
          child: Text(btnText, style: TextStyle(fontSize: 20)),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color),shape:MaterialStateProperty.all( CircleBorder(),),padding: MaterialStateProperty.all(EdgeInsets.all(20),)),

        ),
      );
    } else if (num == 0 && size == "small") {
      // العمليات
      continer = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if(textOne.isEmpty ){
                label ="";
              }else{
                operation(btnText);

              }
            });

          },
          child: Text(btnText, style: TextStyle(fontSize: 20)),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color),shape:MaterialStateProperty.all( CircleBorder(),),padding: MaterialStateProperty.all(EdgeInsets.all(20),)),

        ),
      );
    }
    return continer!;
  }

  void operation(String o){
    if('-+/X'.contains(o)){
      add(o);
    }
    else if(o == 'C'){
      clear();
    }else if(o == '=' && textTwo.isNotEmpty){

      setState(() {
        label = hint;
        finalRes = int.parse(label);
        hint ="";
        textOne =finalRes.toString();
        textTwo = "";
        opr=null;
      });

    }else if(o == 'Del'){
      setState(() {
        label =label.substring(0,label.length-1);


        if(textTwo.isNotEmpty) {
          textTwo = textTwo.substring(0, textTwo.length - 1);

        }
        else if(opr != null){
          opr = null;
        }

        else if(textOne.isNotEmpty) {
          textOne = textOne.substring(0, textOne.length - 1);

        }

        if(textOne.isNotEmpty && textTwo.isNotEmpty)
          hint = calc(opr!)!;
        else
          hint = '';

      });
    }
    if(o =='%'){

      if(textOne.isNotEmpty){
        label+=o;
        textOne = (int.parse(textOne) * (1/100)).round().toString();
      } else if(textTwo.isNotEmpty){
        label+=o;
        textTwo = (int.parse(textTwo) * (1/100)).round().toString();
      }
    }
  }

  String? add(String op) {

    opr = op;
    if(textOne.isNotEmpty){

      setState(() {
//       one = int.parse(textOne);

        if(label.endsWith('+') || label.endsWith('-') ||
            label.endsWith('X') || label.endsWith('/'))
        {
          label = label.replaceFirst(label[label.length - 1], opr!);
        }
        else{
          label += opr!;

        }

      });

    }
    if(textTwo.isNotEmpty){
      setState(() {
        label = hint;
        label+=opr!;
        textOne = hint;
        hint = '';
        textTwo = '';
      });
    }

  }

  String? calc(String op ) {
    switch(op){
      case '+':
        return (int.parse(textOne ) + int.parse(textTwo)).toString();
        break;

      case '-':
        return (int.parse(textOne ) - int.parse(textTwo)).toString();
        break;
      case '/':
        return (int.parse(textOne ) / int.parse(textTwo)).floor().toString();
        break;
      case 'X':
        return (int.parse(textOne ) * int.parse(textTwo)).toString();
        break;
    }
  }


  String? mul() {}

  String? div() {}

  void clear() {
    setState(() {
      label ="";
      hint ="";
      textOne ="";
      textTwo = "";
      opr=null;
    });

  }

}




