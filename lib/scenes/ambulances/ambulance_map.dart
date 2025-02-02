import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/tag_item.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceMap extends StatefulWidget {
  AmbulanceMap({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<AmbulanceMap> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();
  LatLng? currentPosition;
  LatLng defaultLocation = LatLng(32.6475256, 0.38506239999999997);
  double currentZoom = 12.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newPosition = LatLng(location.latitude, location.longitude);

        print(newPosition);

        mapController
            .animateCamera(CameraUpdate.newLatLngZoom(newPosition, 14));

        setState(() {
          defaultLocation = newPosition; // Update marker position
        });
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Location not found! Try another name."),
      ));
    }
  }

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    // Move camera to current location
    mapController.animateCamera(CameraUpdate.newLatLng(currentPosition!));
  }

  /// Zoom In
  void _zoomIn() {
    setState(() {
      currentZoom += 1;
      mapController.animateCamera(CameraUpdate.zoomTo(currentZoom));
    });
  }

  /// Zoom Out
  void _zoomOut() {
    setState(() {
      currentZoom -= 1;
      mapController.animateCamera(CameraUpdate.zoomTo(currentZoom));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: defaultLocation, zoom: 12),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: {
              Marker(
                markerId: MarkerId("searchedLocation"),
                position: defaultLocation,
              ),
            },
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  onPressed: _zoomIn,
                  child: Icon(Icons.zoom_in),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: _zoomOut,
                  child: Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Start at 30% of screen height
            minChildSize: 0.2, // Min height when dragged down
            maxChildSize: 0.7, // Max height when dragged up
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F8FC),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: ListView(
                  controller: scrollController, // Allow scrolling
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Set Pickup Location",
                                style: TextStyle(
                                    fontSize: 17.94,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Inter",
                                    color: AppColors.blackColor),
                              ),
                              TagItem(label: "Edit", height: 23, width: 71)
                            ],
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "Search location...",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () =>
                                      _searchLocation(searchController.text),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColorD, width: 1)),
                                enabledBorder: OutlineInputBorder(
                                  // Border when not focused
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: AppColors.greyColorD, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // Border when focused
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryRedColor,
                                      width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  // Border when error occurs
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFED1C24), width: 1),
                                )),
                            onSubmitted: (value) => _searchLocation(value),
                          ),
                          SizedBox(height: 15),
                          RedBtn(label: 'Continue', onPressed: () {})
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


// Text("Location Details",
//     style: TextStyle(
//         fontSize: 18, fontWeight: FontWeight.bold)),
// SizedBox(height: 10),
// Text(
//     "This is a draggable bottom sheet on top of Google Maps."),