import 'package:flutter/material.dart';
import 'package:hotelino/features/home/data/models/home_page_data.dart';

class AppConstants {
  static const String baseUrlImage = "https://dunijet.ir/contents/ext/";
  static const String hotelsData = "assets/data/hotels.json";
  static const String avatarProfile =
      "https://avatars.githubusercontent.com/u/349419237?v=4";
}

class AppColors {
  static const Color primary = Color(0xFFB27258);
  // light theme colors
  static const Color lightText = Colors.black;
  static const Color lightHint = Color(0xFF9196A3);
  static const Color lightInputFill = Color(0xFF9196A3);
  static const Color lightBorder = Color(0xFF9196A3);
  static const Color lightFocusedBorder = Colors.brown;
  // dart theme colors
  static const Color darkText = Colors.white;
  static const Color darkHint = Color(0xFF9196A3);
  static const Color darkInputFill = Color(0xFF303030);
  static const Color darkBorder = Color(0xFF707070);
  static const Color darkFocusedBorder = Colors.brown;
  static const Color darkButton = Color(0xFF5D4037);
}

class HomePageDataConstants {
  static const List<String> _favoriteHotelIds = ["1", "3", "5", "7"];
  static const List<String> _discountedHotelIds = ["2", "4", "6", "8"];
  static const List<String> _recentlyViewedHotelIds = ["1", "4", "9"];
  static const List<String> _popularHotelIds = ["3", "6", "9", "10"];
  static const List<String> _specialOfferHotelIds = ["5", "7", "10"];
  static const List<String> _newestHotelIds = ["8", "9", "10"];

  static HomePageData get homePageData => HomePageData(
    discounted: _discountedHotelIds,
    recentlyViewed: _recentlyViewedHotelIds,
    popular: _popularHotelIds,
    specialOffers: _specialOfferHotelIds,
    newes: _newestHotelIds,
    favorites: _favoriteHotelIds,
  );
}
