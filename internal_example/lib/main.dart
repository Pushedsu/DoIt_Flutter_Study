import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'internal_example',
      home: _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget{
  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  int _counter=0;

  void _setData(int value) async{ // 데이터를 저장하는 함수 _setData 만듬
    var key = 'count'; //데이터는 키-값 쌍으로 구성되어야 하고 key값은 고유한 값이므로 count 키 변수 선언 버튼
    SharedPreferences pref = await SharedPreferences.getInstance(); //SharedPreferences클래스 인스턴스 생성
    pref.setInt(key,value); //setInt() 호출 인자값으로 key, value 입력
  }

  void _loadData() async{ //데이터를 불러오는 함수 _
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      var value = pref.getInt(key);
      if(value==null){
        _counter=0;
      } else {
        _counter=value;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('$_counter'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _loadData();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _setData(_counter);
    });
  }
}
