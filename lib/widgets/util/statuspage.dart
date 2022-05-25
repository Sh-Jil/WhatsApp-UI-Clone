import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsappui/widgets/util/progress_bar.dart';
import 'package:whatsappui/widgets/util/statuslist.dart';

class NewStatusPage extends StatefulWidget {
  final String name;
  final String time;
  const NewStatusPage({Key? key, required this.name, required this.time})
      : super(key: key);

  @override
  State<NewStatusPage> createState() => _NewStatusPageState();
}

class _NewStatusPageState extends State<NewStatusPage> {
  int currentstoryindex = 0;
  List<double> percentWatched = [];
  Timer? _timer;

  @override
  void initState() {
    // initially all stories haven't been watched yet
    for (int i = 0; i < storylist.length; i++) {
      percentWatched.add(0);
    }
    _storyWatch();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]); //hide status bar

    super.initState();
  }

  void _storyWatch() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), ((timer) {
      setState(() {
        //only add 0.01 when it's below 1
        if (percentWatched[currentstoryindex] + 0.01 <= 1) {
          percentWatched[currentstoryindex] += 0.01;
        } // if adding 0.01 exceeds 1 then change percentwatched to one and cancel timer
        else {
          percentWatched[currentstoryindex] = 1;
          timer.cancel();
          //also go to the next story if there are more stories to go through
          if (currentstoryindex < storylist.length - 1) {
            currentstoryindex++;
            //restart story timer
            _storyWatch();
          } //if we finished watching the last story return back
          else {
            Navigator.of(context).pop();
          }
        }
      });
    }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressEnd: (details) {
        if (!_timer!.isActive) {
          _storyWatch();
        }
      },
      onLongPress: () {
        if (_timer!.isActive) {
          _timer!.cancel();
        }
      },
      onTapDown: (details) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final double dx = details.globalPosition.dx;
        //if user taps on first half of the screen from left
        if (dx < screenWidth / 2) {
          setState(() {
            //as long as this isn't the first story
            if (currentstoryindex > 0) {
              //set current and previous story percentage back to zero
              percentWatched[currentstoryindex] = 0;
              percentWatched[currentstoryindex - 1] = 0;
              //go back to previous story
              currentstoryindex--;
            }
          });
        } //user taps on second half of the screen
        else {
          //if it isn't the last story
          if (currentstoryindex < storylist.length - 1) {
            //set current story as complete and start next story
            percentWatched[currentstoryindex] = 1;
            currentstoryindex++;
          } else {
            percentWatched[currentstoryindex] = 1;
          }
        }
      },
      child: Scaffold(
        body: Stack(children: [
          storylist[currentstoryindex],
          StoryBars(
            percentWatched: percentWatched,
          ),
          Positioned(
              top: 40,
              child: StatusPerson(name: widget.name, time: widget.time))
        ]),
      ),
    );
  }
}

class StatusPerson extends StatelessWidget {
  final String name;
  final String time;
  const StatusPerson({Key? key, required this.name, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            constraints: BoxConstraints.tight(const Size(24.0, 24.0)),
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/images/images.jfif'),
                ),
              ),
              title: Text(name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(time, style: const TextStyle(color: Colors.white)),
              trailing: PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (context) {
                    return <PopupMenuEntry<PopupMenuItem>>[];
                  }),
            ))
      ],
    );
  }
}
