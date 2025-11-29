import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget{

  final String videoPath;
  const BackgroundVideo({super.key, required this.videoPath});
   
  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();

}

class _BackgroundVideoState extends State<BackgroundVideo> with WidgetsBindingObserver{

  late VideoPlayerController _controller;

  void _initVideo(String path) {
    _controller = VideoPlayerController.asset(path)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initVideo(widget.videoPath);
  }

  @override
  void didUpdateWidget(covariant BackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoPath != widget.videoPath) {
      _controller.dispose(); 
      _initVideo(widget.videoPath);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (_controller.value.isInitialized) {
      if (state == AppLifecycleState.resumed) {
        _controller.play();
      } else if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : Container(color: Colors.black),
            
        Container(
          color: Colors.black.withAlpha(200), 
        ),
      ],
    );
  }

}


