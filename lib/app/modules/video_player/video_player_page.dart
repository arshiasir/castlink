import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart' as video_player;
import 'package:chewie/chewie.dart';
import 'package:castlink/app/modules/video_player/video_player_controller.dart';

class VideoPlayerPage extends GetView<CustomVideoPlayerController> {
  const VideoPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading video...'),
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
                  Text('Error loading video'),
                ],
              );
            }),
          ),
          Positioned(
            right: 16,
            top: 50,
            child: Obx(() => FloatingActionButton(
              heroTag: 'pipMode',
              onPressed: controller.togglePictureInPicture,
              child: Icon(
                controller.isPictureInPicture.value 
                    ? Icons.picture_in_picture_alt 
                    : Icons.picture_in_picture,
              ),
            )),
          ),
        ],
      ),
    );
  }
} 