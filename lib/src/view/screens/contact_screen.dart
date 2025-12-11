import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
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

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/contact_bg_image.webp'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          // Fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/contact_bg_image.webp',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: const Color.fromRGBO(50, 65, 88, 0.90)),
          ),
          const Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 40),
              child: _ContactContent(), 
            ),
          ),
        ],
    );
  }
}

class _ContactContent extends StatelessWidget {
  const _ContactContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(6, 28, 6, 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Por favor llena el formulario",
            textAlign: TextAlign.left,
            style: AppTypography.h4,
          ),
          SizedBox(height: 20),
          Text(
            "Nuestro equipo técnico o comercial atenderá tu requerimiento cuanto antes",
            style: AppTypography.h2,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8),
          Text(
            "¡Es nuestro compromiso!",
            style: AppTypography.h3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          _ContactFormFields(),
        ],
      ),
    );
  }
}

class _ContactFormFields extends StatelessWidget {
  const _ContactFormFields();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(child: NameBloc()),
              SizedBox(width: 16),
              Expanded(child: LastNameBloc()),
            ],
          ),
          const SizedBox(height: 24),
          const EmailBloc(),
          const SizedBox(height: 24),
          const PhoneBloc(),
          const SizedBox(height: 24),
          
          const Text(
            "Dirección",
            style: AppTypography.labelText,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 9),
          
          const CityBloc(),
          const SizedBox(height: 24),
          const CountryBloc(),
          const SizedBox(height: 24),
          const ContactReasonBloc(),
          const SizedBox(height: 24),
          const RequirementBloc(),
          const SizedBox(height: 30),
          
          const Center(child: ContactSubmitButton()),
        ],
      ),
    );
  }
}

class ContactSubmitButton extends StatelessWidget {
  const ContactSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactCubit, ContactState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status.isSuccess || state.status.isFailure) {
          // Timer seguro: solo reseteamos si el widget sigue montado
          Future.delayed(const Duration(seconds: 3), () {
            if (context.mounted) {
              context.read<ContactCubit>().setInitialState();
            }
          });
        }
      },
      child: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          return SizedBox(
            width: 270,
            // AnimatedSwitcher para que el cambio de botón a spinner sea suave
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildButtonContent(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context, ContactState state) {

    if (state.status.isInProgress) {
      return const Center(
        key: ValueKey('loading'),
        child: SizedBox(
          height: 24, 
          width: 24,
          child: CircularProgressIndicator(
            color: AppColors.primaryBgColor,
            backgroundColor: Colors.black, 
            strokeWidth: 4,
          ),
        ),
      );
    }

    if (state.status.isSuccess) {
      return Column(
        key: const ValueKey('success'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DesignedButton(
            label: '',
            icon: Icons.check,
            btnVariant: ButtonVariant.secondary,
            onPressed: () {},
          ),
          const SizedBox(height: 4),
          const Text(
            "Tu correo ha sido recibido.",
            style: AppTypography.successInputText,
            textAlign: TextAlign.center,
          )
        ],
      );
    }

    if (state.status.isFailure) {
      return Column(
        key: const ValueKey('failure'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DesignedButton(
            label: '',
            icon: Icons.error,
            onPressed: () {},
          ),
          const SizedBox(height: 4),
          const Text(
            "Hubo un error al enviar.",
            style: AppTypography.errorInputText,
            textAlign: TextAlign.center,
          )
        ],
      );
    }

    if (state.status.isCanceled) {
      return Column(
        key: const ValueKey('canceled'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DesignedButton(
            label: 'Enviar',
            onPressed: () => context.read<ContactCubit>().submitContact(),
          ),
          const SizedBox(height: 4),
          const Text(
            "Por favor revisa los campos.",
            style: AppTypography.errorInputText,
            textAlign: TextAlign.center,
          )
        ],
      );
    }

    return Column(
      key: const ValueKey('initial'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DesignedButton(
          label: 'Enviar',
          onPressed: () => context.read<ContactCubit>().submitContact(),
        ),
      ],
    );
  }
}