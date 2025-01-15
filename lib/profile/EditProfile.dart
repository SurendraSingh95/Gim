import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Api Services/api_end_points.dart';
import '../../../colors.dart';
import '../../../custom/CustomButton.dart';
import '../../../custom/CustomText.dart';
import '../../../custom/CustomTextFormField.dart';
import '../../../custom/Fonts.dart';
import '../../../custom/ShowSnackbar.dart';

class EditProfileDistributor extends StatefulWidget {
  const EditProfileDistributor({super.key});

  @override
  State<EditProfileDistributor> createState() =>
      _EditProfileDistributorState();
}

class _EditProfileDistributorState extends State<EditProfileDistributor> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  bool isLoading = false;
  String? UserImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void _validateAndSubmit() {
    if (nameController.text == "") {
      CustomSnackbar.show(context, "enter full name");
      return;
    }

    if (mobileController.text == "") {
      CustomSnackbar.show(context, "phone number is required");
      return;
    }
    if (mobileController.text.length < 10) {
      CustomSnackbar.show(context, "Please enter valid mobile number!");
      return;
    }
    if (emailController.text == "") {
      CustomSnackbar.show(context, "email is required");
      return;
    }
    final RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegExp.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email!')),
      );
      return;
    } else {
      updateProfileApi();
    }
  }

  Future<void> updateProfileApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userid");
    setState(() {
      isLoading = true;
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse("${Endpoints.baseUrl}${Endpoints.updateProfile}"));
    request.fields.addAll({
      'phone': mobileController.text,
      'user_id': userId.toString(),
      'name': nameController.text,
      'email': emailController.text
    });

    /*if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _image?.path ?? ""));
    }*/

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == true) {
        CustomSnackbar.show(context, "${finalResult['message']}");
      } else {
        CustomSnackbar.show(context, "${finalResult['message']}");

        getProfileApi();
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const Deshboard()));
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  Future<void> getProfileApi() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // userId = prefs.getString("userid");
    setState(() {
      isLoading = true;
    });
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Endpoints.baseUrl}${Endpoints.getProfile}"));
    request.fields.addAll({
      'user_id': userId.toString(), // Use the entered PIN
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);

      setState(() {
        isLoading = false;
      });

      if (finalResult['error'] == true) {
        CustomSnackbar.show(context, "${finalResult['message']}");
      } else {
        // String image = finalResult['data']["image"] ?? '';
        CustomSnackbar.show(context, "${finalResult['success']}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('mobileNO', finalResult['data']["phone"]) ?? "";
        prefs.setString('userName', finalResult['data']["name"]) ?? "";
        // prefs.setString('image', image) ?? "";
        // CustomSnackbar.show(context, "${finalResult['message']}");
        emailController.text = finalResult['data']["email"] ?? "";
        nameController.text = finalResult['data']["name"] ?? "";
        mobileController.text = finalResult['data']["phone"] ?? "";
        // UserImage = image ?? "";
      }
    } else {
      setState(() {
        isLoading = false;
      });
      CustomSnackbar.show(context, 'Error: ${response.reasonPhrase}');
    }
  }

  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // print('${imageFile}gggggg');
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  String? userId;

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(
          text: "Exit App",
          fontSize: 4,
          color: FitnessColor.primaryLite,
          fontWeight: FontWeight.bold,
          fontFamily: Fonts.montserrat,
        ),
        content: CustomText(
          text: "Do you really want to exit the app?",
          fontSize: 4,
          color: FitnessColor.primaryLite,
          fontWeight: FontWeight.bold,
          fontFamily: Fonts.montserrat,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: CustomText(
              text: "No",
              fontSize: 4,
              color: FitnessColor.primaryLite,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.montserrat,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: CustomText(
              text: "Yes",
              fontSize: 4,
              color: FitnessColor.primaryLite,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.montserrat,
            ),
          ),
        ],
      ),
    ) ??
        false;
  }

  bool _isConnected = true;

  void _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (!result.contains(ConnectivityResult.none)) {
        setState(() {
          _isConnected = false;
        });
      } else {
        setState(() {
          _isConnected = true;
        });
      }
    });
  }

  String? userType;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    getSharePreferences();
  }

  getSharePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userid");
      userType = prefs.getString("usertype");
      // print("aaaaaaaaaauserId$userId");
      // print("aaaaaaaaaa$userType");
      getProfileApi();
    });
   // print("aaaaaaaaaa$userType");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: _onWillPop,
        onWillPop: () => showExitConfirmationDialog(context),
        child: _isConnected
            ? Scaffold(
          appBar: AppBar(centerTitle: true,
            title: CustomText(text:
                "Update Profile" /* userType == "0"?"Distributor":"Sales Person",*/,
                fontSize: 7,
                color: FitnessColor.colorEdit,
                fontWeight: FontWeight.bold),
            backgroundColor: FitnessColor.primaryLite,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const
              Icon(Icons.arrow_back_ios,color: FitnessColor.colorfillBOx,),
            ),),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle),
                            padding: const EdgeInsets.all(2),
                            clipBehavior: Clip.hardEdge,
                            height: 120,
                            width: 120,
                            child: _image != null
                                ? ClipRRect(
                              borderRadius:
                              BorderRadius.circular(100),
                              child: /* Image.network(
                                          "${Endpoints.imageUrl}${UserImage}")*/
                              Image.file(
                                _image!,
                                // File(image?.path),
                                fit: BoxFit.fill,
                              ),
                            )
                                 :ClipRRect(
                              borderRadius:
                              BorderRadius.circular(100),
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  "${Endpoints.imageUrl}${UserImage}",
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, _, __) {
                                    return Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: FitnessColor
                                                .colorfillBOx,
                                            borderRadius:
                                            BorderRadius
                                                .circular(50)),
                                        child: Image.asset(
                                            'assets/images/logo.png'));
                                  },
                                ),
                              ),
                            )),
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
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                10, 10, 0, 5),
                                            child: CustomText(
                                              text: "Change Profile",
                                              fontSize: 4,
                                              color: FitnessColor
                                                  .appbarBg,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                              Fonts.montserrat,
                                              textAlign: TextAlign.start,
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
                                                  color: FitnessColor.appbarBg,
                                                  onPressed: () async {
                                                    _getFromGallery();
                                                    // Navigator.pop(context);
                                                  },
                                                ),
                                                const SizedBox(height: 8.0),
                                                const Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: FitnessColor.appbarBg,
                                                    fontFamily: Fonts.montserrat,
                                                  ),
                                                ),
                                              ],
                                            )
                                            /* IconButton(
                                                    icon: const Icon(
                                                      Icons.photo_album_rounded,
                                                    ),
                                                    color: FitnessColor
                                                        .colorbatterysecond,
                                                    iconSize: 30,
                                                    onPressed: () async {
                                                      _getFromGallery();
                                                    },
                                                  ),*/,
                                            Column(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 30,
                                                  ),
                                                  color: FitnessColor.appbarBg,
                                                  onPressed: () async {
                                                    _getFromCamera();
                                                    // Navigator.pop(context);
                                                  },
                                                ),
                                                const SizedBox(height: 8.0),
                                                const Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: FitnessColor.appbarBg,
                                                    fontFamily: Fonts.montserrat,
                                                  ),
                                                ),
                                              ],
                                            )
                                            /* IconButton(
                                                    icon: const Icon(Icons
                                                        .camera_alt_rounded),
                                                    color: FitnessColor
                                                        .colorbatterysecond,
                                                    iconSize: 30,
                                                    onPressed: () async {
                                                      _getFromCamera();
                                                    },
                                                  ),*/
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(50),
                                color: FitnessColor.appbarBg),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: FitnessColor.colorBg1,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      // getMultipleImageUpload(),
                    ]),
                    const SizedBox(height: 20),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Full Name",
                              fontSize: 4,
                              color: FitnessColor.appbarBg,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.montserrat,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              hintText: 'Enter full name',
                              controller: nameController,
                              onChanged: (value) {
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              text: "Phone",
                              fontSize: 4,
                              color: FitnessColor.appbarBg,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.montserrat,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              keyboardType: TextInputType.phone,
                              hintText: 'Enter phone number',
                              controller: mobileController,
                              maxLength: 10,
                              onChanged: (value) {
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              text: "Email address",
                              fontSize: 4,
                              color: FitnessColor.appbarBg,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.montserrat,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter email address',
                              controller: emailController,
                              onChanged: (value) {
                              },
                            ),
                          ]),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        text:
                        isLoading == true ? "Please wait.." : 'Update Profile',
                        fontFamily: Fonts.roboto,
                        fontSize: 22,
                        color: FitnessColor.appbarBg,
                        onPressed: _validateAndSubmit,
                      ),
                    ),
                  ],
                )),
          ),
        )
            : Scaffold(
            body: Center(
                child: Image.asset(
                  'assets/images/internet.png',
                ))));
  }
  getMultipleImageUpload() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Select Images",
                    style: TextStyle(
                      fontSize: 20,
                      color: FitnessColor.appbarBg,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.montserrat,
                    ),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.photo_album_rounded,
                          size: 30,
                        ),
                        color: FitnessColor.appbarBg,
                        onPressed: () async {
                          // _pickImagesFromGallery();
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 16,
                          color: FitnessColor.appbarBg,
                          fontFamily: Fonts.montserrat,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          size: 30,
                        ),
                        color: FitnessColor.appbarBg,
                        onPressed: () async {
                          // _captureImageFromCamera();
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 16,
                          color: FitnessColor.appbarBg,
                          fontFamily: Fonts.montserrat,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
