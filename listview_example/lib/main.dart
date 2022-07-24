import 'package:flutter/material.dart';
import 'package:listview_example/sub/firstPage.dart';
import 'package:listview_example/sub/secondPage.dart';
import 'package:listview_example/animalItem.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{ //정적으로 상태를 받는 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'list_view example',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{ //동적으로 상태를 받는 위젯
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin { //상태를 변화 동작 구현
  TabController? controller;
  List<Animal> animalList = new List.empty(growable:true); //동물 리스트 목록 선언
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('listview example'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(list: animalList),
          SecondApp(list: animalList)
        ], controller: controller,
      ),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one,color: Colors.blue),),
        Tab(icon: Icon(Icons.looks_two,color: Colors.blue),)
      ], controller: controller,)
    );
  }
  @override
  void initState(){
    super.initState();
    controller=TabController(length: 2, vsync: this); //legnth: 몇개의 탭을 만들지 지정. vsync: 탭이 이동했을 때 콜백 함수를 어디에 처리할 지 지정.

    animalList.add(Animal(animalName:'bee',kind:'곤충',imagePath:'repo/images/bee.png')); //리스트에 동물의 정보를 입력해 객체 생성하고 동물 목록 list에 추가
    animalList.add(Animal(animalName:'고양이',kind:'포유류',imagePath:'repo/images/cat.png'));
    animalList.add(Animal(animalName:'젖소',kind:'포유류',imagePath:'repo/images/cow.png'));
    animalList.add(Animal(animalName:'강아지',kind:'포유류',imagePath:'repo/images/dog.png'));
    animalList.add(Animal(animalName:'여우',kind:'포유류',imagePath:'repo/images/fox.png'));
    animalList.add(Animal(animalName:'원숭이',kind:'영장류',imagePath:'repo/images/monkey.png'));
    animalList.add(Animal(animalName:'돼지',kind:'포유류',imagePath:'repo/images/pig.png'));
    animalList.add(Animal(animalName:'늑대',kind:'포유류',imagePath:'repo/images/wolf.png'));
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }
}
