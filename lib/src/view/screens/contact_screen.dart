import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';
import 'package:ishelper_app/config/widgets/designed_button.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/city_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/contact_reason_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/country_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/phone_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/email_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/lastname_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/name_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/requirement_bloc.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/states/contact_state.dart';

class ContactScreen extends StatelessWidget{
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/contact_bg_image.webp',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Color.fromRGBO(50, 65, 88, 0.90)
          ),
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            child: _buildContactScreen(context),
          )
        ),
      ],
    );
  }
}

Widget _buildContactScreen(BuildContext context){
  const String mainText = "Nuestro equipo técnico o comercial atenderá tu requerimiento cuanto antes";
  const String mainSubText1 = "Por favor llena el formulario";
  const String mainSubText2 = "¡Es nuestro compromiso!";

  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.fromLTRB(6, 28, 6, 6),

    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const Text(
          mainSubText1,
          textAlign: TextAlign.left,
          style: AppTypography.h4,
        ),

        const SizedBox(height: 20),

        const Text(
          mainText,
          style: AppTypography.h2,
          textAlign: TextAlign.left,
        ),

        const SizedBox(height: 8),

        const Text(
          mainSubText2,
          style: AppTypography.h3,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        _buildContactForm(context)

      ],
    ),
  );
}

class ContactSubmitButton extends StatelessWidget{

  const ContactSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state){
          return SizedBox(
              child: DesignedButton(
                label: 'Enviar',
                onPressed: (){

                },
              )
          );
        }
    );
  }
}


Widget _buildContactForm(BuildContext context){

  return Container(
    padding: const EdgeInsets.all(1),
    margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
                child: NameBloc()
            ),
            const SizedBox(width: 16),
            const Expanded(
                child: LastNameBloc()
            ),
          ],
        ),
        const SizedBox(height: 24,),
        EmailBloc(),
        const SizedBox(height: 24,),
        PhoneBloc(),
        const SizedBox(height: 24,),
        const Text("Dirección", style: AppTypography.labelText, textAlign: TextAlign.left,),
        const SizedBox(height: 9,),
        CityBloc(),
        const SizedBox(height: 24,),
        CountryBloc(),
        const SizedBox(height: 24,),
        ContactReasonBloc(),
        const SizedBox(height: 24,),
        RequirementBloc(),
        const SizedBox(height: 30,),
        Container(
          alignment: Alignment.center,
          child: ContactSubmitButton(),
        )

    ])
  );
}