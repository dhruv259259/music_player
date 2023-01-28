import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/second_page.dart';

import 'control.dart';

class first extends StatelessWidget {
  control c = Get.put(control());
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context){
    c.permition();
    c.getsongs();
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(title: Obx(() =>(c.search.value==true)?TextField(style: TextStyle(color: Colors.white),onChanged: (value) {

            // c.sear.value=c.songlist.where((element) => element.toString().contains(value)).toList();
            //   print("l=${c.sear.value}");

          },decoration: InputDecoration(hintText: "Search your Music..",hintStyle: TextStyle(color: Colors.white)),):Text(
            "Music Player", style: TextStyle(color: Colors.white),),),
            actions: [
              Obx(() =>(c.search.value==true)? IconButton(
                  onPressed: () {
                    c.search.value=!c.search.value;
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  )):IconButton(onPressed: () {
                c.search.value=!c.search.value;
                //  c.songlist.clear();
              }, icon:Icon(Icons.search,color: Colors.white,)))
            ],
            backgroundColor: Color(0xFF1D2671),
            bottom: TabBar(
                labelColor: Colors.amber,
                unselectedLabelColor: Colors.white,
                automaticIndicatorColorAdjustment: true,
                indicatorColor: Colors.amber,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text("SONGS"),
                  ),
                  Tab(
                    child: Text("PLAYLIST"),
                  ),
                  Tab(
                    child: Text("FOLDERS"),
                  ),
                  Tab(
                    child: Text("ALBUMS"),
                  ),
                  Tab(
                    child: Text("ARTISTS"),
                  ),
                  Tab(
                    child: Text("GENRES"),
                  ),
                ]),
          ),
          drawer: Drawer(child: Container(
            height: double.infinity, width: double.infinity,
            decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1D2671), Color(0xFFC33764)])),
            child: Column(children: [
              DrawerHeader(child: SizedBox(height: 250,width: 250,child: CircleAvatar(backgroundColor: Colors.purple,child: Icon(Icons.music_note_sharp,color: Colors.white,size: 130,),))),
              ListTile(leading: Icon(Icons.my_library_music_sharp,color: Colors.grey,),title: Text("Library",style: TextStyle(color: Colors.white),),),
              ListTile(leading: Icon(Icons.equalizer,color: Colors.grey,),title: Text("Equalizer",style: TextStyle(color: Colors.white),),),
              ListTile(leading: Icon(Icons.timer_rounded,color: Colors.grey,),title: Text("Sleep Timer",style: TextStyle(color: Colors.white),),),
              ListTile(leading: Icon(Icons.highlight_remove,color: Colors.grey,),title: Text("Remove Ads",style: TextStyle(color: Colors.white),),),
              ListTile(leading: Icon(Icons.music_note_rounded,color: Colors.grey,),title: Text("Free Ringtone",style: TextStyle(color: Colors.white),),),
              ListTile(leading: Icon(Icons.settings,color: Colors.grey,),title: Text("Settings",style: TextStyle(color: Colors.white),),),
            ],),
          )),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1D2671), Color(0xFFC33764)])),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(height: 50, width: double.infinity,
                  child: ListTile(leading: Icon(
                    Icons.shuffle_rounded, color: Colors.amber,),title: Text("Shuffle All (${c.songlist.length})",
                    style: TextStyle(color: Colors.white),),trailing: Wrap(children: [
                    Icon(Icons.list, color: Colors.white,),
                    Icon(Icons.sort, color: Colors.white,)
                  ],)),

                  color: Color(0xFF1D2671),),
                SizedBox(height: 530,width: double.infinity,child: ListView.builder(itemCount: c.songlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return second(index);
                      },));
                    },
                        title: Text("${c.songlist[index].title}",style: TextStyle(color: Colors.white)),
                        leading: CircleAvatar(backgroundColor: Colors.purple,child: Icon(Icons.music_note,color: Colors.white,)),
                        subtitle: Text(c.printDuration(
                            Duration(milliseconds: c.songlist[index].duration!)),style: TextStyle(color: Colors.white)),
                        trailing: Obx(() => IconButton(onPressed: () async {
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
                        }, icon:(c.list.value[index]==true)? Icon(Icons.pause,color: Colors.white,): Icon(Icons.play_arrow,color: Colors.white,),),

                        )
                    );
                  },
                ),)

              ]),
            ),
          )

          ,

        )

    );
  }

}