import 'package:formz/formz.dart';

/// PhoneInput errors variants.
enum PhoneInputError {
  /// Empty input.
  empty,
  /// Invalid format: contains characters that are not digits or standard separators.
  invalidFormat,
  /// Invalid length: the count of digits is outside the standard range (usually 7-15).
  invalidLength,
}

/// Class that represents the phone number input validator.
class PhoneInput extends FormzInput<String, PhoneInputError> 
  with FormzInputErrorCacheMixin {

  /// Pure constructor: For empty data.
  PhoneInput.pure() : super.pure('');

  /// Dirty constructor: For filled data.
  PhoneInput.dirty([super.value = '']) : super.dirty();

  /// Regex to ensure the input only contains digits, spaces, hyphens, or parentheses.
  /// We do not enforce a specific structure (like (XXX) XXX-XXXX) because it varies by country.
  static final _allowedCharactersRegex = RegExp(r'^[0-9\s\-\(\)]+$');

  /// Validates the input data.
  ///
  /// [value] is the input data.
  ///
  /// Returns the phone input error or null (no error).
  @override
  PhoneInputError? validator(String value) {
    
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return PhoneInputError.empty;
    if (!_allowedCharactersRegex.hasMatch(sanitizedValue)) {
      return PhoneInputError.invalidFormat;
    }

    final digitsOnly = sanitizedValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 6 || digitsOnly.length > 15) {
      return PhoneInputError.invalidLength;
    }

    return null;
  }
}