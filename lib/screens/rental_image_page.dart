// screens/rental_image_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';

import '../controllers/renter_controller.dart';
import 'rental_address_page.dart';

class RentalImagesPage extends StatelessWidget {
  final String itemName;
  final String category;
  final double rentPerDay;
  final String renterName;
  final String renterPhone;

  RentalImagesPage({
    Key? key,
    required this.itemName,
    required this.category,
    required this.rentPerDay,
    required this.renterName,
    required this.renterPhone,
  }) : super(key: key);

  final RentalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Images'),
        backgroundColor: kThemeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add 2 images of your rental item',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...controller.selectedImages.map((image) => Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: kThemeColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.file(image, fit: BoxFit.cover),
                        )),
                    if (controller.selectedImages.length < 2)
                      _buildAddImageButton(),
                  ],
                )),
            const Spacer(),
            Obx(() => ElevatedButton(
                  onPressed: controller.selectedImages.length == 2
                      ? () => Get.to(() => RentalAddressPage(
                            itemName: itemName,
                            category: category,
                            rentPerDay: rentPerDay,
                            renterName: renterName,
                            renterPhone: renterPhone,
                          ))
                      : null,
                  child: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kThemeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildAddImageButton() {
    return InkWell(
      onTap: () => _showImageSourceDialog(),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: kThemeColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.add_photo_alternate, size: 50, color: kThemeColor),
      ),
    );
  }

  void _showImageSourceDialog() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
