import 'package:connectivity_plus/connectivity_plus.dart';
import '../screens/no_internet.dart';
import '../utils/custom_audio_player.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key, required this.continuePlaying});
  final bool continuePlaying;

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  double songCurrentPos = 0;
  Duration songCurrentPosDuration = const Duration(minutes: 0, seconds: 0);
  bool isPlaying = true;
  late Brightness brightness;

  @override
  void initState() {
    super.initState();
    !widget.continuePlaying ? initAudioPlayer() : null;
  }

  Future<void> initAudioPlayer() async {
    await CustomAudioPlayer.initAudioPlayer().then((value) async {
      await CustomAudioPlayer.playAudio();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    brightness = Theme.of(context).brightness;
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.data != [] && snapshot.data != null) {
          return Stack(
            children: [
              buildBody(),
              snapshot.data!.contains(ConnectivityResult.none)
                  ? NoInternet()
                  : Container()
            ],
          );
        } else {
          return buildBody();
        }
        // return buildBody();
      },
    );
  }

  Widget buildBody() {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        toolbarHeight: 80,
        leadingWidth: 0,
        title: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 35, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(Constants.backArrowLight)),
              Text(
                "Najnovejši podkasti",
                style: Theme.of(context)
                    .listTileTheme
                    .subtitleTextStyle!
                    .copyWith(fontSize: 26),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          /// podcast title and image
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Markeš: Takrat sem verjel Janši',
                          style: Theme.of(context)
                              .listTileTheme
                              .titleTextStyle!
                              .copyWith(fontSize: 36),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: Text(
                            'Ali Žerdin in Janez Markeš sta ob okrogli Ali Žerdin in Janez Markeš sta ob okrogli',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: Theme.of(context)
                                .listTileTheme
                                .subtitleTextStyle!
                                .copyWith(fontSize: 26),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await CustomAudioPlayer.assetsAudioPlayer
                                      .seekBy(-const Duration(seconds: 15));
                                },
                                child: SvgPicture.asset(
                                  Constants.mediaBack15Sec,
                                  height: 40,
                                  colorFilter: ColorFilter.mode(
                                      brightness == Brightness.light
                                          ? Constants.lightThemeSubtitle
                                          : Constants.darkThemeText,
                                      BlendMode.srcIn),
                                ),
                              ),
                              StreamBuilder(
                                stream: CustomAudioPlayer
                                    .assetsAudioPlayer.isPlaying,
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    isPlaying = snapshot.data!;
                                  }
                                  return SizedBox(
                                    width: 80,
                                    child: InkWell(
                                      onTap: () async {
                                        isPlaying
                                            ? CustomAudioPlayer.pauseAudio()
                                            : CustomAudioPlayer.playAudio();
                                      },
                                      child: Center(
                                          child: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow_rounded,
                                        color: brightness == Brightness.light
                                            ? Constants.lightThemeSubtitle
                                            : Constants.darkThemeText,
                                        size: isPlaying ? 50 : 60,
                                      )),
                                    ),
                                  );
                                },
                              ),
                              InkWell(
                                onTap: () async {
                                  await CustomAudioPlayer.assetsAudioPlayer
                                      .seekBy(const Duration(seconds: 15));
                                },
                                child: SvgPicture.asset(
                                  Constants.mediaForward15Sec,
                                  height: 40,
                                  colorFilter: ColorFilter.mode(
                                      brightness == Brightness.light
                                          ? Constants.lightThemeSubtitle
                                          : Constants.darkThemeText,
                                      BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: SvgPicture.asset(
                      'assets/images/podcast_img.svg',
                      height: 194,
                      width: 350,
                    ))
              ],
            ),
          ),

          /// podcast slider
          Expanded(
              flex: 3,
              child: StreamBuilder(
                stream: CustomAudioPlayer.assetsAudioPlayer.currentPosition,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    songCurrentPosDuration = snapshot.data!;
                    songCurrentPos = snapshot.data!.inSeconds.toDouble();
                    if (songCurrentPos ==
                        CustomAudioPlayer.songDuration?.inSeconds) {
                      CustomAudioPlayer.pauseAudio();
                      CustomAudioPlayer.assetsAudioPlayer
                          .seek(const Duration(seconds: 0));
                    }
                  }
                  return Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "${songCurrentPosDuration.inMinutes}:${(songCurrentPosDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                            textAlign: TextAlign.right,
                          )),
                      Expanded(
                        flex: 16,
                        child: Slider(
                          max: CustomAudioPlayer.songDuration != null
                              ? CustomAudioPlayer.songDuration!.inSeconds
                                  .toDouble()
                              : 0,
                          min: 0,
                          activeColor: Theme.of(context).iconTheme.color,
                          inactiveColor: brightness == Brightness.light
                              ? Constants.lightThemeTileColor
                              : Constants.lightThemeSubtitle,
                          value: songCurrentPos,
                          onChanged: (value) async {
                            await CustomAudioPlayer.assetsAudioPlayer
                                .seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            "${CustomAudioPlayer.songDuration?.inMinutes}:${((CustomAudioPlayer.songDuration?.inSeconds ?? 1) % 60).toString().padLeft(2, '0')}",
                            textAlign: TextAlign.left,
                          )),
                    ],
                  );
                },
              ))
        ],
      ),
    );
  }
}
