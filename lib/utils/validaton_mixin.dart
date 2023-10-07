mixin validationMixin {
  String? emptyValidation(String? value) {
    if (value == null || value.toLowerCase().trim().isEmpty) {
      return "Ini Wajib Diisi";
    }
    return null;
  }
}
