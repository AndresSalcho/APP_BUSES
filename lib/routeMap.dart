import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm/osrm.dart';

class Routemap {
  final osrm = Osrm();

  Future<Position> determinarPermisos() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<LatLng?> getLocation() async {
    try {
      Position? pos = await determinarPermisos();
      return LatLng(pos.latitude, pos.longitude);
    } catch (e) {
      return null;
    }
  }
}
