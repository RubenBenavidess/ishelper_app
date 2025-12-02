import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A widget that displays a video in the background, covering the entire screen.
///
/// The video loops continuously and is muted. The widget handles the video
/// lifecycle, including initialization, pausing when the app is in the background,
/// and resuming when the app is in the foreground.
class BackgroundVideo extends StatefulWidget {
  /// The path to the video asset (e.g., 'assets/videos/background.mp4').
  final String videoPath;

  /// Creates a background video widget.
  ///
  /// The [videoPath] is required and must be a valid asset path defined in
  /// `pubspec.yaml`.
  const BackgroundVideo({super.key, required this.videoPath});

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;

  /// Initializes the video controller for the given [path].
  ///
  /// This method sets up the video to loop, mutes it, and starts playing
  /// as soon as it's initialized.
  void _initVideo(String path) {
    _controller = VideoPlayerController.asset(path)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        // Ensure the first frame is shown after initialization.
        setState(() {});
      });
  }

  @override
  void initState() {
    super.initState();
    // Register this object as an observer of application lifecycle events.
    WidgetsBinding.instance.addObserver(this);
    // Initialize the video with the provided path.
    _initVideo(widget.videoPath);
  }

  @override
  void didUpdateWidget(covariant BackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the video path has changed, dispose the old controller and initialize
    // a new one with the new path.
    if (oldWidget.videoPath != widget.videoPath) {
      _controller.dispose();
      _initVideo(widget.videoPath);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Pause or resume the video based on the app's lifecycle state.
    if (_controller.value.isInitialized) {
      if (state == AppLifecycleState.resumed) {
        _controller.play();
      } else if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    // Remove the lifecycle observer and dispose the video controller to free up resources.
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the video player if it's initialized.
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
            // Otherwise, show a black container as a placeholder.
            : Container(color: Colors.black),
        // Add a semi-transparent overlay to darken the video and improve text visibility.
        Container(
          color: Colors.black.withAlpha(200),
        ),
      ],
    );
  }
}
