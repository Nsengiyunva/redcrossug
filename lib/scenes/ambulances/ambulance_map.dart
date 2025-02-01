// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AmbulanceMap extends StatefulWidget {

//   const AmbulanceMap( { super.key } );

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<AmbulanceMap> {

//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(37.7749, -122.4194);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Google Map Example')),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 10,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';


class AmbulanceMap extends StatefulWidget {
  const AmbulanceMap({super.key});

  @override
  State<AmbulanceMap> createState() => _DisasterDetailsState();
}

class _DisasterDetailsState extends State<AmbulanceMap> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset( 
                  'assets/images/map.png', 
                  width: double.infinity, 
                  height: 500 
                ),
              ),
              const SizedBox( height: 25 ),
              Container(
                child: Column(
                  children: [
                    // Text( "Set Pickup Location" ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 25 ),
                      child: RedBtn(label: 'Continue', onPressed: () {
                        Get.toNamed('/ambulance-success-request');
                      } )
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
