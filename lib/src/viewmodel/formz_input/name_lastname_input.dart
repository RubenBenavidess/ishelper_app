import 'package:formz/formz.dart';

/// NameInput errors variants.
enum NameOrLastNameInputError {
  /// Empty input.
  empty, 
  /// Exceeded defined length.
  invalidLength, 
  /// Invalid format: only alphabetical characters.
  invalidFormat
}

/// Class that represents the name or last name input validator.
class NameOrLastNameInput extends FormzInput<String, NameOrLastNameInputError>
  with FormzInputErrorCacheMixin{

  /// Pure constructor: For empty data.
  NameOrLastNameInput.pure() : super.pure('');
  /// Dirty constructor: For filled data.
  NameOrLastNameInput.dirty([super.value = '']) : super.dirty();

  /// Regex expression to validate the only alphabetical characters for the name input.
  static final _dataRegex = RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s'-]+$");

  /// Validates the input data.
  ///
  /// [value] is the input data.
  ///
  /// Returns the name input error or null (no error).
  @override
  NameOrLastNameInputError? validator(String value) {

    final sanitizedValue = value.trim();

    if(sanitizedValue.isEmpty) return NameOrLastNameInputError.empty;
    if(sanitizedValue.length > 35) return NameOrLastNameInputError.invalidLength;
    if(!_dataRegex.hasMatch(sanitizedValue)) return NameOrLastNameInputError.invalidFormat;

    return null;
  }

}