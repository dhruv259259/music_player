import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player/control.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


class second extends StatelessWidget {
  int index;
  // List<SongModel> songlist;


  second(this.index);
  final player = AudioPlayer();
  control1 c1 = Get.put(control1());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1D2671), Color(0xFFC33764)]),),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 50,),
          SizedBox(height: 250,width: 250,child:Lottie.asset(fit: BoxFit.fill,"image/107575-ai-music-animation.json") ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: ListTile(
                title:Obx(() => MarqueeText(style:TextStyle(color: Colors.white,fontSize: 20),speed: 15,alwaysScroll: true,text: TextSpan(text: "${c1.songlist[c1.con.value].title}"),))),
          ),
          Row(children: [
            Expanded(child: Text("${c1.currentduretion.value}")),
            Expanded(flex: 6,
              child: Obx(() =>Slider(autofocus: true,thumbColor: Colors.white,activeColor: Colors.yellow,inactiveColor: Colors.red,min: 0,max:c1.totalduretion.value,value:c1.currentduretion.value, onChanged: (value) {
              },),),
            ),
            Expanded(child: Text(c1.printDuration(
                Duration(milliseconds: c1.songlist[index].duration!)),style: TextStyle(color: Colors.white)),)
          ],),
          SizedBox(width: double.infinity,height: 50,child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
            IconButton(onPressed: () async{
              c1.play(index);
              index++;
              // c1.pause(index);
              // final duration = await player.setFilePath(c.songlist[widget.index].data);
              print("index13 =${index}");
            }, icon:Icon(Icons.skip_previous,color: Colors.white,size: 40,)),
            Obx(() => IconButton(onPressed: () async {
              c1.list[c1.con.value]=!c1.list[c1.con.value];
              if (c1.list[c1.con.value]) {
                c1.play(index);
              } else {
                c1.pause(index);
              }
            }, icon:(c1.list[c1.con.value]==true)? Icon(Icons.pause,color: Colors.white,size: 40,):Icon(Icons.play_arrow,color: Colors.white,size: 40,),),),
            IconButton(onPressed: () async{
              c1.play(index);
              index--;
              //  c1.pause(index);
            }, icon: Icon(Icons.skip_next,color: Colors.white,size: 40,))
          ]))
        ]),
      ),
    );
  }
}


