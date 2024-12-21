import 'package:flutter/material.dart';
import 'package:rentit/constants.dart';

class DropdownList extends StatefulWidget {
  const DropdownList({super.key});

  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  String? _selectedLocation;
  String? _selectedCategory;

  final List<String> _locations = ['New York', 'Los Angeles', 'Chicago'];
  final List<String> _categories = [
    'All',
    'Electronics',
    'Clothing',
    'Furniture'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedLocation,
            hint: Row(
              children: [
                Icon(Icons.location_on, color: kThemeColor),
                SizedBox(width: 8.0),
                Text('Location'),
              ],
            ),
            items: _locations.map((location) {
              return DropdownMenuItem<String>(
                value: location,
                child: Text(location),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLocation = value;
              });
            },
            icon: Icon(Icons.arrow_drop_down,
                color: kThemeColor), // Custom dropdown arrow color
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), // Circular borders
                borderSide: BorderSide.none, // Remove default border
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Padding inside the dropdown
            ),
          ),
        ),
        SizedBox(width: 16.0), // Space between dropdowns
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            hint: Row(
              children: [
                Icon(Icons.category, color: kThemeColor),
                SizedBox(width: 8.0),
                Text('Category'),
              ],
            ),
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            icon: Icon(Icons.arrow_drop_down,
                color: kThemeColor), // Custom dropdown arrow color
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), // Circular borders
                borderSide: BorderSide.none, // Remove default border
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Padding inside the dropdown
            ),
          ),
        ),
      ],
    );
  }
}
