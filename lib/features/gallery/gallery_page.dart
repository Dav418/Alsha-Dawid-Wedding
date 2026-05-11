import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../placeholder_body.dart';
import '../../widgets/scenic_page_background.dart';

@RoutePage()
class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScenicPageBackground(
      child: WeddingSectionPlaceholder(
      title: 'GALLERY',
      subtitle: 'Photo grid — filters: All, Engagement, Travel, Special…',
      ),
    );
  }
}
