import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/city_bloc.dart';

void main() {
  group('CityBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('CityBloc renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const CityBloc(),
            ),
          ),
        ),
      );
      expect(find.byType(CityBloc), findsOneWidget);
      expect(find.byKey(const Key('contactForm_cityInput')), findsOneWidget);
    });

    testWidgets('CityBloc disables input when form is in progress', (WidgetTester tester) async {
      final inProgressState = ContactState.initial().copyWith(status: FormzSubmissionStatus.inProgress);
      final testCubit = ContactCubit();
      addTearDown(testCubit.close);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: testCubit,
              child: const CityBloc(),
            ),
          ),
        ),
      );

      expect(tester.widget<TextField>(find.byKey(const Key('contactForm_cityInput'))).enabled, isTrue);
      
      testCubit.emit(inProgressState);
      await tester.pump();
      
      expect(tester.widget<TextField>(find.byKey(const Key('contactForm_cityInput'))).enabled, isFalse);
    });

    testWidgets('CityBloc updates state and handles long input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const CityBloc(),
            ),
          ),
        ),
      );

      final inputFinder = find.byKey(const Key('contactForm_cityInput'));
      final longCity = 'Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch';
      
      await tester.enterText(inputFinder, longCity);
      await tester.pumpAndSettle();

      expect(contactCubit.state.cityInput.value, equals(longCity));
    });

    testWidgets('CityBloc rebuilds only when cityInput changes', (WidgetTester tester) async {
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
                      listenWhen: (previous, current) => previous.cityInput != current.cityInput,
                      listener: (context, state) => buildCount++,
                      child: const CityBloc(),
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

      await tester.enterText(find.byKey(const Key('contactForm_cityInput')), 'Quito');
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });
  });
}