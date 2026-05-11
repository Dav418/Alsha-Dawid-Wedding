import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScenicPageBackground(
      child: WeddingSectionPlaceholder(
      title: 'FAQ',
      subtitle: 'Accordion Q&A — plus ones, parking…',
      ),
    );
  }
}
