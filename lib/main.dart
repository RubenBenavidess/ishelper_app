import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ishelper_app/src/services/pdf_file_input_service.dart';
import 'package:ishelper_app/src/view/app_router.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ContactCubit()
          ),
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