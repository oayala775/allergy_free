String? validatePassword(String password, String reenterPassword) {
  final RegExp passwordRegex = RegExp(r'^[^\s,<>;]+$');

  if (password.isEmpty || reenterPassword.isEmpty) {
    return 'Please enter and re-enter your password.';
  }
  if (password != reenterPassword) {
    return 'Passwords do not match.';
  }
  if (!passwordRegex.hasMatch(password)) {
    return 'Password cannot contain spaces, commas, or semicolons.';
  }
  return null;
}
