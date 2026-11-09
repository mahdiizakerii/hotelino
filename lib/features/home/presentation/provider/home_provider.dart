import 'package:flutter/material.dart';
import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/features/home/data/models/home_page_data.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/data/repository/hotel_repository.dart';

class HomeProvider extends ChangeNotifier {
  final HotelRepository _hotelRepository;

  HomeProvider(this._hotelRepository) {
    fetchHotels();
  }

  List<Hotel> _hotels = [];

  List<Hotel> get hotels => _hotels;

  final HomePageData _homePageData = HomePageDataConstants.homePageData;
  HomePageData get homePageData => _homePageData;

  Future<void> fetchHotels() async {
    _hotels = await _hotelRepository.fetchHotels();
    notifyListeners();
  }

  //--------------------------------------------------------------------------------

  List<Hotel> getPopularHotels() {
    return _hotels
        .where((hotel) => _homePageData.popular.contains(hotel.id))
        .toList();
  }

  List<Hotel> getSpecialOffersHotels() {
    return _hotels
        .where((hotel) => _homePageData.popular.contains(hotel.id))
        .toList();
  }

  List<Hotel> getNewestHotels() {
    return _hotels
        .where((hotel) => _homePageData.popular.contains(hotel.id))
        .toList();
  }

  //story section
  List<String> getStoryImage() {
    final shuffledHotels = List<Hotel>.from(_hotels)..shuffle();
    return shuffledHotels.take(3).map((hotels) => hotels.images[0]).toList();
  }

  final List<String> _titleStory = [
    "امکانات رفاهی",
    "لوکس ترین هتل ها",
    "بهترین قیمت",
  ];

  List<String> get titleStory => _titleStory;
}
