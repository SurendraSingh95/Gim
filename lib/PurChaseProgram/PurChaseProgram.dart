import 'package:fitness/PurChaseProgram/StartNowProgram.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidgetImage.dart';
import '../custom/Fonts.dart';

class PurChaseProgram extends StatefulWidget {
  const PurChaseProgram({super.key});

  @override
  State<PurChaseProgram> createState() => _PurChaseProgramState();
}

void _validateAndSubmit() {
  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => RegistrationScreen()));
  /*if (_controllerEmail.text.isEmpty) {
      _showSnackbar('Please Enter your Email...');
      return null;
    }
   else {
      _showSnackbar('Please correct the errors in the form.');
    }*/
}

class _PurChaseProgramState extends State<PurChaseProgram> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return  Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CustomWidgetImage(title: 'LOG IN', imageAsset: 'assets/images/logo.png',fontFamily: Fonts.arial, onTextTap: () {
                print('Image clicked');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => LoginScreen()));

                // Add your image click logic here
              },onImageTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => LoginScreen()));

                print('Image clicked');
                // Add your image click logic here
              },),
              SizedBox(height:MediaQuery.of(context).size.height*0.08),
              Container(
                alignment: Alignment.center,
                child: CustomText(
                  text: "Start your fitness journey today".toUpperCase(),
                  fontSize: 9.0,
                    textAlign: TextAlign.center,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.w400,
                  fontFamily: Fonts.arial,
                ),
              ),

              const SizedBox(height: 15),
              Center(
                child:  GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => StartNowProgram()));

                  },
                  child: Container(
                    // padding:EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    height:  MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.5,
                    decoration: BoxDecoration(
                      color: FitnessColor.colorTextThird,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Purchase Program".toUpperCase(),
                        style: TextStyle(
                          color: FitnessColor.colorfillBOx,
                          // fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

// SizedBox(height: 5,),
              // Image.asset("'assets/images/trainer.png"),
              Center(
                child: Image.asset('assets/images/trainer.png',width: MediaQuery.of(context).size.width/0.2,height: MediaQuery.of(context).size.height/2.5),
              ),

           /*   CustomText(
                text: "Verify your account by entering verification \ncode we sent to dummy@gmail.com",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.normal,
                fontFamily: Fonts.arial,
              ),
*/


              //  const SizedBox(height: 18),
              SizedBox(height: screenSize.height/8),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ) ,
    );
  }
}


