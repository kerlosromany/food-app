import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CostomGoogleMap extends StatefulWidget {
  const CostomGoogleMap({super.key});

  @override
  State<CostomGoogleMap> createState() => _CostomGoogleMapState();
}

class _CostomGoogleMapState extends State<CostomGoogleMap> {
  LatLng _initialCameraPosision = LatLng(20.5937, 78.9629);
  late GoogleMapController controller;
  Location _location = Location();
  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.latitude as double, event.longitude as double),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialCameraPosision),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(
                    bottom: 40, left: 10, right: 60, top: 40),
                child: MaterialButton(
                  onPressed: () async {
                    await _location.getLocation().then((value) {
                      setState(() {
                        checkOutProvider.setLocation = value;
                      });
                      Navigator.of(context).pop();
                    });
                  },
                  color: primaryColor,
                  shape: const StadiumBorder(),
                  child: const Text("Set Location"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
