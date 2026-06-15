import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

import '../config/google_maps_api_key.dart';

Future<void> ensureGoogleMapsLoaded() async {
  if (!isGoogleMapsConfigured) {
    return;
  }

  if (web.document.querySelector('script[data-google-maps-loader]') != null) {
    return;
  }

  final completer = Completer<void>();
  final script = web.document.createElement('script') as web.HTMLScriptElement;
  script.src = 'https://maps.googleapis.com/maps/api/js?key=$googleMapsApiKey';
  script.setAttribute('data-google-maps-loader', 'true');

  script.addEventListener(
    'load',
    ((web.Event _) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }).toJS,
  );
  script.addEventListener(
    'error',
    ((web.Event _) {
      if (!completer.isCompleted) {
        completer.completeError(
          StateError('Failed to load Google Maps JavaScript API'),
        );
      }
    }).toJS,
  );

  web.document.head!.appendChild(script);

  await completer.future.timeout(
    const Duration(seconds: 30),
    onTimeout: () => throw TimeoutException(
      'Timed out waiting for Google Maps JavaScript API',
    ),
  );
}
