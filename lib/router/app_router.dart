import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  CustomRoute<void> _customRoute({
    required PageInfo page,
    required String path,
    bool initial = false,
  }) =>
      CustomRoute<void>(
        path: path,
        page: page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        duration: Duration.zero,
        reverseDuration: Duration.zero,
        maintainState: false,
        opaque: true,
        initial: initial,
      );
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WeddingShellRoute.page,
          path: '/',
          initial: true,
          children: [
            _customRoute(
              page: HomeRoute.page,
              path: '',
              initial: true,
            ),
            _customRoute(
              page: OurStoryRoute.page,
              path: 'our-story',
            ),
            _customRoute(
              page: WeddingDetailsRoute.page,
              path: 'details',
            ),
            _customRoute(
              page: RsvpRoute.page,
              path: 'rsvp',
            ),
            _customRoute(
              page: TravelRoute.page,
              path: 'travel',
            ),
            _customRoute(
              page: GalleryRoute.page,
              path: 'gallery',
            ),
            _customRoute(
              page: WeddingPartyRoute.page,
              path: 'wedding-party',
            ),
            _customRoute(
              page: FaqRoute.page,
              path: 'faq',
            ),
            _customRoute(
              page: CountdownRoute.page,
              path: 'countdown',
            ),
            _customRoute(
              page: CountdownTestRoute.page,
              path: 'countdown-test',
            ),
            _customRoute(
              page: LiveUpdatesRoute.page,
              path: 'live-updates',
            ),
          ],
        ),
      ];
}
