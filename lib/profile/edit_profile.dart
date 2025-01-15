import 'dart:io';
import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../colors.dart';
import '../../../custom/CustomButton.dart';
import '../../../custom/CustomText.dart';
import '../../../custom/CustomTextFormField.dart';
import '../../../custom/Fonts.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key,this.profileImage});
  final String? profileImage;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  HomeController homeController = Get.put(HomeController());

  File? image;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    print(widget.profileImage);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                CstAppbarWithtextimage(
                    title: DemoLocalization.of(context)!.translate('UpdateProfile').toString(),
                    icon: Icons.arrow_back_ios,
                    fontFamily: Fonts.arial,
                    onImageTap: () {
                      Get.back();
                    }
                ),
                const SizedBox(height: 15),
                Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                        ),
                        color: isDarkMode ? Colors.grey[800] : Colors.white, // Card color based on theme
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            padding: const EdgeInsets.all(2),
                            clipBehavior: Clip.hardEdge,
                            height: 120,
                            width: 120,
                            child:
                            image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                image!,
                                fit: BoxFit.fill,
                              ),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  "https://tfbfitness.com${widget.profileImage ?? " "}",
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, _, __) {
                                    return Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: FitnessColor.colorfillBOx,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Image.asset('assets/images/logo.png', fit: BoxFit.fill),
                                    );
                                  },
                                ),
                              ),
                            )
                          )
                        ),
                      ),
                      Positioned(
                        left: 88,
                        top: 80,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 120,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                            child: CustomText1(
                                              text:  DemoLocalization.of(context)!.translate('Change_Profile').toString(),
                                              fontSize: 4,
                                              color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Fonts.arial,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.photo_album_rounded,
                                                    size: 30,
                                                  ),
                                                  color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                                                  onPressed: () async {
                                                    _getFromGallery();
                                                  },
                                                ),
                                                const SizedBox(height: 8.0),
                                                CustomText(
                                                  text:  DemoLocalization.of(context)!.translate('Gallery').toString(),
                                                  fontSize: 4,
                                                  color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Fonts.arial,
                                                  textAlign: TextAlign.start,
                                                ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 30,
                                                  ),
                                                  color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                                                  onPressed: () async {
                                                    _getFromCamera();
                                                  },
                                                ),
                                                const SizedBox(height: 8.0),
                                                CustomText(
                                                  text:  DemoLocalization.of(context)!.translate('Camera').toString(),
                                                  fontSize: 3.5,
                                                  color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Fonts.arial,
                                                  textAlign: TextAlign.start,
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDarkMode ? Colors.white : Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              color: isDarkMode ? Colors.grey[800] : FitnessColor.appbarBg,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: FitnessColor.colorBg1,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
                const SizedBox(height: 20),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: DemoLocalization.of(context)!.translate('FullName').toString(),
                        fontSize: 4,
                        color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                      ),
                      const SizedBox(height: 5),

                      CustomTextFormField(
                        hintText: DemoLocalization.of(context)!.translate('Enterfullname').toString(),
                        controller: homeController.nameController,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: DemoLocalization.of(context)!.translate('Phone').toString(),
                        fontSize: 4,
                        color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                      ),
                      const SizedBox(height: 5),

                      CustomTextFormField(
                        keyboardType: TextInputType.phone,
                        hintText:DemoLocalization.of(context)!.translate('Enterphonenumber').toString(),
                        controller: homeController.phoneController,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text:DemoLocalization.of(context)!.translate('Emailaddress').toString(),
                        fontSize: 4,
                        color: isDarkMode ? Colors.white : FitnessColor.appbarBg,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter email address',
                        controller: homeController.emailController,
                        onChanged: (value) {},
                      ),
                    ]
                ),
                const SizedBox(height: 20),
                Center(
                  child: Obx(() {
                    return !homeController.isLoading.value
                        ? CustomButton(
                      color: FitnessColor.primary,
                      height: 55,
                      text: DemoLocalization.of(context)!.translate('UpdateProfile').toString(),
                      fontSize: 20,
                      onPressed: () {
                        homeController.uploadProfileApi(image);
                      }, fontFamily:Fonts.arial,
                    )
                        : const CircularProgressIndicator();
                  }),
                )
              ],
            )
        ),
      ),
    );
  }


}
