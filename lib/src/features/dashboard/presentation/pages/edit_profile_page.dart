import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:political_poster_app/src/common/di/di.dart';
import 'package:political_poster_app/src/common/widgets/button.dart';
import 'package:political_poster_app/src/common/widgets/loading_widget.dart';
import 'package:political_poster_app/src/common/widgets/snackbar.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';
import 'package:political_poster_app/src/features/auth/domain/persistence/user_dao.dart';
import 'package:political_poster_app/src/features/auth/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:political_poster_app/src/features/auth/presentation/widgets/label_textfield.dart';
import 'package:political_poster_app/src/navigation/router.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  String? _leftImagePath, _rightImagePath;
  late String phoneNumber;
  late UserModel userModel;
  bool isImageFlipped = false;

  @override
  void initState() {
    super.initState();
    userModel = getIt<GetUserDao>().getUser()!;
    phoneNumber = userModel.phoneNumber;
    _nameController.text = userModel.name;
    _designationController.text = userModel.designation;
    _leftImagePath = userModel.photoUrl;
    _rightImagePath = userModel.rightPhotoUrl;
  }

  Future<void> _pickImage(bool isLeft) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isLeft) {
          _leftImagePath = pickedFile.path;
        } else {
          _rightImagePath = pickedFile.path;
        }
      });
    }
  }

  Future<void> _flipImage(bool isLeft) async {
    final imagePath = isLeft ? _leftImagePath : _rightImagePath;
    if (imagePath == null) return;

    setState(() {
      isImageFlipped = true;
    });

    try {
      final File imageFile = File(imagePath);

      // Decode the image
      final img.Image? originalImage =
          img.decodeImage(await imageFile.readAsBytes());

      if (originalImage != null) {
        // Flip the image horizontally
        final img.Image flippedImage = img.flipHorizontal(originalImage);

        // Get the directory to save the image
        final Directory directory = await getApplicationDocumentsDirectory();
        final String path =
            '${directory.path}/flipped_image_${isLeft ? 'left' : 'right'}_${DateTime.now().millisecondsSinceEpoch}.png';

        // Save the flipped image
        final File flippedImageFile = File(path)
          ..writeAsBytesSync(img.encodePng(flippedImage));

        // Update the image path to the flipped image
        setState(() {
          if (isLeft) {
            _leftImagePath = flippedImageFile.path;
          } else {
            _rightImagePath = flippedImageFile.path;
          }
        });
      } else {
        log("Failed to decode image.");
      }
    } catch (e) {
      log("Error flipping image: $e");
    } finally {
      setState(() {
        isImageFlipped = false;
      });
    }
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Your Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              getIt<GetUserDao>().clearUser().then((_) {
                context.router.pushAndPopUntil(const PhoneRoute(),
                    predicate: (_) => false);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildImageColumn(
                        label: "Left Face",
                        isLeft: true,
                        imagePath: _leftImagePath,
                        onPickImage: () => _pickImage(true),
                        onFlipImage: () => _flipImage(true),
                      ),
                      _buildImageColumn(
                        label: "Right Face",
                        isLeft: false,
                        imagePath: _rightImagePath,
                        onPickImage: () => _pickImage(false),
                        onFlipImage: () => _flipImage(false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LabelTextField(
                    label: "Name:",
                    hintText: "Ex. John Doe",
                    hindiLabel: "(नाम)",
                    controller: _nameController,
                    validator: (value) => _validateNotEmpty(value, "Name"),
                  ),
                  const SizedBox(height: 20),
                  LabelTextField(
                    label: "Designation:",
                    hintText: "Owner of BJP",
                    hindiLabel: "(पदनाम)",
                    controller: _designationController,
                    validator: (value) =>
                        _validateNotEmpty(value, "Designation"),
                  ),
                ],
              ),
              BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    context.router.popAndPush(const DashboardRoute());
                  }
                  if (state is SignupError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(errorSnackbar("Something went wrong"));
                  }
                },
                builder: (context, state) {
                  if (state is SignupLoading) {
                    return const Center(child: LoadingWidget());
                  }
                  return CustomPrimaryButton(
                    text: "Submit",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_leftImagePath == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please upload a photo'),
                            ),
                          );
                        } else {
                          context.read<SignupCubit>().signup(
                                user: UserModel(
                                    name: _nameController.text,
                                    designation: _designationController.text,
                                    photoUrl: _leftImagePath!,
                                    rightPhotoUrl: _rightImagePath,
                                    phoneNumber: phoneNumber,
                                    isLoggedIn: true),
                              );
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageColumn({
    required String label,
    required String? imagePath,
    required VoidCallback onPickImage,
    required VoidCallback onFlipImage,
    required bool isLeft,
  }) {
    return Row(
      children: [
        if (isLeft)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        Column(
          children: [
            GestureDetector(
              onTap: onPickImage,
              child: Container(
                height: 150,
                width: 110,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: imagePath != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(imagePath),
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.person, size: 80),
                      ),
              ),
            ),
            isImageFlipped
                ? const LoadingWidget()
                : GestureDetector(
                    onTap: onFlipImage,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.flip_camera_ios_outlined,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "FLIP PHOTO",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        if (!isLeft)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 10),
            ),
          ),
      ],
    );
  }
}
