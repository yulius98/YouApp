import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/astrology_utils.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String? _selectedGender;
  bool _loading = false;
  String? _error;
  String _zodiac = '--';
  String _horoscope = '--';

  @override
  void initState() {
    super.initState();
    // load profile when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181F26),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 40, 49),
        elevation: 0,
        title: const Text('About', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          TextButton(
            onPressed: _saveAndUpdate,
            child: const Text('Save & Update', style: TextStyle(color: Color(0xFFF6E392), fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error loading profile: $_error', style: const TextStyle(color: Colors.red)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFF232B34),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add, color: Color(0xFFF6E392), size: 40),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Add image', style: TextStyle(color: Colors.white70, fontSize: 16)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildLabelField('Display name:', _nameController, hint: 'Enter name'),
                      const SizedBox(height: 16),
                      _buildGenderDropdown(),
                      const SizedBox(height: 16),
                      _buildLabelField('Birthday:', _birthdayController, hint: 'DD MM YYYY', readOnly: true, onTap: _pickDate),
                      const SizedBox(height: 16),
                      _buildStaticField('Horoscope:', _horoscope),
                      const SizedBox(height: 16),
                      _buildStaticField('Zodiac:', _zodiac),
                      const SizedBox(height: 16),
                      _buildLabelField('Height:', _heightController, hint: 'Add height', keyboardType: TextInputType.number),
                      const SizedBox(height: 16),
                      _buildLabelField('Weight:', _weightController, hint: 'Add weight', keyboardType: TextInputType.number),
                    ],
                  ),
                ),
    );
  }

  Widget _buildLabelField(String label, TextEditingController controller, {String? hint, bool readOnly = false, VoidCallback? onTap, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF232B34),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white24),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white24),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF232B34),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Text(value, style: const TextStyle(color: Colors.white38, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender:', style: TextStyle(color: Colors.white70, fontSize: 16)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF232B34),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              dropdownColor: const Color(0xFF232B34),
              hint: const Text('Select Gender', style: TextStyle(color: Colors.white38)),
              style: const TextStyle(color: Colors.white),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFF6E392),
              onPrimary: Colors.black,
              surface: Color(0xFF232B34),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF181F26),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = "${picked.day.toString().padLeft(2, '0')} ${picked.month.toString().padLeft(2, '0')} ${picked.year}";
        _zodiac = AstrologyUtils.getZodiac(picked);
        _horoscope = AstrologyUtils.getHoroscope(picked);
      });
    }
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final token = widget.token;

      // Call API service
      final data = await ApiService.getProfile(token);

      // Try common fields for username
      final displayName = (data['username'] ?? data['name'] ?? data['display_name'] ?? '') as String;

      if (displayName.isNotEmpty && mounted) {
        setState(() {
          _nameController.text = displayName;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveAndUpdate() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final token = widget.token;

      // Prepare profile data
      String birthdayFormatted = _birthdayController.text;
      if (_birthdayController.text.isNotEmpty) {
        final parts = _birthdayController.text.split(' ');
        if (parts.length == 3) {
          final day = parts[0].padLeft(2, '0');
          final month = parts[1].padLeft(2, '0');
          final year = parts[2];
          birthdayFormatted = '$year-$month-$day';
        }
      }

      final profileData = {
        'name': _nameController.text,
        'birthday': birthdayFormatted,
        'height': int.tryParse(_heightController.text) ?? 0,
        'weight': int.tryParse(_weightController.text) ?? 0,
        'interests': [], // Empty array as no interests field in UI yet
      };

      // Call API service
      final response = await ApiService.updateProfile(token, profileData);

      // Show success message if available
      if (response.containsKey('message')) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'])),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
}