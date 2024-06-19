import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/input_title.dart';
// import 'package:provider/provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/credenciales_provider.dart';
// import 'package:footloose_puntodeventa/src/ui/common/style.dart';
// import 'package:footloose_puntodeventa/src/ui/shared/inputTitle.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    // final credencialesProvider = Provider.of<CredencialesProvider>(context);

    return Column(
      children: [
        const InputTitle(title: "Contraseña"),
        const SizedBox(height: 5),
        Container(
          height: 60.0,
          width: double.infinity,
          decoration: AppTheme.inputCustomDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: AppTheme.styleInput,
                    // onChanged: (value) => credencialesProvider.clave = value,
                    textAlign: TextAlign.start,
                    obscureText: _isHidden,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.white,
                    decoration: AppTheme.customDecorationCollapsed,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      _isHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
