import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:political_poster_app/src/common/helpers/size.dart';
import 'package:political_poster_app/src/common/widgets/button.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/cubit/leaders_photo_cubit/leaders_photo_cubit.dart';

class ChangeLeaderBottomsheet extends StatefulWidget {
  const ChangeLeaderBottomsheet({super.key});

  @override
  State<ChangeLeaderBottomsheet> createState() =>
      _ChangeLeaderBottomsheetState();
}

class _ChangeLeaderBottomsheetState extends State<ChangeLeaderBottomsheet> {
  final Set<String> _selectedImages = {}; // Track selected images
  final Set<String> _allImages = {}; // Track all images available
  final int _maxSelection = 6; // Max images allowed

  void _selectImage(String imagePath) {
    setState(() {
      if (_selectedImages.contains(imagePath)) {
        _selectedImages.remove(imagePath);
      } else {
        if (_selectedImages.length < _maxSelection) {
          _selectedImages.add(imagePath);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You can only select up to $_maxSelection images"),
            ),
          );
        }
      }
    });
  }

  @override
  void initState() {
    _selectedImages.addAll(context.read<LeadersPhotoCubit>().selectedImages);
    _allImages.addAll(context.read<LeadersPhotoCubit>().allImages);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeHelper(context).hHelper(30),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select or Add Leader Photo',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Limit 6 Leaders',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 90,
                  height: 30,
                  child: CustomSecondaryButton(
                    text: "Done",
                    buttonColor: Colors.redAccent,
                    onPressed: () {
                      context.read<LeadersPhotoCubit>().selectedImages =
                          _selectedImages;
                      context.read<LeadersPhotoCubit>().allImages = _allImages;
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () async {
                    // Open gallery and let user pick an image
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      setState(() {
                        // Add the new image to _allImages and select it
                        _allImages.add(pickedFile.path);
                        _selectImage(pickedFile.path);
                      });
                    }
                  },
                  child: const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.add),
                  ),
                ),
                ..._buildImageWidgets(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImageWidgets() {
    return _allImages.map((imagePath) {
      return GestureDetector(
        onTap: () => _selectImage(imagePath),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              radius: 33,
              backgroundColor: _selectedImages.contains(imagePath)
                  ? Colors.greenAccent
                  : Colors.transparent,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: imagePath.startsWith('assets/')
                    ? AssetImage(imagePath) as ImageProvider
                    : FileImage(File(imagePath)),
                child: _selectedImages.contains(imagePath)
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                      )
                    : null,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
