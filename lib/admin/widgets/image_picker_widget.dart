import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  final List<AssetEntity> _recentImages = [];
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadGalleryImages();
  }

  Future<void> _loadGalleryImages() async {
    // final PermissionState permission =
    //     await PhotoManager.requestPermissionExtend();
    // print("Permission State: $permission");
    // if (permission == PermissionState.authorized) {
    //   List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
    //     type: RequestType.image,
    //     hasAll: true,
    //   );
    //   if (albums.isNotEmpty) {
    //     List<AssetEntity> recentImages =
    //         await albums.first.getAssetListPaged(page: 0, size: 50);
    //     setState(() {
    //       _recentImages = recentImages;
    //     });
    //   }
    // } else if (permission == PermissionState.denied) {
    //   PhotoManager.presentLimited();
    // } else {
    //   PhotoManager.openSetting();
    // }
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    print(ps);
    if (!mounted) {
      return;
    }
    // Further requests can be only proceed with authorized or limited.
    if (!ps.hasAccess) {
      return;
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      context.pop();
    }
  }

  Future<void> _pickFromGallery(AssetEntity asset) async {
    final File? file = await asset.file;
    if (file != null) {
      setState(() {
        _selectedImage = file;
      });
      context.pop();
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      itemCount: _recentImages.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Camera button
                          return GestureDetector(
                            onTap: _pickFromCamera,
                            child: Container(
                              color: Colors.black54,
                              child: const Center(
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 40),
                              ),
                            ),
                          );
                        } else {
                          AssetEntity asset = _recentImages[index - 1];
                          return FutureBuilder<File?>(
                            future: asset.file,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data != null) {
                                return GestureDetector(
                                  onTap: () => _pickFromGallery(asset),
                                  child: Image.file(snapshot.data!,
                                      fit: BoxFit.cover),
                                );
                              }
                              return Container(color: Colors.grey);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker")),
      body: Column(
        children: [
          if (_selectedImage != null)
            Image.file(_selectedImage!,
                height: 200, width: double.infinity, fit: BoxFit.cover),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showImagePickerSheet,
            child: const Text("Open Image Picker"),
          ),
        ],
      ),
    );
  }
}
