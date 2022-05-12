class TextValidators {
  static String? waultarServiceUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "A username is required";
    }
    if (value.length > 32 || value.length < 2) {
      return "Username must be between 2 and 32 characters";
    }

    return null;
  }
}
