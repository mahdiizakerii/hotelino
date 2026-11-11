import 'package:flutter/material.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/data/repository/hotel_repository.dart';

class FavoriteProvider extends ChangeNotifier {
  final HotelRepository _hotelRepository;

  FavoriteProvider(this._hotelRepository);

  List<Hotel> _hotels = [];

  final List<String> _favoriteHotelId = [];
  List<Hotel> get favoriteHotelList =>
      _hotels.where((hotels) => _favoriteHotelId.contains(hotels.id)).toList();

  Future<void> fetchHotels() async {
    _hotels = await _hotelRepository.fetchHotels();
    notifyListeners();
  }

  bool isFavorite(String hotelId) {
    return _favoriteHotelId.contains(hotelId);
  }

  void toggleFavorite(String hotelid) {
    if (_favoriteHotelId.contains(hotelid)) {
      _favoriteHotelId.remove(hotelid);
    } else {
      _favoriteHotelId.add(hotelid);
    }
    notifyListeners();
  }
}
