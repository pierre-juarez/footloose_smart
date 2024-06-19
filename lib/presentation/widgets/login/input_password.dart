import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/widgets/input_title.dart';

class InputPassword extends ConsumerStatefulWidget {
  const InputPassword({
    super.key,
  });

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends ConsumerState<InputPassword> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

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
                    onChanged: (value) => auth.password = value,
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
