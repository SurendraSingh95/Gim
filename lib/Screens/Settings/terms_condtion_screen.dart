import 'package:fitness/Controllers/HomeController/setting_controller.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  SettingController settingController = Get.put(SettingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingController.termsAndConditionApi();
  }
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: () async {
        await settingController.refresh().then((val) {
          setState(() {
            settingController.termsAndConditionApi();
          });
        });
      },
      child: Scaffold(
          backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,

          body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 16, top: 16),
                child: CstAppbarWithtextimage(
                    title: DemoLocalization.of(context)!.translate('Termsandconditions').toString(),
                    icon: Icons.arrow_back_ios,
                    fontFamily: Fonts.arial,
                    onImageTap: (){
                      Get.back();
                    }
                ),
              ),
              const SizedBox(height: 10,),
              Obx(() {
                    if (settingController.isLoading.value) {
                      return myShimmer();
                    }
                    if (settingController.termsData.isEmpty) {
                      return  Center(
                          child: CustomText1(text: DemoLocalization.of(context)!.translate('No_data_found').toString(), fontSize: 4,fontFamily: Fonts.arial,)
                      );
                    }

                    return
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text:"${settingController.termsData.first.title}", fontSize: 4, color:FitnessColor.primary,fontWeight: FontWeight.bold,fontFamily:Fonts.arial, ),
                            const SizedBox(height: 5,),
                            CustomText(text:"${settingController.termsData.first.content}", fontSize: 4, color:FitnessColor.primary,textAlign: TextAlign.justify,fontFamily:Fonts.arial, ),
                          ],
                        ),
                      );
                  }
              )
            ],
          ),
        )
      ),
    );
  }
}
