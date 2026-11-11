import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() {
    return _SettingsViewState();
  }
}

class _SettingsViewState extends State<SettingsView> {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronNumberController;
  bool _emailPreferences = false;

  String _confirmationMessage = '';

  Future<void> _loadPreferences() async {
    final savedAddress = await _prefs.getString('customerAddress');
    final savedEmail = await _prefs.getString('customerEmail');
    final savedPatronNumber = await _prefs.getString('patronNumber');
    final savedEmailNews = await _prefs.getBool('emailNews');

    if (!mounted) return;

    setState(() {
      _addressController.text = savedAddress ?? '';
      _emailController.text = savedEmail ?? '';
      _patronNumberController.text = savedPatronNumber ?? '';
      _emailPreferences = savedEmailNews ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();
    final String patronNumber = _patronNumberController.text.trim();

    await _prefs.setString('customerAddress', address);
    await _prefs.setString('customerEmail', email);
    await _prefs.setString('patronNumber', patronNumber);
    await _prefs.setBool('emailNews', _emailPreferences);

    if (!mounted) return;

    setState(() {
      _confirmationMessage = 'Settings saved successfully!';
    });
  }

  Future<void> _cancelSettings() async {
    await _loadPreferences();

    if (!mounted) return;

    setState(() {
      _confirmationMessage = 'Changes canceled.';
    });
  }

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _patronNumberController = TextEditingController();

    _loadPreferences();
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
