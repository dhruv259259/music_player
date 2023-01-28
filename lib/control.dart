import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class control extends GetxController
{
  RxList<bool> list=<bool>[].obs;
  RxList sear=[].obs;
  RxBool search=false.obs;
  List<SongModel> songlist=[];
  RxBool m=false.obs;
  permition()
  async {
    var status = await Permission.camera.status;
    if(status.isDenied)
    {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      //print(statuses[Permission.location]);
    }
  }
  OnAudioQuery _audioQuery = OnAudioQuery();
  getsongs()
  async {
    songlist = await _audioQuery.querySongs();
    print("songs${songlist}");
    list.value=List.filled(songlist.length,false);
    // m.value=true;
  }
  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

}