import 'package:fitness/bottomdrawer/ActivityScreen.dart';
import 'package:flutter/material.dart';
import '../utils/Demo_Localization.dart';
import 'CommunityScreen.dart';
import 'SupportPage.dart';
import 'TrainScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> widgets = [
    const TrainScreen(),
    const ActivityScreen(),
    const CommunityScreen(),
    const SupportPage(),
  ];

  Future<String> myLabel(Future future) async {
    String label = "";
    await future.then((value) {
      label = value;
      setState(() {});
    });
    return label;
  }

  String label1 = "Train";
  String label2 = "Activities";
  String label3 = "Community";
  String label4 = "Support";

  @override
  Widget build(BuildContext context) {
    setState(() {
      Text(DemoLocalization.of(context)!.translate('Train').toString(),/*"Train"*/);
      Text(DemoLocalization.of(context)!.translate('Activities').toString(),/*"Activities"*/);
      Text(DemoLocalization.of(context)!.translate('Community').toString(),/*"Community"*/);
      Text(DemoLocalization.of(context)!.translate('Support').toString(),/*"Support"*/);
    });

    return Scaffold(
      body: widgets.elementAt(_selectedIndex),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: DemoLocalization.of(context)!.translate('Train').toString()//"Train",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: DemoLocalization.of(context)!.translate('Activities').toString()//"Activities",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: DemoLocalization.of(context)!.translate('Community').toString()//"Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: DemoLocalization.of(context)!.translate('Support').toString(),//"Support",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
