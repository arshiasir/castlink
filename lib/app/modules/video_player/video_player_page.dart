import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart' as video_player;
import 'package:chewie/chewie.dart';
import 'package:castlink/app/modules/video_player/video_player_controller.dart';

class VideoPlayerPage extends GetView<CustomVideoPlayerController> {
  const VideoPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading video...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                );
              }
              
              if (controller.errorMessage.value.isNotEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.initializePlayer(),
                      child: const Text('Retry'),
                    ),
                  ],
                );
              }
              
              if (controller.chewieController.value != null) {
                return Chewie(controller: controller.chewieController.value!);
              }
              
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error loading video',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              );
            }),
          ),
          // Positioned(
          //   right: 16,
          //   top: 50,
          //   child: Obx(() => Container(
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.5),
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: IconButton(
          //       icon: Icon(
          //         controller.isPictureInPicture.value 
          //             ? Icons.picture_in_picture_alt 
          //             : Icons.picture_in_picture,
          //         color: Colors.white,
          //       ),
          //       onPressed: controller.togglePictureInPicture,
          //       tooltip: controller.isPictureInPicture.value 
          //           ? 'Exit Picture-in-Picture' 
          //           : 'Enter Picture-in-Picture',
          //     ),
          //   )),
          // ),
          // Add a floating control panel for PiP mode
          Obx(() => controller.isPictureInPicture.value
              ? Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.replay_10, color: Colors.white),
                          onPressed: controller.skipBackward,
                          tooltip: 'Skip backward 10 seconds',
                        ),
                        IconButton(
                          icon: Icon(
                            controller.chewieController.value?.isPlaying ?? false
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (controller.chewieController.value?.isPlaying ?? false) {
                              controller.chewieController.value?.pause();
                            } else {
                              controller.chewieController.value?.play();
                            }
                          },
                          tooltip: controller.chewieController.value?.isPlaying ?? false
                              ? 'Pause'
                              : 'Play',
                        ),
                        IconButton(
                          icon: const Icon(Icons.forward_10, color: Colors.white),
                          onPressed: controller.skipForward,
                          tooltip: 'Skip forward 10 seconds',
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
} 