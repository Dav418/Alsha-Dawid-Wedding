import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_page.dart';
import '../providers/page_availability_provider.dart';
import 'under_construction_widget.dart';

class PageAvailabilityGate extends ConsumerWidget {
  const PageAvailabilityGate({
    required this.page,
    required this.child,
    super.key,
  });

  final AppPage page;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availability = ref.watch(pageAvailabilityProvider);
    if (isPageWorking(availability, page)) {
      return child;
    }

    return UnderConstructionWidget(page: page);
  }
}
