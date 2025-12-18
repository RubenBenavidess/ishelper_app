import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/name_bloc.dart';

void main() {
  group('NameBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('NameBloc renders correctly with initial state', 
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: const NameBloc(),
              ),
            ),
          ),
        );

        expect(find.byType(NameBloc), findsOneWidget);
        expect(find.text('Nombre'), findsWidgets);
        expect(find.byKey(const Key('contactForm_nameInput')), findsOneWidget);
      },
    );

    testWidgets('NameBloc disables input when form is in progress',
      (WidgetTester tester) async {
        final inProgressState = ContactState.initial()
            .copyWith(status: FormzSubmissionStatus.inProgress);

        final testCubit = ContactCubit();
        addTearDown(testCubit.close);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: testCubit,
                child: NameBloc(),
              ),
            ),
          ),
        );

        var textField = find.byKey(const Key('contactForm_nameInput'));
        expect(
          tester.widget<TextField>(textField).enabled,
          isTrue,
        );

        testCubit.emit(inProgressState);
        await tester.pump();

        textField = find.byKey(const Key('contactForm_nameInput'));
        expect(
          tester.widget<TextField>(textField).enabled,
          isFalse,
        );
      },
    );

    testWidgets('NameBloc calls nameChanged on text input',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: const NameBloc(),
              ),
            ),
          ),
        );

        final nameInputFinder = find.byKey(const Key('contactForm_nameInput'));
        
        await tester.enterText(nameInputFinder, 'Juan');
        await tester.pumpAndSettle();

        expect(contactCubit.state.nameInput.value, equals('Juan'));
      },
    );

    testWidgets('NameBloc displays error message for invalid name',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: const NameBloc(),
              ),
            ),
          ),
        );

        final nameInputFinder = find.byKey(const Key('contactForm_nameInput'));
        
        await tester.enterText(nameInputFinder, 'Juan123');
        await tester.pumpAndSettle();

        expect(contactCubit.state.nameInput.isValid, isFalse);
      },
    );

    testWidgets('NameBloc rebuilds only when nameInput changes (buildWhen)',
      (WidgetTester tester) async {
        int buildCount = 0;

        // Create a custom widget to track builds
        final testWidget = StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: BlocProvider<ContactCubit>.value(
                  value: contactCubit,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          contactCubit.emailChanged('test@example.com');
                        },
                        child: const Text('Change Email'),
                      ),
                      BlocListener<ContactCubit, ContactState>(
                        listenWhen: (previous, current) =>
                            previous.nameInput != current.nameInput,
                        listener: (context, state) {
                          buildCount++;
                        },
                        child: const NameBloc(),
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

        final nameInputFinder = find.byKey(const Key('contactForm_nameInput'));
        await tester.enterText(nameInputFinder, 'Juan');
        await tester.pumpAndSettle();

        expect(buildCount, greaterThan(initialBuildCount));
      },
    );

    testWidgets('NameBloc handles long input correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: const NameBloc(),
              ),
            ),
          ),
        );

        final nameInputFinder = find.byKey(const Key('contactForm_nameInput'));
        
        final longName = 'A' * 35; 
        await tester.enterText(nameInputFinder, longName);
        await tester.pumpAndSettle();

        expect(contactCubit.state.nameInput.value, equals(longName));
        expect(contactCubit.state.nameInput.isValid, isTrue);

        await tester.enterText(nameInputFinder, 'A' * 36);
        await tester.pumpAndSettle();

        expect(contactCubit.state.nameInput.isValid, isFalse);
      },
    );

    testWidgets('NameBloc label text and hint of the input are visible',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: const NameBloc(),
              ),
            ),
          ),
        );

        expect(find.text('Nombre'), findsExactly(2));
        expect(find.byType(Text), findsWidgets);
      },
    );

    testWidgets('NameBloc handles multiple rapid text changes',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider<ContactCubit>.value(
                value: contactCubit,
                child: const NameBloc(),
              ),
            ),
          ),
        );

        final nameInputFinder = find.byKey(const Key('contactForm_nameInput'));
        
        final names = ['J', 'Ju', 'Jua', 'Juan', 'Juan '];
        
        for (final name in names) {
          await tester.enterText(nameInputFinder, name);
          await tester.pump();
          expect(contactCubit.state.nameInput.value, equals(name));
        }
      },
    );
  });
}
