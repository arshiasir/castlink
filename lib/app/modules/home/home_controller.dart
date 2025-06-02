import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:castlink/app/models/video_url.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final videoUrls = <VideoUrl>[].obs;
  final isEditing = false.obs;
  final editingIndex = (-1).obs;
  final urlController = TextEditingController();
  final nameController = TextEditingController();
  final _storage = GetStorage();
  final _storageKey = 'video_urls';

  @override
  void onInit() {
    super.onInit();
    loadVideoUrls();
  }

  void loadVideoUrls() {
    final List<dynamic>? storedUrls = _storage.read(_storageKey);
    if (storedUrls != null) {
      videoUrls.value = storedUrls
          .map((url) => VideoUrl.fromJson(url as Map<String, dynamic>))
          .toList();
    }
  }

  void _saveVideoUrls() {
    final List<Map<String, dynamic>> urlsToStore = 
        videoUrls.map((url) => url.toJson()).toList();
    _storage.write(_storageKey, urlsToStore);
  }

  void addVideoUrl() {
    isEditing.value = true;
    urlController.clear();
    nameController.clear();
    editingIndex.value = -1;
  }

  void editVideoUrl(int index) {
    isEditing.value = true;
    editingIndex.value = index;
    final video = videoUrls[index];
    urlController.text = video.url;
    nameController.text = video.name;
  }

  String _extractFilenameFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        String filename = pathSegments.last;
        // Remove any query parameters if present
        filename = filename.split('?').first;
        // Remove any hash if present
        filename = filename.split('#').first;
        return filename;
      }
    } catch (e) {
      print('Error parsing URL: $e');
    }
    return '';
  }

  void saveVideoUrl() {
    if (urlController.text.isEmpty) return;

    final url = urlController.text;
    String name = nameController.text;
    
    // If name is empty, try to extract it from URL
    if (name.isEmpty) {
      name = _extractFilenameFromUrl(url);
      // If still empty, use a default name
      if (name.isEmpty) {
        name = 'Video ${videoUrls.length + 1}';
      }
    }

    final newVideo = VideoUrl(
      url: url,
      name: name,
    );

    if (editingIndex.value >= 0) {
      videoUrls[editingIndex.value] = newVideo;
    } else {
      videoUrls.add(newVideo);
    }

    _saveVideoUrls();
    isEditing.value = false;
    urlController.clear();
    nameController.clear();
    editingIndex.value = -1;
  }

  void cancelEditing() {
    isEditing.value = false;
    urlController.clear();
    nameController.clear();
    editingIndex.value = -1;
  }

  void deleteVideoUrl(int index) {
    videoUrls.removeAt(index);
    _saveVideoUrls();
  }

  @override
  void onClose() {
    urlController.dispose();
    nameController.dispose();
    super.onClose();
  }
} 