import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/contact_reason_bloc.dart';

void main() {
  group('ContactReasonBloc Widget Tests', () {
    late ContactCubit contactCubit;

    setUp(() {
      contactCubit = ContactCubit();
    });

    tearDown(() {
      contactCubit.close();
    });

    testWidgets('ContactReasonBloc renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const ContactReasonBloc(),
            ),
          ),
        ),
      );

      expect(find.byType(ContactReasonBloc), findsOneWidget);
      expect(find.text('Motivo de Contacto'), findsOneWidget);
      expect(find.byKey(const Key('contactForm_contactReasonInput')), findsOneWidget);
    });

    testWidgets('ContactReasonBloc selects an option and updates state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<ContactCubit>.value(
              value: contactCubit,
              child: const ContactReasonBloc(),
            ),
          ),
        ),
      );

      final dropdownFinder = find.byKey(const Key('contactForm_contactReasonInput'));
      
      // Abrir dropdown
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      // Seleccionar opción
      final option = "Información de Productos Corporativos Bitdefender";
      await tester.tap(find.text(option).last);
      await tester.pumpAndSettle();

      expect(contactCubit.state.contactReasonInput.value, equals(option));
    });

    testWidgets('ContactReasonBloc rebuilds only when necessary', (WidgetTester tester) async {
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
                      listenWhen: (previous, current) => previous.contactReasonInput != current.contactReasonInput,
                      listener: (context, state) => buildCount++,
                      child: const ContactReasonBloc(),
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
      

      contactCubit.contactReasonChanged("Soporte Técnico Corporativo Bitdefender");
      await tester.pumpAndSettle();
      expect(buildCount, greaterThan(initialBuildCount));
    });
  });
}