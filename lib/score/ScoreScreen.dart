// import 'package:flutter/material.dart';
//
// import '../colors.dart';
// import '../custom/CustomText.dart';
// import '../custom/CustomWidget.dart';
// import '../custom/Fonts.dart';
// import '../utils/Demo_Localization.dart';
//
// class ScoreScreen extends StatefulWidget {
//   const ScoreScreen({super.key});
//
//   @override
//   State<ScoreScreen> createState() => _ScoreScreenState();
// }
//
// class _ScoreScreenState extends State<ScoreScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               const CustomTextWidget(
//                   title: "",
//                   fontFamily: Fonts.arial,
//                   icon: Icons.arrow_back_ios,
//                   imageAsset: ""),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: CustomText(
//                   text: DemoLocalization.of(context)!
//                       .translate(
//                           'NutritionandLifestyleQuestionnairesScoreSheet')
//                       .toString(),
//                   //"Nutrition and Lifestyle Questionnaires Score Sheet",
//                   fontSize: 7.0,
//                   color: FitnessColor.colorTextFour,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: Fonts.arial,
//                   textAlign: TextAlign.start,
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               // Center(
//               //   child: Image.asset('assets/images/rectanglescore.png',
//               //       width: MediaQuery.of(context).size.width / 0.2,
//               //       height: MediaQuery.of(context).size.height / 2),
//               // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Row(
//                 children: [
//                   Text(
//                     "Name : ",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: Fonts.arial,
//                         fontWeight: FontWeight.normal,
//                         color: FitnessColor.colorTextThird),
//                   ),
//                   Text(
//                     "Rahul Raj ",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: Fonts.arial,
//                         fontWeight: FontWeight.normal,
//                         color: FitnessColor.colorTextThird),
//                   )
//                 ],
//               ),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Data 1 : 20/07/2024",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: Fonts.arial,
//                         fontWeight: FontWeight.normal,
//                         color: FitnessColor.colorTextThird),
//                   ),
//                   Text(
//                     "Data 2 :  25/07/2024",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: Fonts.arial,
//                         fontWeight: FontWeight.normal,
//                         color: FitnessColor.colorTextThird),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:fitness/PurChaseProgram/StartNowSecond.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExactScoreTableUI extends StatefulWidget {
  const ExactScoreTableUI({super.key});

  @override
  State<ExactScoreTableUI> createState() => _ExactScoreTableUIState();
}

class _ExactScoreTableUIState extends State<ExactScoreTableUI> {
  final List<Map<String, dynamic>> tableData = [
    {
      "label": "Total Score",
      "scores": ["715", "300", "170"],
      "colors": [Colors.red, Colors.yellow, Colors.green],
      "icons": ["❌", "😊", "😊"],
    },
    {
      "label": "Detoxification System Health Zones 3 & 4",
      "scores": ["88", "40", "20", "10"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
    {
      "label": "Fungus & Parasites Zones 3 & 4",
      "scores": ["195", "120", "50", "20"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
    {
      "label": "Digestive System Health Zones 1, 2 & 3",
      "scores": ["81", "60", "30", "15"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
    {
      "label": "You Are When You Eat Zone 3",
      "scores": ["40", "30", "15", "5"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
    {
      "label": "Circadian Health Zone 2",
      "scores": ["50", "30", "15", "5"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
    {
      "label": "Stress Zone 4",
      "scores": ["81", "60", "30", "15","15","15"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
    {
      "label": "You Are What You Eat Zones 1, 2 & 3",
      "scores": ["50", "40", "30", "15"],
      "colors": [Colors.red, Colors.yellow, Colors.green, Colors.green],
      "icons": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Priority Score Table",style: TextStyle(fontSize: 15)),
        centerTitle: true,
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 10),
           child: CustomButton(
             width: 60,
               height: 30,
               text: DemoLocalization.of(context)!
               .translate('Next')
               .toString(), onPressed: (){
             Get.to(()=>const StartNowSecond());

           }, fontFamily: Fonts.arial),
         )


       ],
       // backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.black, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                _buildHeaderRow(),
                ...tableData.map((row) => _buildDynamicDataRow(row)).toList(),
                _buildEmptyRow("Score 1"),
                _buildEmptyRow("Score 2"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.greenAccent),
      children: [
        _buildCell("Category", isHeader: true),
        _buildCell("High Priority", isHeader: true),
        _buildCell("Moderate Priority", isHeader: true),
        _buildCell("Low Priority", isHeader: true),
      ],
    );
  }

  TableRow _buildDynamicDataRow(Map<String, dynamic> rowData) {
    final String label = rowData["label"];
    final List<dynamic> scores = rowData["scores"];
    final List<Color> colors = rowData["colors"];
    final List<dynamic> icons = rowData["icons"];

    return TableRow(
      children: [
        _buildCell(label),
        ...List.generate(
          3, // Ensure all rows have 3 main columns
              (index) => index < scores.length
              ? _buildCell(
            "${icons.isNotEmpty && index < icons.length ? icons[index].toString() : ''} ${scores[index].toString()}",
            backgroundColor: colors[index],
          )
              : _buildCell(""),
        ),
      ],
    );
  }

  TableRow _buildEmptyRow(String label) {
    return TableRow(
      children: [
        _buildCell(label),
        _buildCell(""),
        _buildCell(""),
        _buildCell(""),
      ],
    );
  }

  Widget _buildCell(String text,
      {Color backgroundColor = Colors.white, bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 14.0,
          color: isHeader ? Colors.black : Colors.black87,
        ),
      ),
    );
  }
}


