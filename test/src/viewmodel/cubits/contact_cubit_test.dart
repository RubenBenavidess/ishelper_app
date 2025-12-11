import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/city_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/contact_reason_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_code_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/country_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/email_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/name_lastname_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/phone_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/requirement_input.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

void main() {
  group('ContactCubit', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    group('initial state', () {
      test('| Emits initial state correctly.', () {
        expect(
          contactCubit.state,
          equals(ContactState.initial()),
        );
      });

      test('| Initial state has isValid as false.', () {
        expect(contactCubit.state.isValid, isFalse);
      });

      test('| Initial state has status as initial.', () {
        expect(
          contactCubit.state.status,
          equals(FormzSubmissionStatus.initial),
        );
      });
    });

    group('nameChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid name.',
        build: () => contactCubit,
        act: (cubit) => cubit.nameChanged('Juan'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.nameInput.value, 'nameInput.value', 'Juan')
              .having((state) => state.nameInput.isValid, 'nameInput.isValid', isTrue),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with invalid empty name.',
        build: () => contactCubit,
        act: (cubit) => cubit.nameChanged(''),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.nameInput.value, 'nameInput.value', '')
              .having((state) => state.nameInput.isValid, 'nameInput.isValid', isFalse),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with name exceeding max length.',
        build: () => contactCubit,
        act: (cubit) => cubit.nameChanged('A' * 36),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.nameInput.isValid, 'nameInput.isValid', isFalse),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with name containing invalid characters.',
        build: () => contactCubit,
        act: (cubit) => cubit.nameChanged('Juan123'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.nameInput.isValid, 'nameInput.isValid', isFalse),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid name containing spaces and hyphens.',
        build: () => contactCubit,
        act: (cubit) => cubit.nameChanged('Juan-Carlos'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.nameInput.isValid, 'nameInput.isValid', isTrue),
        ],
      );
    });

    group('lastNameChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid last name.',
        build: () => contactCubit,
        act: (cubit) => cubit.lastNameChanged('Pérez'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.lastNameInput.value, 'lastNameInput.value', 'Pérez')
              .having((state) => state.lastNameInput.isValid, 'lastNameInput.isValid', isTrue),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with invalid empty last name.',
        build: () => contactCubit,
        act: (cubit) => cubit.lastNameChanged(''),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.lastNameInput.isValid, 'lastNameInput.isValid', isFalse),
        ],
      );
    });

    group('emailChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid email.',
        build: () => contactCubit,
        act: (cubit) => cubit.emailChanged('test@example.com'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.emailInput.value, 'emailInput.value', 'test@example.com')
              .having((state) => state.emailInput.isValid, 'emailInput.isValid', isTrue),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with invalid empty email.',
        build: () => contactCubit,
        act: (cubit) => cubit.emailChanged(''),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.emailInput.isValid, 'emailInput.isValid', isFalse),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| emits new state with invalid email format.',
        build: () => contactCubit,
        act: (cubit) => cubit.emailChanged('invalid.email'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.emailInput.isValid, 'emailInput.isValid', isFalse),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with email containing spaces.',
        build: () => contactCubit,
        act: (cubit) => cubit.emailChanged('  test@example.com  '),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.emailInput.isValid, 'emailInput.isValid', isTrue),
        ],
      );
    });

    group('cityChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid city.',
        build: () => contactCubit,
        act: (cubit) => cubit.cityChanged('Quito'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.cityInput.value, 'cityInput.value', 'Quito')
              .having((state) => state.cityInput.isValid, 'cityInput.isValid', isTrue),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with invalid empty city.',
        build: () => contactCubit,
        act: (cubit) => cubit.cityChanged(''),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.cityInput.isValid, 'cityInput.isValid', isFalse),
        ],
      );
    });

    group('countryChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid country.',
        build: () => contactCubit,
        act: (cubit) => cubit.countryChanged('Ecuador'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.countryInput.value, 'countryInput.value', 'Ecuador')
              .having((state) => state.countryInput.isValid, 'countryInput.isValid', isTrue),
        ],
      );
    });

    group('countryCodeChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid country code.',
        build: () => contactCubit,
        act: (cubit) => cubit.countryCodeChanged('593'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.countryCode.value, 'countryCode.value', '593')
              .having((state) => state.countryCode.isValid, 'countryCode.isValid', isTrue),
        ],
      );
    });

    group('phoneChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid phone.',
        build: () => contactCubit,
        act: (cubit) => cubit.phoneChanged('987654321'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.phoneInput.value, 'phoneInput.value', '987654321')
              .having((state) => state.phoneInput.isValid, 'phoneInput.isValid', isTrue),
        ],
      );

      blocTest<ContactCubit, ContactState>(
        '| Emits new state with invalid empty phone.',
        build: () => contactCubit,
        act: (cubit) => cubit.phoneChanged(''),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.phoneInput.isValid, 'phoneInput.isValid', isFalse),
        ],
      );
    });

    group('contactReasonChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid contact reason.',
        build: () => contactCubit,
        act: (cubit) => cubit.contactReasonChanged('Support'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.contactReasonInput.value, 'contactReasonInput.value', 'Support')
              .having((state) => state.contactReasonInput.isValid, 'contactReasonInput.isValid', isTrue),
        ],
      );
    });

    group('requirementChanged', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits new state with valid requirement.',
        build: () => contactCubit,
        act: (cubit) => cubit.requirementChanged('I need help with implementation'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.requirementInput.value, 'requirementInput.value', 'I need help with implementation')
              .having((state) => state.requirementInput.isValid, 'requirementInput.isValid', isTrue),
        ],
      );
    });

    group('submitContact', () {
      blocTest<ContactCubit, ContactState>(
        '| Emits canceled status when form is invalid.',
        build: () => contactCubit,
        act: (cubit) async {
          await cubit.submitContact();
        },
        expect: () => [
          isA<ContactState>()
              .having((state) => state.status, 'status', FormzSubmissionStatus.canceled),
        ],
      );

    });

    group('state equality', () {
      test('| Different instances with same values are equal.', () {
        final state1 = ContactState.initial();
        final state2 = ContactState.initial();
        expect(state1, equals(state2));
      });

      blocTest<ContactCubit, ContactState>(
        '| State changes are properly tracked.',
        build: () => contactCubit,
        act: (cubit) => cubit.nameChanged('Test'),
        expect: () => [
          isA<ContactState>()
              .having((state) => state.nameInput.value, 'value', 'Test')
              .having((state) => state.lastNameInput.value, 'lastNameInput.value', '')
              .having((state) => state.emailInput.value, 'emailInput.value', ''),
        ],
      );
    });
  });
}
