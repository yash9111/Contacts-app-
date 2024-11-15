import 'package:contacts_app/features/contacts/domain/entity/geo.dart';

class GeoModel extends Geo {
  GeoModel({
    required super.lat,
    required super.lng,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
