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

  Future<List<LatLng>?> getRuta(double currentLat, double currentLon,
      double destinoLat, double destinoLon) async {
    try {
      RouteRequest opcion = RouteRequest(
          coordinates: [(currentLon, currentLat), (destinoLon, destinoLat)],
          overview: OsrmOverview.full);

      RouteResponse ruta = await osrm.route(opcion);

      return ruta.routes.first.geometry!.lineString!.coordinates.map((e) {
        var location = e.toLocation();
        return LatLng(location.lat, location.lng);
      }).toList();
    } catch (e) {
      return null;
    }
  }
}
