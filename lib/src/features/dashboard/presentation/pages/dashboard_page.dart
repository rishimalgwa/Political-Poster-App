import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:political_poster_app/src/common/contants/asstes_path.dart';
import 'package:political_poster_app/src/common/di/di.dart';
import 'package:political_poster_app/src/common/helpers/size.dart';
import 'package:political_poster_app/src/common/widgets/button.dart';
import 'package:political_poster_app/src/common/widgets/snackbar.dart';
import 'package:political_poster_app/src/core/persistence/constants.dart';
import 'package:political_poster_app/src/core/persistence/database.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';
import 'package:political_poster_app/src/features/auth/domain/persistence/user_dao.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/cubit/leaders_photo_cubit/leaders_photo_cubit.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/widgets/change_leader_bottomsheet.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/widgets/leader_image_widget.dart';
import 'package:political_poster_app/src/navigation/router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();
  late UserModel userModel;
  Future<void> _handleDownload(BuildContext context) async {
    await Permission.photos.onDeniedCallback(() {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackbar("Permission Denied"),
      );
    }).onGrantedCallback(() async {
      final image = await widgetsToImageController.capture();
      if (image == null) return;

      await ImageGallerySaver.saveImage(image);
      ScaffoldMessenger.of(context).showSnackBar(
        successSnackbar("Downloaded Successfully"),
      );
    }).request();
  }

// Handle share action
  Future<void> _handleShare(BuildContext context) async {
    try {
      final capturedImage = await widgetsToImageController.capture();
      if (capturedImage == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(capturedImage);

      await Share.shareXFiles([
        XFile(imagePath.path),
      ], text: 'Great picture');
    } on PlatformException catch (e) {
      log('PlatformException: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackbar("Failed to Share: ${e.message}"),
      );
    } catch (e) {
      log('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackbar("An unexpected error occurred"),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    userModel = Database<UserModel>(boxName: USER_BOX).box.values.first;
    context.read<LeadersPhotoCubit>().getLeadersPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () async {
                await getIt<GetUserDao>().logout(userModel).then((_) {
                  context.router.pushAndPopUntil(const PhoneRoute(),
                      predicate: (_) => false);
                });
              }),
        ],
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: WidgetsToImage(
                controller: widgetsToImageController,
                child: Stack(
                  children: [
                    Image.asset(posterPath),
                    BlocBuilder<LeadersPhotoCubit, LeadersPhotoState>(
                      builder: (context, state) {
                        if (state is LeadersPhotoLoaded) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, left: 4),
                            child: Row(
                              children: state.imageUrls.map((imageUrl) {
                                return LeaderImageWidget(imagePath: imageUrl);
                              }).toList(),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    Positioned(
                      bottom: 1,
                      left: 1,
                      right: 1,
                      child: Container(
                        height: 60,
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                userModel.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                userModel.designation,
                                style: const TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image(
                            image: AssetImage(userModel.photoUrl),
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: SizeHelper(context).wHelper(28),
                  child: CustomSecondaryButton(
                      text: "Edit",
                      buttonColor: Colors.redAccent,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        context.router.push(const EditProfileRoute());
                      })),
              SizedBox(
                  width: SizeHelper(context).wHelper(36),
                  child: CustomSecondaryButton(
                      text: "Download",
                      buttonColor: Colors.blueAccent,
                      icon: const Icon(
                        Icons.file_download_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () async {
                        await _handleDownload(context);
                      })),
              SizedBox(
                  width: SizeHelper(context).wHelper(28),
                  child: CustomSecondaryButton(
                    text: "Share",
                    buttonColor: Colors.green,
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () async {
                      await _handleShare(context);
                    },
                  )),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (BuildContext context) {
                  return const ChangeLeaderBottomsheet();
                },
              ).then((b) {
                context.read<LeadersPhotoCubit>().getLeadersPhoto();
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red),
              ),
              child: const Center(
                  child: Text(
                "Change Leader Photo",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
