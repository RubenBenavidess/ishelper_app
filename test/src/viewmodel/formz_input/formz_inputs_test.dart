import 'package:flutter_test/flutter_test.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/phone_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_code_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/contact_reason_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';

void main() {

  // --------------- NAMEORLASTNAME INPUT

  group('NameOrLastNameInput Validation', () {

    test('| Pure NameOrLastNameInput is not valid.', () {
      final nameInput = NameOrLastNameInput.pure();
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isFalse);
    });

    test('| Valid single name returns no error.', () {
      final nameInput = NameOrLastNameInput.dirty('Juan');
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Valid name and surname returns no error.', () {
      final nameInput = NameOrLastNameInput.dirty('Juan Pablo');
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with exactly 35 characters is valid.', () {
      final nameInput = NameOrLastNameInput.dirty('A' * 35);
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with less than 35 characters is valid.', () {
      final nameInput = NameOrLastNameInput.dirty('A' * 34);
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with hyphens is valid', () {
      final nameInput = NameOrLastNameInput.dirty('Juan-Carlos');
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with apostrophes is valid', () {
      final nameInput = NameOrLastNameInput.dirty("Juan'Carlos");
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with accented characters is valid', () {
      final nameInput = NameOrLastNameInput.dirty('Pérez');
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with ñ character is valid', () {
      final nameInput = NameOrLastNameInput.dirty('Niño');
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Name with trailing/leading spaces is trimmed and valid', () {
      final nameInput = NameOrLastNameInput.dirty('  Juan  ');
      expect(nameInput.displayError, isNull);
      expect(nameInput.isValid, isTrue);
    });

    test('| Empty name returns empty error.', () {
      final nameInput = NameOrLastNameInput.dirty('');
      expect(nameInput.displayError, NameOrLastNameInputError.empty);
      expect(nameInput.isValid, isFalse);
    });

    test('| Name exceeding max length returns invalidLength error.', () {
      final nameInput = NameOrLastNameInput.dirty('A' * 36);
      expect(nameInput.displayError, NameOrLastNameInputError.invalidLength);
      expect(nameInput.isValid, isFalse);
    });

    test('| Name with numbers returns invalidFormat error.', () {
      final nameInput = NameOrLastNameInput.dirty('Juan123');
      expect(nameInput.displayError, NameOrLastNameInputError.invalidFormat);
      expect(nameInput.isValid, isFalse);
    });

    test('| Name with special characters returns invalidFormat error.', () {
      final nameInput = NameOrLastNameInput.dirty('Juan@');
      expect(nameInput.displayError, NameOrLastNameInputError.invalidFormat);
      expect(nameInput.isValid, isFalse);
    });

    test('| NameOrLastNameInputError messages are correct', () {
      expect(
        NameOrLastNameInputError.empty.errorMessage,
        'Campo obligatorio.',
      );
      expect(
        NameOrLastNameInputError.invalidLength.errorMessage,
        'Máximo 35 caracteres.',
      );
      expect(
        NameOrLastNameInputError.invalidFormat.errorMessage,
        'Solo letras y caracteres válidos.',
      );
    });
  });


  // --------------- EMAIL INPUT

  group('EmailInput Validation', () {

    test('| Pure EmailInput is not valid.', () {
      final emailInput = EmailInput.pure();
      expect(emailInput..displayError, isNull);
      expect(emailInput.isValid, isFalse);
    });

    test('Valid email returns no error.', () {
      final emailInput = EmailInput.dirty('test@example.com');
      expect(emailInput.displayError, isNull);
      expect(emailInput.isValid, isTrue);
    });

    test('Email with spaces is trimmed and valid.', () {
      final emailInput = EmailInput.dirty('  test@example.com  ');
      expect(emailInput.displayError, isNull);
      expect(emailInput.isValid, isTrue);
    });

    test('Email with leading/trailing spaces is valid after trim.', () {
      final emailInput = EmailInput.dirty('  user@domain.co.uk  ');
      expect(emailInput.displayError, isNull);
      expect(emailInput.isValid, isTrue);
    });

    test('Multiple valid email formats.', () {
      const validEmails = [
        'simple@example.com',
        'user.name@example.com',
        'user+tag@example.co.uk',
        'user_name@example.org',
      ];
      
      for (final email in validEmails) {
        final emailInput = EmailInput.dirty(email);
        expect(emailInput.displayError, isNull);
        expect(emailInput.isValid, isTrue);
      }
    });

    test('Empty email returns empty error.', () {
      final emailInput = EmailInput.dirty('');
      expect(emailInput.displayError, EmailInputError.empty);
      expect(emailInput.isValid, isFalse);
    });

    test('Invalid email format returns invalidFormat error.', () {
      final emailInput = EmailInput.dirty('invalid.email');
      expect(emailInput.displayError, EmailInputError.invalidFormat);
      expect(emailInput.isValid, isFalse);
    });

    test('Email without @ symbol is invalid.', () {
      final emailInput = EmailInput.dirty('testexample.com');
      expect(emailInput.displayError, EmailInputError.invalidFormat);
      expect(emailInput.isValid, isFalse);
    });

    test('EmailInputError messages are correct.', () {
      expect(
        EmailInputError.empty.errorMessage,
        'Campo obligatorio.',
      );
      expect(
        EmailInputError.invalidFormat.errorMessage,
        'Formato de correo electrónico inválido.',
      );
    });
  });


  // --------------- PHONE INPUT

  group('PhoneInput Validation', () {
    test('Pure PhoneInput is not valid.', () {
      final phoneInput = PhoneInput.pure();
      expect(phoneInput.displayError, isNull);
      expect(phoneInput.isValid, isFalse);
    });

    test('Valid phone number is valid.', () {
      final phoneInput = PhoneInput.dirty('987654321');
      expect(phoneInput.displayError, isNull);
      expect(phoneInput.isValid, isTrue);
    });

    test('Phone numbers with exactly 15 characters is valid.', () {
      final phoneInput = PhoneInput.dirty('123456789123456');
      expect(phoneInput.displayError, isNull);
      expect(phoneInput.isValid, isTrue);
    });

    test('Phone numbers with exactly 8 characters is valid.', () {
      final phoneInput = PhoneInput.dirty('12345678');
      expect(phoneInput.displayError, isNull);
      expect(phoneInput.isValid, isTrue);
    });

    test('Phone numbers with exactly 10 characters is valid.', () {
      final phoneInput = PhoneInput.dirty('1234567891');
      expect(phoneInput.displayError, isNull);
      expect(phoneInput.isValid, isTrue);
    });

    test('Phone numbers with exactly 8 characters is valid.', () {
      final phoneInput = PhoneInput.dirty('12345678');
      expect(phoneInput.displayError, isNull);
      expect(phoneInput.isValid, isTrue);
    });

    test('Phone numbers with exactly 1 character is invalid.', () {
      final phoneInput = PhoneInput.dirty('1');
      expect(phoneInput.displayError, PhoneInputError.invalidFormat);
      expect(phoneInput.isValid, isFalse);
    });

    test('Multiple valid phone formats.', () {
      const validPhones = [
        '997793894',
        '999999999',
        '44003237',
        '4400000007',
        '22214421',
      ];
      
      for (final phone in validPhones) {
        final phoneInput = PhoneInput.dirty(phone);
        expect(phoneInput.displayError, isNull);
        expect(phoneInput.isValid, isTrue);
      }
    });

    test('Multiple invalid phone formats.', () {
      const invalidPhones = [
        '99779389434563456367345',
        '-65464345',
        '0000',
        '0000000000000000',
        '099'
      ];
      
      for (final phone in invalidPhones) {
        final phoneInput = PhoneInput.dirty(phone);
        expect(phoneInput.displayError, PhoneInputError.invalidFormat);
        expect(phoneInput.isValid, isFalse);
      }
    });

    test('Empty phone returns error', () {
      final phoneInput = PhoneInput.dirty('');
      expect(phoneInput.displayError, PhoneInputError.empty);
      expect(phoneInput.isValid, isFalse);
    });

    test('Phone number with letters is invalid.', () {
      final phoneInput = PhoneInput.dirty('098764A32');
      expect(phoneInput.displayError, PhoneInputError.invalidFormat);
      expect(phoneInput.isValid, isFalse);
    });

    test('Phone number with special characters is invalid.', () {
      final phoneInput = PhoneInput.dirty('0987-654-321');
      expect(phoneInput.displayError, PhoneInputError.invalidFormat);
      expect(phoneInput.isValid, isFalse);
    });
  });


  // --------------- CITY INPUT

  group('CityInput Validation', () {
    test('Pure CityInput is not valid.', () {
      final cityInput = CityInput.pure();
      expect(cityInput.displayError, isNull);
      expect(cityInput.isValid, isFalse);
    });

    test('Valid city.', () {
      final cityInput = CityInput.dirty('Quito');
      expect(cityInput.displayError, isNull);
      expect(cityInput.isValid, isTrue);
    });

    test('Empty city returns error.', () {
      final cityInput = CityInput.dirty('');
      expect(cityInput.displayError, CityInputError.empty);
      expect(cityInput.isValid, isFalse);
    });

    test('City with exactly 60 characters is valid.', () {
      final cityInput = CityInput.dirty('A' * 60);
      expect(cityInput.displayError, isNull);
      expect(cityInput.isValid, isTrue);
    });

    test('City with exactly 61 characters is invalid.', () {
      final cityInput = CityInput.dirty('A' * 61);
      expect(cityInput.displayError, CityInputError.invalidLength);
      expect(cityInput.isValid, isFalse);
    });

    test('City with accented characters is valid.', () {
      final cityInput = CityInput.dirty('São Paulo');
      expect(cityInput.displayError, isNull);
      expect(cityInput.isValid, isTrue);
    });

    test('City with numbers is invalid.', () {
      final cityInput = CityInput.dirty('Quito123');
      expect(cityInput.displayError, CityInputError.invalidFormat);
      expect(cityInput.isValid, isFalse);
    });
  });

  
  // --------------- COUNTRY INPUT

  group('CountryInput Validation', () {
    test('Pure CountryInput is not valid.', () {
      final countryInput = CountryInput.pure();
      expect(countryInput.displayError, isNull);
      expect(countryInput.isValid, isFalse);
    });

    test('Valid country.', () {
      final countryInput = CountryInput.dirty('Ecuador');
      expect(countryInput.displayError, isNull);
      expect(countryInput.isValid, isTrue);
    });

    test('Empty country returns error.', () {
      final countryInput = CountryInput.dirty('');
      expect(countryInput.displayError, CountryInputError.empty);
      expect(countryInput.isValid, isFalse);
    });

    test('Country with numbers is invalid', () {
      final countryInput = CountryInput.dirty('Ecuador123');
      expect(countryInput.displayError, CountryInputError.invalidFormat);
      expect(countryInput.isValid, isFalse);
    });
  });


  // --------------- COUNTRY CODE INPUT

  group('CountryCodeInput Validation', () {
    test('Pure country code is not valid.', () {
      final codeInput = CountryCodeInput.pure();
      expect(codeInput.displayError, null);
      expect(codeInput.isValid, isFalse);
    });

    test('Valid country code is valid.', () {
      final codeInput = CountryCodeInput.dirty('593');
      expect(codeInput.displayError, isNull);
      expect(codeInput.isValid, isTrue);
    });

    test('Empty country code returns error.', () {
      final codeInput = CountryCodeInput.dirty('');
      expect(codeInput.displayError, CountryCodeInputError.empty);
      expect(codeInput.isValid, isFalse);
    });

    test('Country code with plus sign is invalid', () {
      final codeInput = CountryCodeInput.dirty('+593');
      expect(codeInput.displayError, CountryCodeInputError.invalidFormat);
      expect(codeInput.isValid, isFalse);
    });
  });


  // --------------- CONTACT REASON INPUT

  group('ContactReasonInput Validation', () {
    test('Pure ContactReasonInput is not valid.', () {
      final reasonInput = ContactReasonInput.pure();
      expect(reasonInput.displayError, isNull);
      expect(reasonInput.isValid, isFalse);
    });

    test('Valid contact reason.', () {
      final reasonInput = ContactReasonInput.dirty('Soporte Técnico Corporativo Bitdefender');
      expect(reasonInput.displayError, isNull);
      expect(reasonInput.isValid, isTrue);
    });

    test('Contact reason with exactly 100 characters is valid.', () {
      final reasonInput = ContactReasonInput.dirty('A' * 100);
      expect(reasonInput.displayError, isNull);
      expect(reasonInput.isValid, isTrue);
    });

    test('Contact reason with exactly 101 characters is invalid.', () {
      final reasonInput = ContactReasonInput.dirty('A' * 101);
      expect(reasonInput.displayError, ContactReasonInputError.invalidLength);
      expect(reasonInput.isValid, isFalse);
    });

    test('Empty contact reason returns error.', () {
      final reasonInput = ContactReasonInput.dirty('');
      expect(reasonInput.displayError, ContactReasonInputError.empty);
      expect(reasonInput.isValid, isFalse);
    });
  });


