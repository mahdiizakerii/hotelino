import 'package:flutter/material.dart';
import 'package:hotelino/core/utils/networkUrl.dart';
import 'package:hotelino/core/utils/price_formater.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';

// ignore: must_be_immutable
class FavoriteHotelCard extends StatelessWidget {
  final Hotel hotel;
  Function(String) onRemoveFavotiteClicked;

  FavoriteHotelCard({
    super.key,
    required this.hotel,
    required this.onRemoveFavotiteClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (Theme.of(context).brightness == Brightness.light)
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              spreadRadius: 2,
            )
          else
            BoxShadow(
              color: Theme.of(context).colorScheme.surfaceContainerHigh
                  .withValues(alpha: 1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "رزرو اتاق",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        hotel.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${hotel.city}, ${hotel.country}",
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                            size: 14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${hotel.bedType.count} ${hotel.bedType.details}",
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.bed,
                            color: Theme.of(context).colorScheme.primary,
                            size: 14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text("شبی از ${formatPrice(hotel.pricePerNight)}"),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.network(
                  netwrkUrl(hotel.images[0]),
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            top: 16,
            child: GestureDetector(
              onTap: () => onRemoveFavotiteClicked(hotel.id),
              child: const Icon(Icons.favorite, size: 24, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
