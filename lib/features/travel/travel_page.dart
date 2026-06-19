import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/page_availability_gate.dart';
import '../placeholder_body.dart';

@RoutePage()
class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const TravelRoute());
  }

  @override
  Widget build(BuildContext context) {
    return PageAvailabilityGate(
      page: AppPage.vendors,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: WeddingSectionPlaceholder(
          title: 'TRAVEL & ACCOMMODATION',
          subtitle: 'Getting here, airports, trains, hotels…',
        ),
      ),
    );
  }
}
