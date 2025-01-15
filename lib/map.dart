import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(0, 0); // Default position
  LatLng _mapCenter = const LatLng(0, 0); // Map's current center position
  bool _isLoadingLocation = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapCenter = _currentPosition;
      _isLoadingLocation = false;
    });

    // Move map camera to current location
    _mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  // Function to search for a location and update the map center
  // Future<void> _searchLocation(String query) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(query);
  //     if (locations.isNotEmpty) {
  //       final location = locations[0];
  //       setState(() {
  //         _mapCenter = LatLng(location.latitude, location.longitude);
  //       });
  //       _mapController.animateCamera(CameraUpdate.newLatLng(_mapCenter));
  //     }
  //   } catch (e) {
  //     // Handle error if location is not found
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Location not found")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map Example'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onCameraMove: (CameraPosition position) {
              setState(() {
                _mapCenter = position.target;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: _mapCenter,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          if (_isLoadingLocation)
            const Center(
              child: CircularProgressIndicator(),
            ),
          // Display the current map center coordinates
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Lat: ${_mapCenter.latitude.toStringAsFixed(6)}, '
                    'Lng: ${_mapCenter.longitude.toStringAsFixed(6)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          // Search bar at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search location...',
                  border: InputBorder.none,
                ),
               // onSubmitted: _searchLocation,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          // Return the map's current center position
          Navigator.pop(context, _mapCenter);
        },
        tooltip: "Confirm Location",
      ),
    );
  }
}



