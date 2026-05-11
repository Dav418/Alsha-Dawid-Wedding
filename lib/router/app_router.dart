import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WeddingShellRoute.page,
          path: '/',
          initial: true,
          children: [
            AutoRoute(page: HomeRoute.page, path: '', initial: true),
            AutoRoute(page: OurStoryRoute.page, path: 'our-story'),
            AutoRoute(page: WeddingDetailsRoute.page, path: 'details'),
            AutoRoute(page: RsvpRoute.page, path: 'rsvp'),
            AutoRoute(page: TravelRoute.page, path: 'travel'),
            AutoRoute(page: GalleryRoute.page, path: 'gallery'),
            AutoRoute(page: WeddingPartyRoute.page, path: 'wedding-party'),
            AutoRoute(page: FaqRoute.page, path: 'faq'),
            AutoRoute(page: CountdownRoute.page, path: 'countdown'),
          ],
        ),
      ];
}
