import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Subscribes [listener] to [AutoRouteObserver] for the current route.
void useAutoRouteAware(AutoRouteAware listener) {
  final context = useContext();

  useEffect(
    () {
      final observer =
          RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();

      if (observer != null) {
        observer.subscribe(listener, context.routeData);
      }

      return () => observer?.unsubscribe(listener);
    },
    [context, listener],
  );
}
