// screens/rental_address_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

import 'rental_review_page.dart';

class RentalAddressPage extends StatelessWidget {
  final String itemName;
  final String category;
  final double rentPerDay;
  final String renterName;
  final String renterPhone;

  RentalAddressPage({
    required this.itemName,
    required this.category,
    required this.rentPerDay,
    required this.renterName,
    required this.renterPhone,
  });

  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        backgroundColor: kThemeColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Full Address',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kThemeColor),
                  ),
                ),
                maxLines: 3,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kThemeColor),
                  ),
                ),
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(
                  labelText: 'ZIP Code',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kThemeColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.to(() => RentalReviewPage(
                          itemName: itemName,
                          category: category,
                          rentPerDay: rentPerDay,
                          renterName: renterName,
                          renterPhone: renterPhone,
                          address: _addressController.text,
                          city: _cityController.text,
                          zipCode: _zipCodeController.text,
                        ));
                  }
                },
                child: Text('Review'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kThemeColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
