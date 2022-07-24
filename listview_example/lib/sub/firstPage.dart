import 'package:flutter/material.dart';
import 'package:listview_example/animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal>? list; // Animal 객체 list 선언
  FirstApp({Key? key, this.list}) : super(key: key); // final로 받으면 오류 발생 list를 매개변수로 받는 생성자 추가
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(itemBuilder: (context, position) { //context -> BuildContext 위젯의 위치를 알려줌. position -> 아이템의 순번을 알려줌.
            return GestureDetector(
              child: Card(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      list![position].imagePath!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Text(list![position].animalName!)
                  ],
                ),
              ),
              onTap: () {
                AlertDialog dialog = AlertDialog( //dialog 객체 생성 팝업 텍스트와 font 사이즈 지정.
                  content: Text(
                    '이 동물은${list![position].kind}입니다.',
                    style: TextStyle(fontSize: 30.0),
                  ),
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              },
            );
          }, itemCount: list!.length), //아이템의 개수만큼 스크롤 제한
        ),
      ),
    );
  }
}