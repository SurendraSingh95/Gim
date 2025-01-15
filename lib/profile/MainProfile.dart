import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../Api Services/api_end_points.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../custom/ShowSnackbar.dart';
import '../utils/Demo_Localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'EditProfile.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {


  File? _image;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  bool isLoading = false;
  String? userId;
  String? UserImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  void _validateAndSubmit() {
     Navigator.push(context,
         MaterialPageRoute(builder: (context) => const EditProfileDistributor()));

  }


  Future<void> getProfileApi() async {
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

        CustomSnackbar.show(context, "${finalResult['success']}");
        // String image = finalResult['data']["image"] ?? '';

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



  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(
          text: "Exit App",
          fontSize: 4,
          color: FitnessColor.appbarBg,
          fontWeight: FontWeight.bold,
          fontFamily: Fonts.montserrat,
        ),
        content: CustomText(
          text: "Do you really want to exit the app?",
          fontSize: 4,
          color: FitnessColor.appbarBg,
          fontWeight: FontWeight.bold,
          fontFamily: Fonts.montserrat,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: CustomText(
              text: "No",
              fontSize: 4,
              color: FitnessColor.appbarBg,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.montserrat,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: CustomText(
              text: "Yes",
              fontSize: 4,
              color: FitnessColor.appbarBg,
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

     // print("Type=================userId get ${userId}");
      getProfileApi();
    });
  }



  // final TextEditingController _controllerCardName = TextEditingController();
  // final TextEditingController _controllerCardNumber = TextEditingController();
  // final TextEditingController _controllerExpiry = TextEditingController();
  // final TextEditingController _controllerCvv = TextEditingController();
  String? _selectedCard; // Nullable type to handle no initial selection


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                CstAppbarWithtextimage(
                  title:DemoLocalization.of(context)!.translate('Profile').toString(), //'Profile',
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.anton,
                    onImageTap: (){

                    }
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/profileedit.png'),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: DemoLocalization.of(context)!.translate('FullName').toString(),//"Full Name",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.montserrat,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          // labelText: 'Email',
                          hintText: DemoLocalization.of(context)!.translate('Enterfullname').toString(),//'Enter full name',
readOnly: true,
                          controller: nameController,
                          // icon: "Icons.email",
                          secondaryIcon: Icons.check,
                          onChanged: (value) {
                            // print('fd: $value');
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: DemoLocalization.of(context)!.translate('Phone').toString(),//"Phone",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.montserrat,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: DemoLocalization.of(context)!.translate('Enterphonenumber').toString(),//'Enter phone number',
                          controller: mobileController,
                          readOnly: true,
                          onChanged: (value) {

                            print('dfd: $value');
                          },
                        ),
                        const SizedBox(height: 10),

                        CustomText(
                          text: DemoLocalization.of(context)!.translate('Emailaddress').toString(),//"Email address",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.montserrat,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          // labelText: 'Email',
                          hintText: DemoLocalization.of(context)!.translate('Enteryouremail').toString(),//'Enter your email',
                          readOnly: true,
                          controller: emailController,
                          // icon: "Icons.email",

                          onChanged: (value) {
                            print('dfd: $value');
                          },
                        ),



                      ]),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    text: DemoLocalization.of(context)!.translate('Save').toString(),//'Save',
                    fontFamily: Fonts.roboto,
                    fontSize: 22,
                    color: FitnessColor.colorTextThird,
                    onPressed: () {
                      _validateAndSubmit();
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => CheckOutScreen()));

                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
