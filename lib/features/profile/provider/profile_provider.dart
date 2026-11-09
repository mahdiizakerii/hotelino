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
  }

  Future<void> loadUserProfile() async {
    _profile = await _profileRepository.fetchProfile();
  }

  // recently---------------------------------------------------------------------------------------

  final List<String> _recentlyViewedHotel = [];
  List<Hotel> get recentlyViewedHotel =>
      _hotel.where((hotel) => recentlyViewedHotel.contains(hotel.id)).toList();

  void addRecentlyViwed(String hotelId) {
    if (!recentlyViewedHotel.contains(hotelId)) {
      _recentlyViewedHotel.add(hotelId);
      notifyListeners();
    } else {
      _recentlyViewedHotel.remove(hotelId);
      _recentlyViewedHotel.add(hotelId);
      notifyListeners();
    }
  }
}
