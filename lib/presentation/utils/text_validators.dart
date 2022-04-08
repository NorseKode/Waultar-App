class TextValidators {
  static String? waultarServiceUsername(String? value) {
    if (value == null || value.isEmpty || value.length > 32) {
      return "Invalid service username";
    }

    return null;
  }
}