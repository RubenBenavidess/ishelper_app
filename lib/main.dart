import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ishelper_app/src/services/pdf_file_input_service.dart';
import 'package:ishelper_app/src/view/app_router.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';

/// Entry point of the ISHelper application.
///
/// Initializes the Flutter application with all necessary providers,
/// localization support, and routing configuration.
void main() {
  runApp(const MyApp());
}

/// Root widget of the ISHelper application.
///
/// [MyApp] configures the Material Design app with:
/// - BLoC providers for state management (ContactCubit and FileCubit)
/// - GoRouter for navigation
/// - Spanish localization support
/// - Google Fonts typography (Raleway)
///
/// The app uses a [MultiBlocProvider] to inject the required cubits
/// throughout the widget tree, enabling state management at any level.
class MyApp extends StatelessWidget {
  /// Creates the root widget for the application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          /// Provides the [ContactCubit] to manage contact form state.
          BlocProvider(
            create: (_) => ContactCubit()
          ),
          /// Provides the [FileCubit] to manage file upload and processing.
          BlocProvider(
            create: (_) => FileCubit(fileInputService: PDFFileInputService())
          )
        ],
        child: MaterialApp.router(
          routerConfig: appRouter,
          supportedLocales: const [
            Locale('es', 'ES')
          ],
          localizationsDelegates: const [
            CountryLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            textTheme: GoogleFonts.ralewayTextTheme(),
          ),
        )
    );
  }
}