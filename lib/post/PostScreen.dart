/*
import 'package:flutter/material.dart';
import 'dart:io';

import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class RunningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void _showPostDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return PostDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Running App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPostDialog(context),
          child: Text('Create Post'),
        ),
      ),
    );
  }
}

class PostDialog extends StatefulWidget {
  @override
  _PostDialogState createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  TextEditingController _subtitleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _image;
  // final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
   */
/* final File? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }*//*

  }

  void _submitPost() {
    String subtitle = _subtitleController.text;
    String description = _descriptionController.text;

    // Handle the submission of the subtitle, description, and image (if any)
  //  print('Subtitle: $subtitle');
   // print('Description: $description');
    if (_image != null) {
   //   print('Image selected: ${_image!.path}');
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // To handle keyboard overlay
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(
                labelText: DemoLocalization.of(context)!.translate('Subtitle').toString(),//'Subtitle',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: DemoLocalization.of(context)!.translate('Description').toString(),//'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 150,
              ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _submitPost,
                  child: Text(DemoLocalization.of(context)!.translate('Post').toString(),*/
/*'Post'*//*
),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}



class PostReferralCodeDialog extends StatefulWidget {
  @override
  _PostReferralCodeDialogState createState() => _PostReferralCodeDialogState();
}

class _PostReferralCodeDialogState extends State<PostReferralCodeDialog> {
  TextEditingController _subtitleController = TextEditingController();
  // TextEditingController _descriptionController = TextEditingController();
  // File? _image;
  // final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    */
/* final File? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }*//*

  }

  void _submitPost() {
    String subtitle = _subtitleController.text;
    // String description = _descriptionController.text;

    // Handle the submission of the subtitle, description, and image (if any)
    print('Subtitle: $subtitle');
    // print('Description: $description');
    // if (_image != null) {
    //   print('Image selected: ${_image!.path}');
    // }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // To handle keyboard overlay
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text:DemoLocalization.of(context)!.translate('Enteryourcode').toString(),// "Enter your code",
                fontSize: 6,
                textAlign: TextAlign.start,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial //Fonts.arial,
            ),
            SizedBox(height: 15,),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(
                labelText: DemoLocalization.of(context)!.translate('Entercode').toString(),//'Enter code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 80.0),

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 50,
                  // width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    color: FitnessColor.colorBg1,
                    // border: Border.all(color: Colors.grey, width: 1),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)), // Border radius
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Icon(Icons.favorite_border, color: Colors.red),
                      // SizedBox(width: 5),
                      CustomText(
                        text: DemoLocalization.of(context)!.translate('Verifyonlytext').toString(),//"Verify",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}*/
