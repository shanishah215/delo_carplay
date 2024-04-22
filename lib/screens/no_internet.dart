import '../utils/constants.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  NoInternet({super.key});
  late Brightness brightness;

  @override
  Widget build(BuildContext context) {
    brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: brightness == Brightness.light
          ? Constants.lightThemeTileColor.withOpacity(0.9)
          : Constants.darkThemeBg.withOpacity(0.9),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: Text(
            "Težava pri nalaganju.",
            style: Theme.of(context)
                .listTileTheme
                .titleTextStyle!
                .copyWith(fontSize: 40),
          ))),
          Container(
            height: 88,
            margin: const EdgeInsets.only(left: 80, right: 80, bottom: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).iconTheme.color,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                "Poskusi znova",
                style: TextStyle(
                    color: brightness == Brightness.light
                        ? Constants.lightThemeTileColor
                        : Constants.darkThemeBg,
                    fontFamily: 'SF Pro',
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
