import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:math' as math;

class CustomAudioPlayer {
  static AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  static Duration? songDuration = const Duration(seconds: 280);
  static String podcastName = '';
  static String podcastDetails = '';
  static String podcastImage = '';
  static String categoryName = '';


  static Future<void> initAudioPlayer(String audio) async {
    // assetsAudioPlayer.playerState.single.then((state) {
    //   if(state == PlayerState.stop) {
    //     print("player stop");
    //  }
    //   if(state == PlayerState.play || state == PlayerState.pause ) {
    //     print("state true");
    //     disposeAudioPlayer();
    //   }
    // });
    // disposeAudioPlayer();
    await assetsAudioPlayer.stop();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    await assetsAudioPlayer.open(Audio.network(audio)).then((value) async {
      await getAudioDuration();
    });
  }

  static Future<void> getAudioDuration() async {
    assetsAudioPlayer.onReadyToPlay.listen((event) async {
      songDuration = Duration(minutes: 32, seconds: math.Random().nextInt(60));
    });
  }

  static Future<void> playAudio() async {
    await assetsAudioPlayer.play();
  }

  static Future<void> pauseAudio() async {
    await assetsAudioPlayer.pause();
  }

  static Future<void> disposeAudioPlayer() async {
    await assetsAudioPlayer.dispose();
  }
}