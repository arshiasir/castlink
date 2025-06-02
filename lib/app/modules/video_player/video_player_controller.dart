import 'package:get/get.dart';
import 'package:video_player/video_player.dart' as video_player;
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomVideoPlayerController extends GetxController {
  final videoUrl = ''.obs;
  final videoName = ''.obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final chewieController = Rxn<ChewieController>();
  final isPictureInPicture = false.obs;
  video_player.VideoPlayerController? _videoPlayerController;

  // Add skip duration constant
  static const Duration skipDuration = Duration(seconds: 10);

  // Add skip methods
  void skipForward() {
    if (_videoPlayerController != null) {
      final currentPosition = _videoPlayerController!.value.position;
      final newPosition = currentPosition + skipDuration;
      final duration = _videoPlayerController!.value.duration;
      
      if (newPosition <= duration) {
        _videoPlayerController!.seekTo(newPosition);
      } else {
        _videoPlayerController!.seekTo(duration);
      }
    }
  }

  void skipBackward() {
    if (_videoPlayerController != null) {
      final currentPosition = _videoPlayerController!.value.position;
      final newPosition = currentPosition - skipDuration;
      
      if (newPosition >= Duration.zero) {
        _videoPlayerController!.seekTo(newPosition);
      } else {
        _videoPlayerController!.seekTo(Duration.zero);
      }
    }
  }

  void togglePictureInPicture() async {
    try {
      if (isPictureInPicture.value) {
        // Exit PiP mode
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
        );
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      } else {
        // Enter PiP mode
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersiveSticky,
          overlays: [],
        );
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
      isPictureInPicture.value = !isPictureInPicture.value;
    } catch (e) {
      print('Error toggling PiP mode: $e');
      errorMessage.value = 'Failed to toggle picture-in-picture mode';
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, String>;
    videoUrl.value = args['url'] ?? '';
    videoName.value = args['name'] ?? '';
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Dispose of any existing controller
      await _videoPlayerController?.dispose();
      
      // Create a new controller with streaming configuration
      _videoPlayerController = video_player.VideoPlayerController.network(
        videoUrl.value,
        httpHeaders: const {
          'Range': 'bytes=0-',
        },
        videoPlayerOptions: video_player.VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: true,
        ),
      );

      // Initialize the controller
      await _videoPlayerController!.initialize();

      // Create Chewie controller with streaming-friendly settings
      chewieController.value = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        placeholder: Container(
          color: Colors.black,
        ),
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white,
        ),
        // Add streaming-specific options
        startAt: Duration.zero,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
      );

      // Listen for PiP mode changes
      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.isPlaying) {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.immersiveSticky,
            overlays: [],
          );
        }
      });
    } catch (e) {
      print('Error initializing video player: $e');
      errorMessage.value = 'Failed to load video: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _videoPlayerController?.dispose();
    chewieController.value?.dispose();
    super.onClose();
  }
} 