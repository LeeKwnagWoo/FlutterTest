import 'package:flutter/material.dart';


abstract class ListItem {}

class ListWidget extends StatelessWidget {
  final List<String> items = <String>['1', '2', '3'];

  @override


  Widget build(BuildContext context) {
    return Scaffold(
        // body: ListView(
        //   padding: const EdgeInsets.all(30),
        //   children: <Widget>[
        //     Text('1'),
        //     Text('1'),
        //     Text('1'),
        //   ],
        // ),
      // body: ListView(
      //   padding: const EdgeInsets.all(30),
      //   children: <Widget>[
      //     Container(
      //       decoration: BoxDecoration(
      //         color: Colors.red
      //       ),
      //       child: ListTile(
      //         leading : Icon(Icons.home),
      //         title: Text('1'),
      //       )
      //     ),
      //     Container(
      //         decoration: BoxDecoration(
      //             color: Colors.red
      //         ),
      //         child: ListTile(
      //           leading : Icon(Icons.home),
      //           title: Text('1'),
      //         )
      //     ),
      //     Container(
      //         decoration: BoxDecoration(
      //             color: Colors.red
      //         ),
      //         child: ListTile(
      //           leading : Icon(Icons.home),
      //           title: Text('1'),
      //         )
      //     ),
      //   ],
      // ),

      //ListView Separated
      body: ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemBuilder: (context, index) =>Padding(
          padding:EdgeInsets.all(8.0),
            child:Center(
                child:
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading : Icon(Icons.home),
                            title: Text(items[index]),
                          ),
                          ElevatedButton(onPressed: ()
                          {
                            Navigator.pop(
                              context,
                            );
                          },
                              child: Text("이전 화면으로 돌아가기")
                          ),
                        ],

                      ),
                    ),
                  ),
              ),
        ),
      );
  }
}