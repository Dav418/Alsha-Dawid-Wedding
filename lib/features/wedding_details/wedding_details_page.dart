import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class WeddingDetailsPage extends StatelessWidget {
  const WeddingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScenicPageBackground(
      child: WeddingSectionPlaceholder(
      title: 'WEDDING DETAILS',
      subtitle: 'Ceremony, reception, dress code, transport…',
      ),
    );
  }
}
