import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/features/profile/repository/models/profile.dart';

class ProfileRepository {
  Future<Profile> fetchProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Profile(
      id: "29768403424",
      name: "مهدی ذاکری",
      email: "mahdizakeri044@gmail.ccom",
      avatarUrl: AppConstants.avatarProfile,
      phoneNumber: "09330859463",
      location: "بندرعباس",
      bio: "علاقه مند به طبیعتگردی",
      booking: 8,
      favorite: 6,
      notification: 4,
    );
  }
}
