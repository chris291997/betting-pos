import 'package:bet_pos/authentication/presentation/viewmodel/auth_viewmodel.dart';
import 'package:bet_pos/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameTextfield extends StatelessWidget {
  const UsernameTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTextfield(
      hintText: 'Username',
      onChanged: (value) => context.read<AuthViewmodel>().add(
            AuthLoginUsernameChanged(value),
          ),
    );
  }
}
