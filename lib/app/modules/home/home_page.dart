import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:castlink/app/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CastLink'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx(() {
        if (controller.videoUrls.isEmpty) {
          return const Center(
            child: Text(
              'No videos added yet.\nTap + to add a video URL',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.videoUrls.length,
          itemBuilder: (context, index) {
            final video = controller.videoUrls[index];
            return ListTile(
              title: Text(video.name),
              subtitle: Text(video.url),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controller.editVideoUrl(index);
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Edit Video'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: controller.urlController,
                                decoration: const InputDecoration(
                                  labelText: 'Video URL',
                                  hintText: 'Enter video URL',
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: controller.nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Video Name',
                                  hintText: 'Enter video name',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                controller.cancelEditing();
                                Get.back();
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.saveVideoUrl();
                                Get.back();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.deleteVideoUrl(index),
                  ),
                ],
              ),
              onTap: () {
                Get.snackbar(
                  'Video Player',
                  'Playing ${video.name}',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text('Add Video'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.urlController,
                    decoration: const InputDecoration(
                      labelText: 'Video URL',
                      hintText: 'Enter video URL',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Video Name',
                      hintText: 'Enter video name',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.urlController.clear();
                    controller.nameController.clear();
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.saveVideoUrl();
                    Get.back();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        tooltip: 'Add Video URL',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
} 