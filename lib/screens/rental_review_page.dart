// screens/rental_review_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../controllers/renter_controller.dart';

class RentalReviewPage extends StatelessWidget {
  final String itemName;
  final String category;
  final double rentPerDay;
  final String renterName;
  final String renterPhone;
  final String address;
  final String city;
  final String zipCode;

  RentalReviewPage({
    required this.itemName,
    required this.category,
    required this.rentPerDay,
    required this.renterName,
    required this.renterPhone,
    required this.address,
    required this.city,
    required this.zipCode,
  });

  final RentalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Details'),
        backgroundColor: kThemeColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection('Item Details', [
              _buildDetail('Name', itemName),
              _buildDetail('Category', category),
              _buildDetail(
                  'Rent per Day', 'USD ${rentPerDay.toStringAsFixed(2)}'),
            ]),
            SizedBox(height: 16),
            _buildSection('Renter Details', [
              _buildDetail('Name', renterName),
              _buildDetail('Phone', renterPhone),
            ]),
            SizedBox(height: 16),
            _buildSection('Address', [
              _buildDetail('Full Address', address),
              _buildDetail('City', city),
              _buildDetail('ZIP Code', zipCode),
            ]),
            SizedBox(height: 16),
            _buildSection('Images', [
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Image.file(controller.selectedImages[index]),
                    );
                  },
                ),
              ),
            ]),
            SizedBox(height: 24),
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.submitRental(
                            itemName: itemName,
                            category: category,
                            rentPerDay: rentPerDay,
                            renterName: renterName,
                            renterPhone: renterPhone,
                            address: address,
                            city: city,
                            zipCode: zipCode,
                          ),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kThemeColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kThemeColor,
              ),
            ),
            SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
