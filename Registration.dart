import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mic_pothole/api/registrationapi.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _placecontroller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  bool _obscurePassword = true;
  ValueNotifier<String> _selectedGenderNotifier = ValueNotifier<String>('Male');
  final _blueGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Color(0xFF1976D2),
            onPrimary: Colors.white,
          ),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
        title: Text('Register Now', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: _blueGradient),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE3F2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField(
                    controller: _nameController,
                    label: 'Name',
                    icon: Icons.person_outline,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                  ),
                  SizedBox(height: 16),
                  _buildDateField(),
                  SizedBox(height: 16),
                  _buildGenderSelector(),
                  SizedBox(height: 16),
                  _buildInputField(
                    controller: _mobileNumberController,
                    label: 'Mobile Number',
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter mobile number' : null,
                  ),
                  SizedBox(height: 16),
                  _buildInputField(
                    controller: _placecontroller,
                    label: 'Address',
                    icon: Icons.location_on_outlined,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter address' : null,
                  ),
                  SizedBox(height: 16),
                  _buildInputField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.alternate_email_outlined,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter username' : null,
                  ),
                  SizedBox(height: 16),
                  _buildPasswordField(),
                  SizedBox(height: 24),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xFF1976D2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Please select date of birth' : null,
    );
  }

  Widget _buildGenderSelector() {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedGenderNotifier,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8),
            child: Text('Gender', style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
          ),
          Row(
            children: [
              Expanded(
                child: _buildGenderOption('Male', value),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildGenderOption('Female', value),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildGenderOption('Other', value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, String selectedValue) {
    final isSelected = gender == selectedValue;
    return GestureDetector(
      onTap: () => _selectedGenderNotifier.value = gender,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1976D2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Color(0xFF1976D2) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(gender,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock_outlined, color: Color(0xFF1976D2)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey[600],
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Please enter password' : null,
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: _blueGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Map<String, dynamic> registrationData = {
              'name': _nameController.text,
              'dob': _dobController.text,
              'gender': _selectedGenderNotifier.value,
              'mobileno': _mobileNumberController.text,
              'email': _usernameController.text,
              'password': _passwordController.text,
              'address': _placecontroller.text,
            };
            await regapi(registrationData, context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text('REGISTER NOW',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            )),
      ),
    );
  }
}