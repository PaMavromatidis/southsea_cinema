import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/user_settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() {
    return _SettingsViewState();
  }
}

class _SettingsViewState extends State<SettingsView> {
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronNumberController;
  bool _emailPreferences = false;

  String _confirmationMessage = '';
  UserSettings? _savedSettings;

  void _saveSettings() {
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();
    final String patronNumber = _patronNumberController.text.trim();

    final UserSettings newSettings = UserSettings(
      address: address,
      email: email,
      patronNumber: patronNumber,
      emailPreferences: _emailPreferences,
    );

    setState(() {
      _savedSettings = newSettings;
      _confirmationMessage = 'Settings saved successfully!';
    });
  }

  void _cancelSettings() {
    setState(() {
      _addressController.text = _savedSettings?.address ?? '';
      _emailController.text = _savedSettings?.email ?? '';
      _patronNumberController.text = _savedSettings?.patronNumber ?? '';
      _emailPreferences = _savedSettings?.emailPreferences ?? false;
      _confirmationMessage = 'Changes canceled.';
    });
  }

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _patronNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _patronNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Customer Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _patronNumberController,
                decoration: const InputDecoration(
                  labelText: 'Patron Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Switch(
                    value: _emailPreferences,
                    onChanged: (bool value) {
                      setState(() {
                        _emailPreferences = value;
                      });
                    },
                  ),
                  const Text('Receive news by email'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('SAVE SETTINGS'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _cancelSettings,
                child: const Text('CANCEL'),
              ),
              const SizedBox(height: 16),
              Text(
                _confirmationMessage,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ])));
  }
}
