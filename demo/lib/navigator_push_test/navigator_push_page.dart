import 'package:flutter/material.dart';
import 'package:flutter_util/util/navigator/route_page_mixin.dart';

class NavigatorPushPage extends StatefulWidget with RoutePageMixin {
  NavigatorPushPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPushPage> createState() => _NavigatorPushPageState();
}

class _NavigatorPushPageState extends State<NavigatorPushPage> {

  late String title;
  late String name;
  late int age;
  late int score;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.argument?["title"]??"默认title";
    name = widget.argument?["name"]??"默认name";
    age = widget.argument?["age"]??0;
    score = widget.argument?["score"]??0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView(
        children: [
          item("name: ", name),
          item("age: ", age.toString()),
          item("score: ", score.toString()),
          item("score: ", widget.statArgument?.toString()??""),
        ],
      ),
    );
  }

  Widget item(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}
