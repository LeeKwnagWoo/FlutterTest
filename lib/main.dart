

import 'package:flutter/material.dart';
import 'ListWidget.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum MenuType { first, second, third }
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<bool> _selections1 = List.generate(3, (index) => false);
  // MenuType _selection;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: _incrementCounter, child: Text("이것은 텍스트 버튼입니다.")),

            TextButton.icon(onPressed: _incrementCounter,
                icon: Icon(Icons.star),
                label: Text("아이콘 텍스트 버튼 입니다.")
            ),

            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () { },
              child: Text('TextButton'),
            ),

            ElevatedButton(onPressed: _incrementCounter,
                child: Text("엘리베이티드 버튼")),
            ElevatedButton.icon(
              icon: Icon(Icons.home),
              label: Text('ElevatedButton'),
              onPressed: _incrementCounter,
            ),
            OutlinedButton(onPressed: _incrementCounter,
                child: Text("외곽선 버튼")
            ),
            OutlinedButton.icon(onPressed: _incrementCounter, icon: Icon(Icons.home), label: Text("제목")),

            Text("Icon Button"),
            IconButton(onPressed: _incrementCounter, icon: Icon(Icons.star)),

            Text(
                ""
            ),

            Text(
              "토글버튼"
            ),
            ToggleButtons(
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Text("Mobile"),
              ],
              onPressed: (int index) {
                setState(() {
                  _selections1[index] = !_selections1[index];
                });
              },
              isSelected: _selections1,
            ),
            Text(
                ""
            ),
            Container(
              width : 1000,
              child : Text("left", style:TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.start ),
            ),
            Container(
              width : 1000,
              child : Text('Color',style: TextStyle(color: Colors.red), textAlign: TextAlign.end),
            ),
            Container(
              width : 1000,
              child : Text("글자 크기", style: TextStyle(fontSize: 20), textAlign: TextAlign.left,),
            ),

            Container(
              width : 1000,
              child : Text('Font Family',style: TextStyle(fontSize: 10,fontFamily: 'Signatra'), textAlign: TextAlign.right),
            ),
            Container(
              width : 1000,
              child : Text('가운데 정렬',style: TextStyle(fontSize: 30,fontFamily: 'Signatra'), textAlign: TextAlign.center),
            ),
            ElevatedButton(onPressed: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListWidget()),
              );
            },
                child: Text("다음 화면으로 넘어가기")
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
