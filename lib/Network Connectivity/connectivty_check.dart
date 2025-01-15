// Dart imports:

// Flutter imports:
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// Package imports:

class NetworkConnectivityService {
  final StreamController<bool> _connectivityStreamController =
      StreamController<bool>();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isDialogShowing = false;

  NetworkConnectivityService() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
    _checkConnectivity();
  }

  Stream<bool> get connectivityStream => _connectivityStreamController.stream;

  void dispose() {
    _connectivitySubscription.cancel();
    _connectivityStreamController.close();
  }

  Future<void> _checkConnectivity() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResults);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = !results.contains(ConnectivityResult.none);

    if (!isConnected && !_isDialogShowing) {
      _showNoConnectionDialog();
    } else if (isConnected && _isDialogShowing) {
      Get.back();
      _isDialogShowing = false;
    }

    _connectivityStreamController.add(isConnected);
  }

  void _showNoConnectionDialog() {
    _isDialogShowing = true;
    Get.defaultDialog(
      title: "No Internet Connection",
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
      titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off,
            size: 50,
            color: Colors.redAccent,
          ),
          SizedBox(height: 10),
          Text(
            "Please check your internet connection and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      actions:[
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "OK",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Get.back();
            _isDialogShowing = false;
          },
        ),
      ],
      barrierDismissible: false,
    ).then((value) {
      _isDialogShowing = false;
    });
  }

  static Future<bool> checkInternetConnection() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    return !connectivityResults.contains(ConnectivityResult.none);
  }
}
