import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mic_pothole/api/loginpageapi.dart';
import 'package:mic_pothole/api/registrationapi.dart';
import 'package:mic_pothole/api/updateapi.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfileEditPage({required this.userData});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  late String _selectedGender;

  // Color Scheme
  final Color _primaryBlue = const Color(0xFF1976D2);
  final Color _backgroundWhite = const Color(0xFFF8F9FA);
  final Color _textColor = const Color(0xFF2C3E50);

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _nameController.text = (widget.userData['name'] ?? '').toString();
    _dobController.text = (widget.userData['dob'] ?? '').toString();
    _mobileNumberController.text = (widget.userData['mobileno'] ?? '').toString();
    _addressController.text = (widget.userData['address'] ?? '').toString();
    _selectedGender = (widget.userData['gender'] ?? 'Male').toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(primary: _primaryBlue),
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _primaryBlue,
        elevation: 4,
        title: const Text('Edit Profile', 
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_backgroundWhite, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildFormField('Name', _nameController, Icons.person_outline),
                const SizedBox(height: 20),
                _buildDatePickerField(),
                const SizedBox(height: 20),
                _buildGenderSelection(),
                const SizedBox(height: 20),
                _buildFormField('Mobile Number', _mobileNumberController, 
                    Icons.phone_iphone, TextInputType.phone),
                const SizedBox(height: 20),
                _buildFormField('Address', _addressController, Icons.location_on_outlined),
                const SizedBox(height: 30),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, 
      IconData icon, [TextInputType? inputType]) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: TextStyle(color: _textColor),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _primaryBlue.withOpacity(0.7)),
        labelStyle: TextStyle(color: _textColor.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildDatePickerField() {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      style: TextStyle(color: _textColor),
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Icon(Icons.calendar_today, color: _primaryBlue.withOpacity(0.7)),
        labelStyle: TextStyle(color: _textColor.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gender', 
                style: TextStyle(
                  color: _textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildGenderRadio('Male'),
                _buildGenderRadio('Female'),
                _buildGenderRadio('Other'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRadio(String gender) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(gender, style: TextStyle(color: _textColor)),
        value: gender,
        groupValue: _selectedGender,
        onChanged: (value) => setState(() => _selectedGender = value!),
        activeColor: _primaryBlue,
        contentPadding: EdgeInsets.zero,
        dense: true,
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Map<String, dynamic> updatedData = {
            'name': _nameController.text,
            'dob': _dobController.text,
            'gender': _selectedGender,
            'phone': _mobileNumberController.text,
            'username': _usernameController.text,
            'password': _passwordController.text,
            'place': _addressController.text,
            'lid': lid
          };
          await udateapi(updatedData, context);
        }
      },
      child: const Text('SAVE CHANGES',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _primaryBlue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        shadowColor: _primaryBlue.withOpacity(0.3),
      ),
    );
  }
}