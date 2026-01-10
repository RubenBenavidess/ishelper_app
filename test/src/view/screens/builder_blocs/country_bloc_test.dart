import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/country_bloc.dart';

void main() {
  group('CountryBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('CountryBloc renders correctly and initializes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const CountryBloc(),
            ),
          ),
        ),
      );

      expect(find.byType(CountryBloc), findsOneWidget);
      expect(find.byType(CountryCodePicker), findsOneWidget);

      await tester.pumpAndSettle();
      expect(contactCubit.state.countryInput.value, isNotEmpty); 
    });

    testWidgets('CountryBloc disables when in progress', (WidgetTester tester) async {
      final inProgressState = ContactState.initial().copyWith(status: FormzSubmissionStatus.inProgress);
      final testCubit = ContactCubit();
      addTearDown(testCubit.close);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: testCubit,
              child: const CountryBloc(),
            ),
          ),
        ),
      );

      expect(tester.widget<CountryCodePicker>(find.byKey(const Key('contactForm_countryInput'))).enabled, isTrue);

      testCubit.emit(inProgressState);
      await tester.pump();

      expect(tester.widget<CountryCodePicker>(find.byKey(const Key('contactForm_countryInput'))).enabled, isFalse);
    });

    testWidgets('CountryBloc rebuilds optimization (buildWhen)', (WidgetTester tester) async {
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
                      listenWhen: (previous, current) => previous.countryInput != current.countryInput,
                      listener: (context, state) => buildCount++,
                      child: const CountryBloc(),
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
      
      contactCubit.countryChanged('Peru');
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });
  });
}