import 'package:flutter/material.dart';

class LoginScreenOld extends StatefulWidget {
  @override
  _LoginScreenOldState createState() => _LoginScreenOldState();
}

class _LoginScreenOldState extends State<LoginScreenOld> {
  bool isStravaConnected = false;

  final String stravaAuthUrl =
      'https://www.strava.com/oauth/authorize?client_id=133232&response_type=code&redirect_uri=http://tfbfitness.com&approval_prompt=force&scope=read,activity:read_all';

  void toggleStravaConnection(bool value) {
    if (value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StravaAuthWebView(stravaAuthUrl: stravaAuthUrl),
        ),
      );
    }
    setState(() {
      isStravaConnected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect to Strava")),
      body: Center(
        child: SwitchListTile(
          title: Text('Connect to Strava'),
          value: isStravaConnected,
          onChanged: toggleStravaConnection,
        ),
      ),
    );
  }
}

class StravaAuthWebView extends StatelessWidget {
  final String stravaAuthUrl;

  StravaAuthWebView({required this.stravaAuthUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Strava OAuth')),
      body: SizedBox()/*WebView(
        initialUrl: stravaAuthUrl,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('http://tfbfitness.com')) {
            Uri uri = Uri.parse(request.url);
            String? code = uri.queryParameters['code'];
            if (code != null) {
              // Handle the authorization code (e.g., send it to your backend)
              print("Authorization Code: $code");
              Navigator.pop(context); // Close the WebView screen
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      )*/,
    );
  }
}
