import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player/second_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'control.dart';




class first extends StatefulWidget {

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  control1 c1 = Get.put(control1());
  final player = AudioPlayer();
  // getsong()
  // async {
  //   final metadata = await MetadataRetriever.fromFile(File(c.songlist[0].data));
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // //  c.permition();
  //   //c.getsongs();
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c1.getsongs();
  }


  Uint8List? albumArt;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(title: Obx(() =>(c1.m.value==true)?TextField(style: TextStyle(color: Colors.white),onChanged: (value) {

            // c.sear.value=c.songlist.where((element) => element.toString().contains(value)).toList();
            //   print("l=${c.sear.value}");

          },decoration: InputDecoration(hintText: "Search your Music..",hintStyle: TextStyle(color: Colors.white)),):Text(
            "Music Player", style: TextStyle(color: Colors.white),),),
            actions: [
              Obx(() =>(c1.m.value==true)? IconButton(
                  onPressed: () {
                    c1.m.value=!c1.m.value;
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  )):IconButton(onPressed: () {
                c1.m.value=!c1.m.value;
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
                    Icons.shuffle_rounded, color: Colors.amber,),title: Text("Shuffle All (${c1.songlist.length})",
                    style: TextStyle(color: Colors.white),),trailing: Wrap(children: [
                    Icon(Icons.list, color: Colors.white,),
                    Icon(Icons.sort, color: Colors.white,)
                  ],)),

                  color: Color(0xFF1D2671),),
                (c1.play1==true)? SizedBox(height: 530,width: double.infinity,
                    child: ListView.builder(itemCount: c1.songlist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: () {
                          if(c1.list[index])
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return second(index);
                            },));
                          }
                          else
                          {
                            c1.play(index);
                          }
                        },child: ListTile(focusColor: Colors.amber,onTap: () async {

                          showModalBottomSheet(context: context, builder: (context) {
                            return Container(decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFF1D2671), Color(0xFFC33764)])),height: 80,width: double.infinity,
                                child: ListTile(onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return second(index);
                                  },));

                                },
                                    title:MarqueeText(style: TextStyle(color: Colors.white),speed: 15,alwaysScroll: true,text: TextSpan(text: "${c1.songlist[index].title}"),),
                                    subtitle: Text(c1.printDuration(
                                        Duration(milliseconds: c1.songlist[index].duration!)),style: TextStyle(color: Colors.white)),
                                    leading: (albumArt==null)?CircleAvatar(backgroundColor: Colors.purple,child: Icon(Icons.music_note,color: Colors.white,)):null,
                                    trailing: Obx(() => Wrap(
                                      children: [
                                        IconButton(onPressed: () async {
                                          c1.list[c1.con.value]=!c1.list[c1.con.value];
                                          if (c1.list[c1.con.value]) {
                                            c1.play(index);
                                          } else {
                                            c1.pause(index);
                                          }
                                        }, icon:(c1.list[c1.con.value]==true)? Icon(Icons.pause,color: Colors.white,): Icon(Icons.play_arrow,color: Colors.white,),),
                                        IconButton(onPressed: () async {
                                          c1.pause(c1.con.value);
                                          Navigator.pop(context);
                                        }, icon: Icon(Icons.clear,color: Colors.white,))
                                      ],
                                    ))
                                )
                            );
                          },);

                        },
                          title: Text("${c1.songlist[index].title}",style: TextStyle(color: Colors.white)),
                          leading: (albumArt==null)?CircleAvatar(backgroundColor: Colors.purple,child: Icon(Icons.music_note,color: Colors.white,)):null,
                          subtitle: Text(c1.printDuration(
                              Duration(milliseconds: c1.songlist[index].duration!)),style: TextStyle(color: Colors.white)),
                          trailing: Wrap(
                            children: [
                              (c1.list[c1.con.value]==true)?SizedBox(height: 100,width: 100,child: Lottie.asset("image/106549-music.json")):
                              IconButton(onPressed: () async {

                                // c.list.value[index]=!c.list.value[index];

                                //c1.playpush(index, songlist);
                              }, icon:(c1.search.value==true)? InkWell(onTap: () {
                                showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context) {
                                  return Container(height: 380,width:double.infinity,decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFF1D2671), Color(0xFFC33764)])),child: Column(children: [
                                    ListTile(title:Text("${c1.songlist[index].title}",style: TextStyle(color: Colors.white)),
                                      trailing: Wrap(children: [
                                        IconButton(onPressed: () {

                                        }, icon: Icon(Icons.info,color: Colors.white,)),
                                        IconButton(onPressed: () {

                                        }, icon: Icon(Icons.share,color: Colors.white,))
                                      ]),),
                                    Divider(color: Colors.white),
                                    ListTile(leading: Icon(Icons.playlist_play_sharp,color: Colors.white,),title: Text("Play next",style: TextStyle(color: Colors.white),),),
                                    ListTile(leading: Icon(Icons.music_note_outlined,color: Colors.white,),title: Text("Add to queue",style: TextStyle(color: Colors.white)),),
                                    ListTile(leading: Icon(Icons.add_to_photos,color: Colors.white,),title: Text("Add to playlist",style: TextStyle(color: Colors.white)),),
                                    ListTile(leading: Icon(Icons.notification_important_rounded,color: Colors.white,),title: Text("Set as ringtone",style: TextStyle(color: Colors.white)),),
                                    ListTile(leading: Icon(Icons.delete,color: Colors.white,),title: Text("Delete from device",style: TextStyle(color: Colors.white)),),

                                  ]),);
                                },);
                              },child: Icon(Icons.more_vert_sharp,color: Colors.white,)): Icon(Icons.more_vert_sharp,color: Colors.white,),),
                            ],
                          ),


                        ),);
                      },
                    )):Center(child: CircularProgressIndicator(),)

              ]),
            ),
          ),

        )

    );
  }
}
