import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/app_router.gr.dart';
import '../placeholder_body.dart';

@RoutePage()
class RsvpPage extends StatelessWidget {
  const RsvpPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const RsvpRoute());
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: WeddingSectionPlaceholder(
        title: 'RSVP',
        subtitle: 'Form — attendance, guests, dietary, song request…',
      ),
    );
  }
}
