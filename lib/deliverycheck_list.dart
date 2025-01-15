import 'package:flutter/material.dart';

class HomeScreenDelivery extends StatefulWidget {
  const HomeScreenDelivery({Key? key}) : super(key: key);

  @override
  State<HomeScreenDelivery> createState() => _HomeScreenDeliveryState();
}

class _HomeScreenDeliveryState extends State<HomeScreenDelivery>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs: Delivery Details & Customer Details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen Delivery'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show the bottom sheet when button is pressed
            getBottomDialogUpload();
          },
          child: Text('Show Delivery Details'),
        ),
      ),
    );
  }

  void getBottomDialogUpload() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black, // Keep label color consistent
                  unselectedLabelColor: Colors.black, // Keep unselected label color consistent
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue, // Color of the line below the tab
                        width: 2.0, // Line thickness
                      ),
                    ),
                  ),
                  tabs: [
                    Tab(
                      text: 'Delivery Details',
                    ),
                    Tab(
                      text: 'Customer Details',
                    ),
                  ],
                ),
                Container(
                  height: 300, // Adjust height of the content area
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Delivery Details Content
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Pick Up Location",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "50 Guild Street, Cholwell Atlantis",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Drop Location",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "5G9 Trehafad Road, Buckland In the More",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      // Customer Details Content
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Customer Name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "John Doe",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Contact",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "+1234567890",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
