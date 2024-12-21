import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../models/location_model.dart';
import '../repository/location_repository/location_repository.dart';

class LocationController extends GetxController {
  final LocationRepository _repository = LocationRepository();
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }
  }

  Future<void> getCurrentLocation(String email) async {
    try {
      isLoading.value = true;

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentPosition.value = position;

      // Save to Firestore
      await _repository.saveLocation(
        LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
        email,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<LocationModel>> getLocationHistory(String email) {
    return _repository.getLocations(email);
  }
}
