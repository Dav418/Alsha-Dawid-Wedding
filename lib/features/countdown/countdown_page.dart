import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScenicPageBackground(
      child: WeddingSectionPlaceholder(
      title: 'COUNTDOWN',
      subtitle: 'Counting down — schedule, venue, live updates, contact…',
      ),
    );
  }
}
