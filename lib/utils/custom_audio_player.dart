import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:math' as math;

class CustomAudioPlayer {
  static late AssetsAudioPlayer assetsAudioPlayer;
  static Duration? songDuration = const Duration(seconds: 280);
  static String podcastName = '';
  static String podcastDetails = '';
  static String podcastImage = '';
  static String categoryName = '';


  static Future<void> initAudioPlayer() async {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    await assetsAudioPlayer.open(Audio("assets/audio/song.mp3")).then((value) async {
      await getAudioDuration();
    });
  }

  static Future<void> getAudioDuration() async {
    assetsAudioPlayer.onReadyToPlay.listen((event) async {
      // songDuration = event?.duration;
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