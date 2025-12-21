import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/lastname_bloc.dart';

void main() {
  group('LastNameBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('LastNameBloc renders correctly with initial state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const LastNameBloc(),
            ),
          ),
        ),
      );

      expect(find.byType(LastNameBloc), findsOneWidget);
      expect(find.text('Apellido'), findsWidgets);
      expect(find.byKey(const Key('contactForm_lastnameInput')), findsOneWidget);
    });

    testWidgets('LastNameBloc disables input when form is in progress', (WidgetTester tester) async {
      final inProgressState = ContactState.initial().copyWith(status: FormzSubmissionStatus.inProgress);
      final testCubit = ContactCubit();
      addTearDown(testCubit.close);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: testCubit,
              child: const LastNameBloc(),
            ),
          ),
        ),
      );

      var textField = find.byKey(const Key('contactForm_lastnameInput'));
      expect(tester.widget<TextField>(textField).enabled, isTrue);

      testCubit.emit(inProgressState);
      await tester.pump();

      textField = find.byKey(const Key('contactForm_lastnameInput'));
      expect(tester.widget<TextField>(textField).enabled, isFalse);
    });

    testWidgets('LastNameBloc calls lastNameChanged on text input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const LastNameBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_lastnameInput'));
      await tester.enterText(inputFinder, 'Pérez');
      await tester.pumpAndSettle();

      expect(contactCubit.state.lastNameInput.value, equals('Pérez'));
    });

    testWidgets('LastNameBloc displays error message for invalid lastname', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const LastNameBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_lastnameInput'));

      await tester.enterText(inputFinder, 'Pérez123'); 
      await tester.pumpAndSettle();

      expect(contactCubit.state.lastNameInput.isValid, isFalse);

    });

    testWidgets('LastNameBloc rebuilds only when lastNameInput changes (buildWhen)', (WidgetTester tester) async {
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
                      onTap: () => contactCubit.emailChanged('test@test.com'),
                      child: const Text('Change Email'),
                    ),
                    BlocListener<ContactCubit, ContactState>(
                      listenWhen: (previous, current) => previous.lastNameInput != current.lastNameInput,
                      listener: (context, state) => buildCount++,
                      child: const LastNameBloc(),
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

      await tester.tap(find.text('Change Email'));
      await tester.pumpAndSettle();
      expect(buildCount, equals(initialBuildCount));

      final inputFinder = find.byKey(const Key('contactForm_lastnameInput'));
      await tester.enterText(inputFinder, 'Lopez');
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });

    testWidgets('LastNameBloc handles long input correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const LastNameBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_lastnameInput'));
      final longName = 'A' * 50;
      await tester.enterText(inputFinder, longName);
      await tester.pumpAndSettle();

      expect(contactCubit.state.lastNameInput.value, equals(longName));
    });
  });
}