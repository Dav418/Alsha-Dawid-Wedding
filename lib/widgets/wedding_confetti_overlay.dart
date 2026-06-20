import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/extension/context_extension.dart';

ConfettiController useWeddingConfettiController({
  Duration duration = const Duration(seconds: 4),
}) {
  final controller = useMemoized(() => ConfettiController(duration: duration));
  useEffect(() => controller.dispose, [controller]);
  return controller;
}

/// Mounts a full-screen [ConfettiWidget] in the root overlay for the widget lifetime.
void useWeddingConfettiOverlay(
  BuildContext context,
  ConfettiController controller,
) {
  final overlayEntry = useRef<OverlayEntry?>(null);

  useEffect(() {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      return null;
    }

    var disposed = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (disposed || !context.mounted) {
        return;
      }

      overlayEntry.value = OverlayEntry(
        builder: (overlayContext) => Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: controller,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.04,
                numberOfParticles: 24,
                maxBlastForce: 28,
                minBlastForce: 12,
                gravity: 0.18,
                colors: [
                  overlayContext.burgundyAccent,
                  overlayContext.goldBrass,
                  overlayContext.dustyRose,
                  overlayContext.sageGreen,
                  overlayContext.blushPeach,
                ],
              ),
            ),
          ),
        ),
      );
      overlay.insert(overlayEntry.value!);
    });

    return () {
      disposed = true;
      overlayEntry.value?.remove();
      overlayEntry.value = null;
    };
  }, [context, controller]);
}
