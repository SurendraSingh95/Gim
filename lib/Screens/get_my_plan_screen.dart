import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom/Fonts.dart';
class MyPlanList extends StatefulWidget {
  const MyPlanList({Key? key}) : super(key: key);

  @override
  State<MyPlanList> createState() => _MyPlanListState();
}

class _MyPlanListState extends State<MyPlanList> {

  HomeController  homeController =  Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.myPlanApi();
  }
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: ()async{
        homeController.myPlanApi();
        setState(() {

        });
      },
      child: Scaffold(
          backgroundColor: isDarkMode ? FitnessColor.colorsociallogintext.withOpacity(0.4) : FitnessColor.white,

          body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: CstAppbarWithtextimage(
                  title: DemoLocalization.of(context)!.translate('MyPlan').toString(),
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                  onImageTap: (){
                    Get.back();
                  }
              ),
            ),
            const SizedBox(height: 10),
            Obx(
                ( ) {
                return
                homeController.isLoading1.value
                  ? myShimmer()
                  :homeController.userList.isEmpty
                  ? CustomText1(text: DemoLocalization.of(context)!.translate('MyPlan').toString(), fontSize: 4,fontFamily: Fonts.arial,)
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: homeController.userList.length,
                    itemBuilder: (context ,i){
                    var item = homeController.userList[i];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Amount ${double.parse(item.amount ?? "").toStringAsFixed(0)}",
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.arial,

                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text: "Status: ${item.status ?? " "}",
                              fontSize: 5,

                              fontFamily: Fonts.arial,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text: "Transaction Id : ${item.transactionId ?? " "}",
                              fontSize: 5,
                              color: Colors.grey,
                              fontFamily: Fonts.arial,

                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  });
              }
            ),
          ],
        )
      ),
    );
  }
}
