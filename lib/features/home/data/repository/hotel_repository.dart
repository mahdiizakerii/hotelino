import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/shared/services/json_data_service.dart';

class HotelRepository {
  final JsonDataService jsonDataService;

  HotelRepository({required this.jsonDataService});

  Future<Future<Iterable<Hotel>>> fetchHotels() async {
    return jsonDataService.loadHotels();
  }

  Future<Hotel> getHotelId(String id) {
    return jsonDataService.loadHotels().then((value) {
      return value.firstWhere((hotel) => hotel.id == id);
    });
  }
}
