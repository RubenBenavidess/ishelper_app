import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/email_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/lastname_bloc.dart';
import 'package:ishelper_app/src/view/screens/builder_blocs/name_bloc.dart';

class ContactScreen extends StatelessWidget{
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContactScreen(context);
  }
}

Widget _buildContactScreen(BuildContext context){
  return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(12, 24, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NameBloc()
                ),
                SizedBox(width: 16),
                Expanded(
                  child: LastNameBloc()
                ),
              ],
            ),
            SizedBox(height: 24,),
            EmailBloc()
          ]
        )
      )
  );
}