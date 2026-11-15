import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FullScreenMapPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String hotelName;
  const FullScreenMapPage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.hotelName,
  });

  @override
  Widget build(BuildContext context) {
    final texTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude),
          initialZoom: 10.0,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.Hotelino',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(latitude, longitude),
                width: 80,
                height: 80,
                child: Column(
                  children: [
                    Icon(Icons.location_pin, color: Colors.red, size: 40),
                    Container(
                      color: Colors.white.withValues(alpha: 0.8),
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(
                        hotelName,
                        style: texTheme.bodySmall?.copyWith(
                          color: Colors.black,
                        ),
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
