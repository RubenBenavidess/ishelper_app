import 'package:formz/formz.dart';

/// EmailInput errors variants.
enum EmailInputError {
  /// Empty input.
  empty,
  /// Invalid email format.
  invalidFormat
}

/// Class that represents the email input validator.
class EmailInput extends FormzInput<String, EmailInputError> 
  with FormzInputErrorCacheMixin {

  /// Pure constructor: For empty data.
  EmailInput.pure() : super.pure('');

  /// Dirty constructor: For filled data.
  EmailInput.dirty([super.value = '']) : super.dirty();

  /// Regex expression to validate the email format.
  static final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  /// Validates the input data.
  ///
  /// [value] is the input data.
  ///
  /// Returns the email input error or null (no error).
  @override
  EmailInputError? validator(String value) {
    
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return EmailInputError.empty;
    if (!_emailRegex.hasMatch(sanitizedValue)) return EmailInputError.invalidFormat;

    return null;
  }
}