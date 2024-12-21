import 'package:flutter/material.dart';
import 'package:rentit/widgets/ad_banner.dart'; // Ensure this widget is properly implemented
import '../bars/custom_app_bar.dart'; // CustomAppBar widget
import '../bars/custom_fab.dart'; // Custom Floating Action Button
import '../bars/footer_bar.dart'; // Footer bar
import '../bars/side_menu.dart';
import '../screens/rent_adding_form.dart'; // Side menu drawer

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  _HelpAndSupportState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _commentController = TextEditingController();
  bool _loading = false;

  void _submitForm() async {
    setState(() {
      _loading = true; // Set loading to true when submitting
    });

    // Simulate a delay for the submission process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _loading = false; // Set loading to false after submission
    });

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your complaint has been submitted')),
    );

    // Clear the text fields
    _nameController.clear();
    _phoneController.clear();
    _commentController.clear();
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    _nameController.dispose();
    _phoneController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Card dimensions matching the grid card size
    const cardWidth = 180.0;
    const cardHeight = 220.0;

    return Scaffold(
      drawer: const SideMenu(), // Assuming SideMenu contains the drawer menu
      appBar: const CustomAppBar(), // Custom AppBar implementation
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name TextField
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Phone Number TextField (added)
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),

                // Complaint TextField
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'Your Complaint',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 24.0),

                // Big Banner Ad - Adjusted to look like a card
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: BannerAdWidget(), // Adjust the BannerAdWidget here
                ),
                const SizedBox(height: 24.0),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87, // Theme color
                      minimumSize: const Size(120, 40), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            )),
                  ),
                ),
                const SizedBox(height: 24.0),

                // Another Big Banner Ad
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: BannerAdWidget(), // Adjust the BannerAdWidget here
                ),

                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar(), // Custom footer bar implementation
      floatingActionButton: CustomFAB(
        targetScreen: RentAddingForm(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset:
          false, // Avoid resizing the body when the keyboard pops up
    );
  }
}