// --------------- REQUIREMENT INPUT

  group('RequirementInput Validation', () {
    test('Pure RequirementInput is not valid.', () {
      final reqInput = RequirementInput.pure();
      expect(reqInput.displayError, isNull);
      expect(reqInput.isValid, isFalse);
    });

    test('Valid requirement.', () {
      final reqInput = RequirementInput.dirty('I need help with implementation');
      expect(reqInput.displayError, isNull);
      expect(reqInput.isValid, isTrue);
    });

    test('Requirement with exactly 500 characters is valid.', () {
      final reqInput = RequirementInput.dirty('A' * 500);
      expect(reqInput.displayError, isNull);
      expect(reqInput.isValid, isTrue);
    });

    test('Requirement with exactly 501 characters is invalid.', () {
      final reqInput = RequirementInput.dirty('A' * 501);
      expect(reqInput.displayError, RequirementInputError.invalidLength);
      expect(reqInput.isValid, isFalse);
    });

    test('Empty requirement returns error.', () {
      final reqInput = RequirementInput.dirty('');
      expect(reqInput.displayError, RequirementInputError.empty);
      expect(reqInput.isValid, isFalse);
    });

    test('Requirement with minimum length is valid.', () {
      final reqInput = RequirementInput.dirty('Help');
      expect(reqInput.displayError, isNull);
      expect(reqInput.isValid, isTrue);
    });
  });

  group('FormzInput Equality', () {
    test('Same values produce equal FormzInputs.', () {
      final email1 = EmailInput.dirty('test@example.com');
      final email2 = EmailInput.dirty('test@example.com');
      expect(email1, equals(email2));
    });

    test('Different values produce different FormzInputs.', () {
      final email1 = EmailInput.dirty('test1@example.com');
      final email2 = EmailInput.dirty('test2@example.com');
      expect(email1, isNot(equals(email2)));
    });

    test('Pure and dirty with same value are not equal.', () {
      final emailPure = EmailInput.pure();
      final emailDirty = EmailInput.dirty('');
      expect(emailPure, isNot(equals(emailDirty)));
    });
  });
}
