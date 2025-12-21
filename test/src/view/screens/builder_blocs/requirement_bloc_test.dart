import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/requirement_bloc.dart';

void main() {
  group('RequirementBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('RequirementBloc renders correctly and allows multiline', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const RequirementBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_requirementInput'));
      expect(inputFinder, findsOneWidget);
      
      final textField = tester.widget<TextField>(inputFinder);
      expect(textField.maxLines, equals(3));
      expect(textField.keyboardType, TextInputType.multiline);
    });

    testWidgets('RequirementBloc disables input when in progress', (WidgetTester tester) async {
       final inProgressState = ContactState.initial().copyWith(status: FormzSubmissionStatus.inProgress);
      final testCubit = ContactCubit();
      addTearDown(testCubit.close);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: testCubit,
              child: const RequirementBloc(),
            ),
          ),
        ),
      );

      expect(tester.widget<TextField>(find.byKey(const Key('contactForm_requirementInput'))).enabled, isTrue);
      
      testCubit.emit(inProgressState);
      await tester.pump();
      
      expect(tester.widget<TextField>(find.byKey(const Key('contactForm_requirementInput'))).enabled, isFalse);
    });

    testWidgets('RequirementBloc handles rapid text changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const RequirementBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_requirementInput'));
      final texts = ['H', 'Ho', 'Hol', 'Hola'];

      for (final text in texts) {
        await tester.enterText(inputFinder, text);
        await tester.pump();
        expect(contactCubit.state.requirementInput.value, equals(text));
      }
    });

    testWidgets('RequirementBloc rebuilds optimization (buildWhen)', (WidgetTester tester) async {
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
                      listenWhen: (previous, current) => previous.requirementInput != current.requirementInput,
                      listener: (context, state) => buildCount++,
                      child: const RequirementBloc(),
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

      await tester.enterText(find.byKey(const Key('contactForm_requirementInput')), 'Ayuda');
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });
  });
}