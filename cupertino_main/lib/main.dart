import 'package:flutter/cupertino.dart';
import 'package:cupertino_main/animalItem.dart';
import 'package:cupertino_main/iosSub/cupertinoFirstPage.dart';
import 'package:cupertino_main/iosSub/cupertinoSecondPage.dart';

void main() => runApp(CupertinoMain());

class CupertinoMain extends StatefulWidget {
  @override
  State<CupertinoMain> createState() => _CupertinoMainState();
}

class _CupertinoMainState extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
          tabBar: tabBar!,
          tabBuilder: (context, value) {
            if (value == 0) {
              return CupertinoFirstPage(
                animalList: animalList,
              );
            } else {
              return CupertinoSecondPage(
                  animalList: animalList,
              );
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ]);
    animalList.add(Animal(animalName: 'bee', kind: '곤충', imagePath: 'repo/images/bee.png')); //리스트에 동물의 정보를 입력해 객체 생성하고 동물 목록 list에 추가
    animalList.add(Animal(animalName: '고양이', kind: '포유류', imagePath: 'repo/images/cat.png'));
    animalList.add(Animal(animalName: '젖소', kind: '포유류', imagePath: 'repo/images/cow.png'));
    animalList.add(Animal(animalName: '강아지', kind: '포유류', imagePath: 'repo/images/dog.png'));
    animalList.add(Animal(animalName: '여우', kind: '포유류', imagePath: 'repo/images/fox.png'));
    animalList.add(Animal(animalName: '원숭이', kind: '영장류', imagePath: 'repo/images/monkey.png'));
    animalList.add(Animal(animalName: '돼지', kind: '포유류', imagePath: 'repo/images/pig.png'));
    animalList.add(Animal(animalName: '늑대', kind: '포유류', imagePath: 'repo/images/wolf.png'));
  }
}
