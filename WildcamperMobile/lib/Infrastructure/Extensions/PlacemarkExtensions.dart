import 'package:geocoding/geocoding.dart';
import 'package:recase/recase.dart';

extension PlacemarkExtensions on Placemark {
  String get city =>
      "${this.isoCountryCode} ${this.postalCode}, ${this.locality}";

  String get region =>
      "${this.subAdministrativeArea.sentenceCase}, ${this.administrativeArea.sentenceCase}";
}
