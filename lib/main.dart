import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/first_page.dart';

void main()
{
  runApp(MaterialApp(home: first(),debugShowCheckedModeBanner: false,));
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
