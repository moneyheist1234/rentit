// screens/rent_adding_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentit/screens/rental_image_page.dart';
import '../constants.dart';

import '../controllers/renter_controller.dart'; // Note: fixed the import name

class RentAddingForm extends StatelessWidget {
  RentAddingForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final RentalController controller = Get.put(RentalController());

  final _itemNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _rentPerDayController = TextEditingController();
  final _renterNameController = TextEditingController();
  final _renterPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rental Item'),
        backgroundColor: kThemeColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _itemNameController,
                label: 'Item Name',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _categoryController,
                label: 'Category',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _rentPerDayController,
                label: 'Rent per Day',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v?.isEmpty ?? true) return 'Required';
                  if (double.tryParse(v!) == null) return 'Enter valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _renterNameController,
                label: 'Renter Name',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _renterPhoneController,
                label: 'Renter Phone',
                keyboardType: TextInputType.phone,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.to(() => RentalImagesPage(
                          itemName: _itemNameController.text,
                          category: _categoryController.text,
                          rentPerDay: double.parse(_rentPerDayController.text),
                          renterName: _renterNameController.text,
                          renterPhone: _renterPhoneController.text,
                        ));
                  }
                },
                child: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kThemeColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kThemeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kThemeColor, width: 2),
        ),
      ),
    );
  }
}
