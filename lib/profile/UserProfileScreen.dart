import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData = {
    "firstname": "Rahul",
    "lastname": "Parmar",
    "city": "Indore",
    "state": "Madhya Pradesh",
    "country": "India",
    "profile":
    "https://lh3.googleusercontent.com/a/ACg8ocKvALwOwTALj-NhDi0f9cr5xqZ-Ygo_YKjrWTuArRVZawWsWQ=s96-c",
    "friend": 50,
    "follower": 100,
    "bio": "Running enthusiast and developer",
  };

   UserProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(radius: 50,
              backgroundImage: CachedNetworkImageProvider(userData['profile']),
            ),
            SizedBox(height: 10),
            // Full Name
            Text("${userData['firstname']} ${userData['lastname']}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),

            // Location
            Text("${userData['city']}, ${userData['state']}, ${userData['country']}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ), ),

            // Bio
            if (userData['bio'] != null && userData['bio'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  userData['bio'],
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            SizedBox(height: 20),
            // Followers and Friends
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn("Friends", userData['friend']),
                _buildStatColumn("Followers", userData['follower']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to show Friends and Followers counts
  Widget _buildStatColumn(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
