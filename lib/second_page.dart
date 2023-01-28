import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/control.dart';


class second extends StatelessWidget {
//int index=1;

  control c = Get.put(control());
  final player = AudioPlayer();
  int index;

  second(this.index);

  // int index;
  // second(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${c.songlist[index].title}",
          style: TextStyle(),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(
            height: 70,
            width: double.infinity,
            child: ListTile(
              title: Text("${c.songlist[index].title}"),
            )),
        SizedBox(width: double.infinity,height: 50,child: Obx(() => Row(children: [
          IconButton(onPressed: () {
            index++;
          }, icon: Icon(Icons.skip_next)),
          IconButton(onPressed: () async {
            final duration = await player.setFilePath(c.songlist[index].data);
            c.list.value[index]=!c.list.value[index];
            if(c.list.value[index]==false)
            {
              await player.play();
            }
            else
            {
              await player.pause();
            }
          }, icon:(c.list.value[index]==true)? Icon(Icons.pause): Icon(Icons.play_arrow),),
          IconButton(onPressed: () {
            index--;
          }, icon: Icon(Icons.skip_previous))
        ])),)
      ]),
    );
  }
}