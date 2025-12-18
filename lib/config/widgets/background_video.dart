import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  final String videoPath;
  final String placeholderPath;

  const BackgroundVideo({
    super.key,
    required this.videoPath,
    required this.placeholderPath,
  });

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _isVideoVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initVideo(widget.videoPath);
  }

  void _initVideo(String path) {
    _controller = VideoPlayerController.asset(path)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        _controller.addListener(_onVideoControllerUpdate);

        setState(() {});
      });
  }

  void _onVideoControllerUpdate() {
    if (_controller.value.isInitialized &&
        _controller.value.isPlaying &&
        _controller.value.position > Duration.zero &&
        !_isVideoVisible) {
      setState(() {
        _isVideoVisible = true;
      });
      _controller.removeListener(_onVideoControllerUpdate);
    }
  }

  @override
  void didUpdateWidget(covariant BackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _controller.removeListener(_onVideoControllerUpdate);
      _controller.dispose();
      // Reseteamos visibilidad al cambiar de video
      setState(() => _isVideoVisible = false);
      _initVideo(widget.videoPath);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!_controller.value.isInitialized) return;

    if (state == AppLifecycleState.resumed) {
      _controller.play();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onVideoControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            widget.placeholderPath,
            fit: BoxFit.cover,
          ),
        ),

        if (_controller.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: AnimatedOpacity(
                  opacity: _isVideoVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),

        Container(
          color: Colors.black.withAlpha(200),
        ),
      ],
    );
  }
}