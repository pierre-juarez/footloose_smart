import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';

class TicketDescription extends StatelessWidget {
  const TicketDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(description, style: robotoStyle(13.5, FontWeight.w500, Colors.black));
  }
}
