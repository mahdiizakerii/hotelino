import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BookingModel {
  String fullName;
  String destination;
  JalaliRange? checkInOutRange;
  String numberOfGuests;
  String phoneNumber;

  BookingModel({
    this.fullName = '',
    this.destination = '',
    this.numberOfGuests = '',
    this.checkInOutRange,
    this.phoneNumber = '',
  });
}
