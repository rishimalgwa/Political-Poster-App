String? validatePhoneNumber(String? value) {
  // Basic validation: check if the phone number is 10 digits long and contains only numbers
  final phonePattern = RegExp(r'^[0-9]{10}$');
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  } else if (!phonePattern.hasMatch(value)) {
    return 'Please enter a valid 10-digit phone number';
  }
  return null;
}
