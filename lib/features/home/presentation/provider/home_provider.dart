import 'package:flutter/material.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/data/repository/hotel_repository.dart';

class HomeProvider extends ChangeNotifier {
  final HotelRepository _hotelRepository;

  HomeProvider(this._hotelRepository) {
    fetchHotels();
  }

  List<Hotel> _hotels = [];

  List<Hotel> get hotels => _hotels;

  Future<void> fetchHotels() async {
    _hotels = await _hotelRepository.fetchHotels();
    notifyListeners();
  }
}
