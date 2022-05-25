// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late List<CameraDescription> cameras;

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller =
      CameraController(cameras[0], ResolutionPreset.ultraHigh);
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _ispressed = ValueNotifier(false);
    List<Icon> _icons = [
      Icon(Icons.flash_on),
      Icon(Icons.flash_auto),
      Icon(Icons.flash_off)
    ];
    int _currenticonindex = 0;
    ValueNotifier<Icon> _currenticon = ValueNotifier(_icons[0]);
    ValueNotifier<double> drag = ValueNotifier(180);

    if (!controller.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              CameraPreview(controller),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: _currenticon,
                            builder: (context, newicon, _) {
                              return IconButton(
                                iconSize: 30.0,
                                onPressed: () {
                                  if (_currenticonindex < _icons.length - 1) {
                                    _currenticonindex++;
                                    _currenticon.value =
                                        _icons[_currenticonindex];
                                  } else {
                                    _currenticonindex = 0;
                                    _currenticon.value =
                                        _icons[_currenticonindex];
                                  }
                                },
                                icon: _currenticon.value,
                                color: Colors.white,
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: _ispressed,
                            builder: (context, bool newbool, _) {
                              return FloatingActionButton.large(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  elevation: 0.0,
                                  focusElevation: 0.0,
                                  autofocus: true,
                                  splashColor: Colors.red,
                                  focusColor: Colors.red,
                                  // ignore: dead_code
                                  backgroundColor: (newbool)
                                      ? Colors.red
                                      : Colors.transparent,
                                  onPressed: () {
                                    (newbool == true)
                                        ? _ispressed.value = false
                                        : _ispressed.value = true;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (newbool)
                                            ? Colors.red
                                            : Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white, width: 4.0)),
                                  ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: drag,
                            builder: (context, double newdrag, _) {
                              return Transform(
                                alignment: Alignment.bottomCenter,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(drag.value / 180 * pi),
                                child: IconButton(
                                    iconSize: 30.0,
                                    onPressed: () {
                                      if (drag.value == 180.0) {
                                        drag.value = 360;
                                      } else {
                                        drag.value = 180;
                                      }
                                    },
                                    icon: Icon(Icons.cameraswitch,
                                        color: Colors.white)),
                              );
                            })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Hold for video, tap for photo",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.0)),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
