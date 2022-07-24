import 'package:flutter/material.dart';
import 'package:tabbar_example/sub/firstPage.dart';
import 'package:tabbar_example/sub/secondPage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tabbar example',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Example'),
      ),
      body: TabBarView(
        children: <Widget>[FirstApp(),SecondtApp()],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one,color: Colors.blue),),
        Tab(icon: Icon(Icons.looks_one,color: Colors.blue),)
      ], controller: controller,),
    );
  }
  @override
  void initState(){
    super.initState();
    controller=TabController(length: 2, vsync: this); //legnth: 몇개의 탭을 만들지 지정. vsync: 탭이 이동했을 때 콜백 함수를 어디에 처리할 지 지정.
  }
  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }
}

