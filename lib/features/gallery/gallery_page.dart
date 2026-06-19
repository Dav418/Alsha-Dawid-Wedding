import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/page_availability_gate.dart';
import '../placeholder_body.dart';

@RoutePage()
class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const GalleryRoute());
  }

  @override
  Widget build(BuildContext context) {
    return PageAvailabilityGate(
      page: AppPage.gallery,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: WeddingSectionPlaceholder(
          title: 'GALLERY',
          subtitle: 'Photo grid — filters: All, Engagement, Travel, Special…',
        ),
      ),
    );
  }
}
