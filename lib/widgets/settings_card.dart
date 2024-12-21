import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final VoidCallback onLogout;

  const SettingsCard({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 6.0)
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings,
                color: Colors.blueAccent, size: 28.0),
            title: const Text('Settings',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            onTap: () {},
            tileColor: Colors.grey[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          const Divider(height: 1.0),
          ListTile(
            leading: const Icon(Icons.exit_to_app,
                color: Colors.redAccent, size: 28.0),
            title: const Text('Sign Out',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            onTap: onLogout,
            tileColor: Colors.grey[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        ],
      ),
    );
  }
}
