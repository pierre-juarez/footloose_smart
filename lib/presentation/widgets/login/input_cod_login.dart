import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/input_title.dart';
import 'package:footloose_tickets/presentation/widgets/label_error_input.dart';
// import 'package:footloose_puntodeventa/src/data/provider/credenciales_provider.dart';
// import 'package:footloose_puntodeventa/src/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/ui/common/style.dart';
// import 'package:footloose_puntodeventa/src/ui/shared/inputTitle.dart';
// import 'package:footloose_puntodeventa/src/ui/shared/labelErrorInput.dart';
// import 'package:provider/provider.dart';

class InputCodLogin extends StatelessWidget {
  const InputCodLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final credencialesProvider = Provider.of<CredencialesProvider>(context, listen: true);

    return const Column(
      children: [
        InputTitle(title: "Código de colaborador"),
        SizedBox(height: 5),
        _InputCodeColaborador(),
        SizedBox(height: 12),
        LabelErrorInput(
          eval: true,
          customError: "Ingrese un código de colaborador válido",
        )
      ],
    );
  }
}

class _InputCodeColaborador extends StatefulWidget {
  const _InputCodeColaborador();
  // {
  // required this.credencialesProvider,
  //}

  // final CredencialesProvider credencialesProvider;

  @override
  State<_InputCodeColaborador> createState() => _InputCodeColaboradorState();
}

class _InputCodeColaboradorState extends State<_InputCodeColaborador> {
  @override
  Widget build(BuildContext context) {
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
            // widget.credencialesProvider.usuario = value;
            // widget.credencialesProvider.codeColaboradorValid = (value.length == 6 && isNumeric(value));
          },
          textAlign: TextAlign.start,
          autocorrect: false,
          keyboardType: TextInputType.number,
          cursorColor: AppTheme.colorStyleText,
          inputFormatters: [LengthLimitingTextInputFormatter(8)],
          decoration: AppTheme.getCustomDecorationInput(false), // widget.credencialesProvider.codeColaboradorValid ??
        ),
      ),
    );
  }
}
