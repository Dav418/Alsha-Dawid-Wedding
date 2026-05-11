import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class RsvpPage extends StatelessWidget {
  const RsvpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScenicPageBackground(
      child: WeddingSectionPlaceholder(
      title: 'RSVP',
      subtitle: 'Form — attendance, guests, dietary, song request…',
      ),
    );
  }
}
