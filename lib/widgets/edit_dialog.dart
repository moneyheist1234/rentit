import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class ProfileEditDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Future<void> Function() onSave;

  const ProfileEditDialog({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.onSave,
  }) : super(key: key);

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  bool _isLoading = false;
  bool _isSaveEnabled = false;
  final _formKey = GlobalKey<FormState>();

  void _updateSaveButtonState() {
    final name = widget.nameController.text;
    final phone = widget.phoneController.text;
    setState(() {
      _isSaveEnabled = name.isNotEmpty && phone.length == 10;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(_updateSaveButtonState);
    widget.phoneController.addListener(_updateSaveButtonState);
    _updateSaveButtonState(); // Initial check
  }

  Future<void> _handleSave() async {
    if (!_isSaveEnabled || !_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onSave(); // Execute the save logic

      // Hide keyboard
      FocusScope.of(context).unfocus();

      // Show success message
      Get.snackbar(
        "Success",
        "Profile updated successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        duration: Duration(seconds: 2),
      );

      // Close dialog after success
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save profile data: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        duration: Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.nameController.removeListener(_updateSaveButtonState);
    widget.phoneController.removeListener(_updateSaveButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: kThemeColor.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: widget.nameController,
                  label: 'Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: widget.phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  isPhone: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: _isLoading || !_isSaveEnabled ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: kThemeColor.withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPhone = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kThemeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: kThemeColor.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.number : TextInputType.text,
        maxLength: isPhone ? 10 : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: kThemeColor.withOpacity(0.7),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: kThemeColor.withOpacity(0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: kThemeColor.withOpacity(0.9),
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          counterText: isPhone ? '' : null,
          errorStyle: TextStyle(
            color: Colors.red.shade400,
            fontSize: 12,
          ),
        ),
        cursorColor: kThemeColor.withOpacity(0.8),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
