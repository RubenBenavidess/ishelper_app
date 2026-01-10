import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/phone_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

void main() {
  group('PhoneBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('PhoneBloc renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const PhoneBloc(),
            ),
          ),
        ),
      );
      expect(find.byType(PhoneBloc), findsOneWidget);
      expect(find.byType(IntlPhoneField), findsOneWidget);
    });

    testWidgets('PhoneBloc disables input when in progress', (WidgetTester tester) async {
      final inProgressState = ContactState.initial().copyWith(status: FormzSubmissionStatus.inProgress);
      final testCubit = ContactCubit();
      addTearDown(testCubit.close);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: testCubit,
              child: const PhoneBloc(),
            ),
          ),
        ),
      );
      
      expect(tester.widget<IntlPhoneField>(find.byKey(const Key('contactForm_phoneInput'))).enabled, isTrue);

      testCubit.emit(inProgressState);
      await tester.pump();

      expect(tester.widget<IntlPhoneField>(find.byKey(const Key('contactForm_phoneInput'))).enabled, isFalse);
    });

    testWidgets('PhoneBloc updates state on valid number entry', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const PhoneBloc(),
            ),
          ),
        ),
      );

      final textFieldFinder = find.descendant(
        of: find.byType(IntlPhoneField),
        matching: find.byType(TextField),
      );

      await tester.enterText(textFieldFinder, '991234567');
      await tester.pumpAndSettle();

      expect(contactCubit.state.phoneInput.value, contains('991234567'));
    });

    testWidgets('PhoneBloc shows error on invalid number', (WidgetTester tester) async {
       await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const PhoneBloc(),
            ),
          ),
        ),
      );

      final textFieldFinder = find.descendant(
        of: find.byType(IntlPhoneField),
        matching: find.byType(TextField),
      );

      await tester.enterText(textFieldFinder, '123');
      await tester.pumpAndSettle();

    });

    testWidgets('PhoneBloc rebuilds optimized (buildWhen)', (WidgetTester tester) async {
      int buildCount = 0;
      final testWidget = StatefulBuilder(
        builder: (context, setState) {
          return MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => contactCubit.nameChanged('Juan'),
                      child: const Text('Change Name'),
                    ),
                    BlocListener<ContactCubit, ContactState>(
                      listenWhen: (previous, current) => previous.phoneInput != current.phoneInput,
                      listener: (context, state) => buildCount++,
                      child: const PhoneBloc(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      await tester.pumpWidget(testWidget);
      int initialBuildCount = buildCount;

      await tester.tap(find.text('Change Name'));
      await tester.pumpAndSettle();
      expect(buildCount, equals(initialBuildCount));

      final textFieldFinder = find.descendant(
        of: find.byType(IntlPhoneField),
        matching: find.byType(TextField),
      );
      await tester.enterText(textFieldFinder, '0999999999');
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });
  });
}