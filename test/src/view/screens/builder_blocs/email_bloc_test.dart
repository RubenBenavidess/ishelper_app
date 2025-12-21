import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/email_bloc.dart';

void main() {
  group('EmailBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('EmailBloc renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const EmailBloc(),
            ),
          ),
        ),
      );
      expect(find.byType(EmailBloc), findsOneWidget);
      expect(find.text('Email'), findsWidgets);
    });

    testWidgets('EmailBloc disables input when in progress', (WidgetTester tester) async {
      final inProgressState = ContactState.initial().copyWith(status: FormzSubmissionStatus.inProgress);
      final testCubit = ContactCubit();
      addTearDown(testCubit.close);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: testCubit,
              child: const EmailBloc(),
            ),
          ),
        ),
      );

      expect(tester.widget<TextField>(find.byKey(const Key('contactForm_emailInput'))).enabled, isTrue);
      
      testCubit.emit(inProgressState);
      await tester.pump();
      
      expect(tester.widget<TextField>(find.byKey(const Key('contactForm_emailInput'))).enabled, isFalse);
    });

    testWidgets('EmailBloc updates state and validates invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const EmailBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_emailInput'));
      
      await tester.enterText(inputFinder, 'correo_invalido');
      await tester.pumpAndSettle();
      expect(contactCubit.state.emailInput.isValid, isFalse);

      await tester.enterText(inputFinder, 'correo@valido.com');
      await tester.pumpAndSettle();
      expect(contactCubit.state.emailInput.isValid, isTrue);
      expect(contactCubit.state.emailInput.value, 'correo@valido.com');
    });

    testWidgets('EmailBloc rebuilds only when emailInput changes', (WidgetTester tester) async {
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
                      listenWhen: (previous, current) => previous.emailInput != current.emailInput,
                      listener: (context, state) => buildCount++,
                      child: const EmailBloc(),
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

      await tester.enterText(find.byKey(const Key('contactForm_emailInput')), 'a@b.c');
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });
  });
}