import 'package:formz/formz.dart';

/// CityInput errors variants.
enum CityInputError {
  /// Empty input.
  empty,
  /// Exceeded defined length.
  tooLong,
  /// Invalid format: only alphabetical characters.
  invalidFormat
}

/// Class that represents the city input validator.
class CityInput extends FormzInput<String, CityInputError> 
    with FormzInputErrorCacheMixin {

  /// Pure constructor: For empty data.
  CityInput.pure() : super.pure('');

  /// Dirty constructor: For filled data.
  CityInput.dirty([super.value = '']) : super.dirty();

  /// Regex expression to validate the city name.
  static final _cityRegex = RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s'-]+$");

  /// Validates the input data.
  ///
  /// [value] is the input data.
  ///
  /// Returns the city input error or null (no error).
  @override
  CityInputError? validator(String value) {
    
    final sanitizedValue = value.trim();

    if (sanitizedValue.isEmpty) return CityInputError.empty;
    if (sanitizedValue.length > 60) return CityInputError.tooLong;
    if (!_cityRegex.hasMatch(sanitizedValue)) return CityInputError.invalidFormat;

    return null;
  }
}