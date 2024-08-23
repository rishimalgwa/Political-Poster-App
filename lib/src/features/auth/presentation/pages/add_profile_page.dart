import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:political_poster_app/src/common/widgets/button.dart';
import 'package:political_poster_app/src/common/widgets/loading_widget.dart';
import 'package:political_poster_app/src/common/widgets/snackbar.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';
import 'package:political_poster_app/src/features/auth/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:political_poster_app/src/features/auth/presentation/widgets/label_textfield.dart';
import 'package:political_poster_app/src/navigation/router.dart';

@RoutePage()
class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key, required this.phoneNumer});
  final String phoneNumer;

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  String? _imagePath;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
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
        leadingWidth: 200,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Add Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
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
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 110,
                          width: 110,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: _imagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(_imagePath!),
                                    fit: BoxFit.cover,
                                  ),
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
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload your photo",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Text("(अपनी फोटो अपलोड करें)"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LabelTextField(
                    label: "Name:",
                    hintText: "Ex. John Doe",
                    hindiLabel: "(नाम)",
                    controller: _nameController,
                    validator: (value) => _validateNotEmpty(value, "Name"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                    context.router.push(const DashboardRoute());
                  }
                  if (state is SignupError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(errorSnackbar("Something went wrong"));
                  }
                },
                builder: (context, state) {
                  if (state is SignupLoading) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }
                  return CustomPrimaryButton(
                    text: "Save & Next",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_imagePath == null) {
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
                                    photoUrl: _imagePath!,
                                    rightPhotoUrl: _imagePath!,
                                    phoneNumber: widget.phoneNumer,
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
}
