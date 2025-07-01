import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'database_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  List<Marker> _addressMarkers = [];
  final List<LatLng> fixedLocations = [
    LatLng(-19.921610, -43.938710), // Alameda Ezequiel Dias 321
    LatLng(-19.923600, -43.947500), // Rua Juiz de Fora 941
    LatLng(-19.927010, -43.930460), // R. Grão Pará 882
    LatLng(-19.869400, -43.926360), // Av. Cristiano Machado 4002
    LatLng(-19.990650, -44.000150), // R. Dr. Cristiano Rezende 2505
  ];

  final LatLng coletaLocation = LatLng(-19.9286, -43.9362);
  final String profileImageUrl = 'assets/images/lucasferreira.jpg';

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final locations = await DatabaseHelper.instance.getLocations();
    print('Locations do banco: $locations');

    final markersFromDB = locations.map((location) {
      final lat = (location['latitude'] as num).toDouble();
      final lng = (location['longitude'] as num).toDouble();

      return Marker(
        point: LatLng(lat, lng),
        width: 40,
        height: 40,
        child: const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 40,
        ),
      );
    }).toList();

    setState(() {
      _addressMarkers = markersFromDB;
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng centerPosition = _currentPosition ??
        (_addressMarkers.isNotEmpty
            ? _addressMarkers.first.point
            : coletaLocation);

    final fixedMarkers = fixedLocations.map((loc) {
      return Marker(
        point: loc,
        width: 40,
        height: 40,
        child: const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 40,
        ),
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        initialCenter: centerPosition,
        initialZoom: 14,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            ..._addressMarkers,
            ...fixedMarkers,
            if (_currentPosition != null)
              Marker(
                point: _currentPosition!,
                width: 60,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      profileImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
