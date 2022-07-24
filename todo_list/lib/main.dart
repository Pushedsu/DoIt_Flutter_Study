import 'package:flutter/material.dart';
import 'package:todo_list/SecondDetail.dart';
import 'package:todo_list/subDetail.dart';
import 'package:todo_list/thirdDetail.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      //home: FirstPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => SubDetail(),
        '/second':(context) => SecondDetail(),
        '/third':(context) => ThirdDetail()},
    );
  }
}

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub page Wait'),
      ),
      body: Container(
        child: Center(
          child: Text('first page'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).pop;
            },
            child: Text('Back'),
          ),
        ),
      ),
    );
  }
}
