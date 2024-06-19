import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/widgets/input_title.dart';
import 'package:footloose_tickets/presentation/widgets/label_error_input.dart';

class InputCodLogin extends ConsumerWidget {
  const InputCodLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Column(
      children: [
        const InputTitle(title: "Código de colaborador"),
        const SizedBox(height: 5),
        const _InputCodeColaborador(),
        const SizedBox(height: 12),
        LabelErrorInput(
          eval: auth.codeColaboradorValid ?? true,
          customError: "Ingrese un código de colaborador válido",
        )
      ],
    );
  }
}

class _InputCodeColaborador extends ConsumerStatefulWidget {
  const _InputCodeColaborador();

  @override
  _InputCodeColaboradorState createState() => _InputCodeColaboradorState();
}

class _InputCodeColaboradorState extends ConsumerState<_InputCodeColaborador> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: AppTheme.inputCustomDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Center(
        child: TextFormField(
          style: AppTheme.styleInput,
          onChanged: (value) {
            setState(() {});
            // credenciales.usuario = value;
            // credenciales.codeColaboradorValid = (value.length == 6 && isNumeric(value));
            auth.usuario = value;
            auth.codeColaboradorValid = (value.length == 6 && isNumeric(value));
          },
          textAlign: TextAlign.start,
          autocorrect: false,
          keyboardType: TextInputType.number,
          cursorColor: AppTheme.colorStyleText,
          inputFormatters: [LengthLimitingTextInputFormatter(8)],
          decoration: AppTheme.getCustomDecorationInput(auth.codeColaboradorValid ?? false),
        ),
      ),
    );
  }
}
