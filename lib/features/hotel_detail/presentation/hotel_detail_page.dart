import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hotelino/core/utils/networkUrl.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/data/repository/hotel_repository.dart';
import 'package:hotelino/features/hotel_detail/presentation/full_screen_map_page.dart';
import 'package:hotelino/shared/services/json_data_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HotelDetailPage extends StatelessWidget {
  final String hotelId;
  const HotelDetailPage({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final hotelRepository = HotelRepository(jsonDataService: JsonDataService());
    final texTheme = Theme.of(context).textTheme;
    return FutureBuilder<Hotel>(
      future: hotelRepository.getHotelId(hotelId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final hotel = snapshot.data;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onLongPress: () {},
                    child: Image.network(
                      netwrkUrl(hotel!.images.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                elevation: 8,
                expandedHeight: 300,
                leading: IconButton(
                  onPressed: () => PersistentNavBarNavigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hotel.name,
                        style: texTheme.headlineMedium,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              hotel.address,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.location_on_outlined, color: Colors.grey),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "امکانات رفاهی",
                        style: texTheme.headlineSmall,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 14,
                        children: hotel.amenities.map((a) {
                          IconData icon;
                          switch (a) {
                            case "ساحل":
                              icon = Icons.beach_access;
                              break;
                            case "باشگاه":
                              icon = Icons.fitness_center;
                              break;
                            case "کافه":
                              icon = Icons.coffee;
                              break;
                            case "رستوران":
                              icon = Icons.restaurant;
                              break;
                            case "کولر":
                              icon = Icons.ac_unit;
                              break;

                            default:
                              icon = Icons.check_circle_outline;
                              break;
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(icon, color: Colors.grey, size: 30),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                a,
                                style: texTheme.bodySmall!.copyWith(
                                  color: Colors.black87,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "گالری تصاویر",
                        style: texTheme.headlineSmall,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: hotel.images.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                    child: Image.network(
                                      netwrkUrl(hotel.images[index]),
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (index != 0) SizedBox(width: 8),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "توضیحات",
                        textDirection: TextDirection.rtl,
                        style: texTheme.headlineSmall,
                      ),
                      SizedBox(height: 8),
                      Text(
                        hotel.description,
                        textDirection: TextDirection.rtl,
                        style: texTheme.bodyMedium?.copyWith(height: 1.5),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                                screen: FullScreenMapPage(
                                  latitude: hotel.location.latitude,
                                  longitude: hotel.location.longitude,
                                  hotelName: hotel.name,
                                ),
                              );
                            },
                            child: Text("باز کردن نقشه"),
                          ),
                          Text(
                            "موقعیت مکانی هتل",
                            style: texTheme.headlineSmall,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: FlutterMap(
                            options: MapOptions(
                              initialZoom: 15,
                              initialCenter: LatLng(
                                hotel.location.latitude,
                                hotel.location.longitude,
                              ),
                              interactionOptions: InteractionOptions(
                                flags: InteractiveFlag.all,
                              ),
                            ),
                            children: [
                              TileLayer(
                                userAgentPackageName: 'com.example.Hotelino',
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(
                                      hotel.location.latitude,
                                      hotel.location.longitude,
                                    ),
                                    width: 80,
                                    height: 80,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                        Container(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            hotel.name,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
