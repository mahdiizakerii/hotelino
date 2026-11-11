import 'package:flutter/foundation.dart';
import 'package:hotelino/features/booking/data/models/booking_model.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BookingProvider with ChangeNotifier {
  final BookingModel _booking = BookingModel();
  BookingModel get booking => _booking;

  void setName(String value) {
    _booking.fullName = value;
    notifyListeners();
  }

  void setNumber(String value) {
    _booking.phoneNumber = value;
    notifyListeners();
  }

  void setNumberOfGuests(String value) {
    _booking.numberOfGuests = value;
    notifyListeners();
  }

  void setRangeDate(JalaliRange value) {
    _booking.checkInOutRange = value;
    notifyListeners();
  }
}
