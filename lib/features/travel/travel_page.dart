import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScenicPageBackground.content(
      child: WeddingSectionPlaceholder(
      title: 'TRAVEL & ACCOMMODATION',
      subtitle: 'Getting here, airports, trains, hotels…',
      ),
    );
  }
}
