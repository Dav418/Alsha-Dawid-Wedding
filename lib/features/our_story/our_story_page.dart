import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class OurStoryPage extends StatelessWidget {
  const OurStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScenicPageBackground(
      child: WeddingSectionPlaceholder(
      title: 'OUR STORY',
      subtitle: 'Timeline — how we met, dates, proposal…',
      ),
    );
  }
}
