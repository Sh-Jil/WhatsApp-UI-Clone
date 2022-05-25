import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class MyProgressBar extends StatelessWidget {
  double percentWatched = 0;
  MyProgressBar({Key? key, required this.percentWatched}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
        barRadius: const Radius.circular(25.0),
        lineHeight: 3,
        percent: percentWatched,
        progressColor: Colors.white);
  }
}

// ignore: must_be_immutable
class StoryBars extends StatelessWidget {
  List<double> percentWatched = [];
  StoryBars({Key? key, required this.percentWatched}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(children: [
        Expanded(child: MyProgressBar(percentWatched: percentWatched[0])),
        Expanded(child: MyProgressBar(percentWatched: percentWatched[1])),
        Expanded(child: MyProgressBar(percentWatched: percentWatched[2]))
      ]),
    );
  }
}
