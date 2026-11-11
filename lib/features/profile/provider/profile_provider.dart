import 'package:flutter/material.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/data/repository/hotel_repository.dart';
import 'package:hotelino/features/profile/repository/models/profile.dart';
import 'package:hotelino/features/profile/repository/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _profileRepository;
  final HotelRepository _hotelRepository;
  List<Hotel> _hotel = [];
  Profile? _profile;
  Profile? get profile => _profile;

  ProfileProvider(this._profileRepository, this._hotelRepository) {
    loadUserProfile();
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    _hotel = await _hotelRepository.fetchHotels();
    notifyListeners();
  }

  Future<void> loadUserProfile() async {
    _profile = await _profileRepository.fetchProfile();
    notifyListeners();
  }

  // recently--------------------------------------------------------------------------------------------------------------------

  final List<String> _recentlyViewedHotel = [];
  List<Hotel> get recentlyViewedHotel {
    return _hotel
        .where((hotel) => _recentlyViewedHotel.contains(hotel.id))
        .toList();
  }

  void addRecentlyViewed(String hotelId) {
    if (_recentlyViewedHotel.contains(hotelId)) {
      _recentlyViewedHotel.remove(hotelId);
    }
    _recentlyViewedHotel.add(hotelId);
    notifyListeners();
  }

  void addRecentlyViwed(String hotelId) => addRecentlyViewed(hotelId);
}
