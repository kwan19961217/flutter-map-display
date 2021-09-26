import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Details extends StatelessWidget {
  final String name;
  final double latitude;
  final double longitude;

  const Details(
      {required this.name,
      required this.latitude,
      required this.longitude,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
          appBar: AppBar(title: Text('Your Friend')),
          body: Column(children: [
            //Use sizedbox to control the size of the map
            SizedBox(
              child: FlutterMap(
                //Map Starting Point
                options: MapOptions(
                  center: LatLng(latitude, longitude),
                  zoom: 15.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors");
                    },
                  ),
                  //Markers
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(latitude, longitude),
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_on, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              height: constraints.maxHeight / 2,
            ),
            //Details
            Card(
                child: ListTile(
              leading: Icon(Icons.account_circle, color: Colors.blue, size: 32),
              title: Text(name, style: TextStyle(fontSize: 18)),
            ))
          ]));
    });
  }
}
