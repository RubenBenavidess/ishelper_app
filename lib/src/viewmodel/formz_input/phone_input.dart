import 'package:formz/formz.dart';

/// Validation errors for the [PhoneInput].
enum PhoneInputError {
  /// The input is empty.
  empty,
  /// The input contains characters that are not digits or standard phone separators.
  invalidFormat,
  /// The number of digits is outside the valid range (6-15).
  invalidLength,
}

extension PhoneInputErrorMessage on PhoneInputError{
  String get errorMessage {
    switch(this){
      case PhoneInputError.empty:
        return "Campo obligatorio.";
      case PhoneInputError.invalidFormat:
        return "Formato inválido.";
      case PhoneInputError.invalidLength:
        return "Número inválido.";
    }
  }
}

/// A form input for a phone number.
class PhoneInput extends FormzInput<String, PhoneInputError>
    with FormzInputErrorCacheMixin {

  /// Creates a pure [PhoneInput] with an empty value.
  PhoneInput.pure() : super.pure('');

  /// Creates a dirty [PhoneInput] with the given [value].
  PhoneInput.dirty([super.value = '']) : super.dirty();

  /// A regular expression that allows only digits, spaces, hyphens, and parentheses.
  /// This is a lenient regex as phone number formats vary significantly by country.
  static final _allowedCharactersRegex = RegExp(r'^[0-9\s\-\(\)]+$');

  @override
  PhoneInputError? validator(String value) {

    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return PhoneInputError.empty;
    if (!_allowedCharactersRegex.hasMatch(sanitizedValue)) return PhoneInputError.invalidFormat;

    final digitsOnly = sanitizedValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 6 || digitsOnly.length > 15) return PhoneInputError.invalidLength;


    return null;
  }
}