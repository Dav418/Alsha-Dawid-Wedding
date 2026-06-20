import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/wedding_details/timeline_entry.dart';
import '../../../utils/extension/context_extension.dart';

class WeddingDayTimeline extends HookWidget {
  const WeddingDayTimeline({
    required this.entries,
    this.topChild,
    this.trailingChild,
    this.focusAlignment = 0.42,
    super.key,
  });

  final List<TimelineEntry> entries;
  final Widget? topChild;
  final Widget? trailingChild;
  final double focusAlignment;

  static const _estimatedRowExtent = 180.0;
  static const _rowSpacing = 42.0;
  static const _railWidth = 42.0;
  static const _dotCenterY = 32.0;
  static const _focusRadius = _estimatedRowExtent * 0.95;
  static const _focusHoldRadius = _estimatedRowExtent * 0.28;

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final scrollListenable =
        scrollableState?.position ?? kAlwaysDismissedAnimation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (topChild != null) topChild!,
        for (final indexedEntry in entries.indexed)
          _TimelineRowPositionReader(
            scrollListenable: scrollListenable,
            scrollableContext: scrollableState?.context,
            focusAlignment: focusAlignment,
            entry: indexedEntry.$2,
            isFirst: indexedEntry.$1 == 0,
            isLast: indexedEntry.$1 == entries.length - 1,
          ),
        if (trailingChild != null) trailingChild!,
      ],
    );
  }
}

class _TimelineRowPositionReader extends HookWidget {
  const _TimelineRowPositionReader({
    required this.scrollListenable,
    required this.scrollableContext,
    required this.focusAlignment,
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  final Listenable scrollListenable;
  final BuildContext? scrollableContext;
  final double focusAlignment;
  final TimelineEntry entry;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);

    return LayoutBuilder(
      builder: (rowContext, _) {
        return AnimatedBuilder(
          animation: scrollListenable,
          builder: (context, _) {
            final progress = focusProgressForRow(
              scrollableContext: scrollableContext,
              rowContext: rowContext,
              focusAlignment: focusAlignment,
              rowFocusOffset: WeddingDayTimeline._dotCenterY,
              focusRadius: WeddingDayTimeline._focusRadius,
              focusHoldRadius: WeddingDayTimeline._focusHoldRadius,
            );

            return _TimelineRow(
              entry: entry,
              progress: progress,
              isExpanded: expanded.value,
              isFirst: isFirst,
              isLast: isLast,
              onTap: () {
                expanded.value = !expanded.value;
              },
            );
          },
        );
      },
    );
  }
}

double focusProgressForRow({
  required BuildContext? scrollableContext,
  required BuildContext rowContext,
  required double focusAlignment,
  required double rowFocusOffset,
  required double focusRadius,
  required double focusHoldRadius,
}) {
  final rowTopY = _globalTopOf(rowContext);
  final focusY = _focusYFor(
    scrollableContext: scrollableContext,
    fallbackContext: rowContext,
    focusAlignment: focusAlignment,
  );

  final rowFocusY = rowTopY + rowFocusOffset;
  final distanceFromFocus = (rowFocusY - focusY).abs();

  if (distanceFromFocus <= focusHoldRadius) {
    return 1.0;
  }

  final fadeDistance = distanceFromFocus - focusHoldRadius;
  final fadeRadius = focusRadius - focusHoldRadius;
  final rawProgress = 1 - fadeDistance / fadeRadius;

  return rawProgress.clamp(0.0, 1.0).toDouble();
}

double _focusYFor({
  required BuildContext? scrollableContext,
  required BuildContext fallbackContext,
  required double focusAlignment,
}) {
  final scrollableRenderObject = scrollableContext?.findRenderObject();

  if (scrollableRenderObject is RenderBox && scrollableRenderObject.hasSize) {
    return scrollableRenderObject.localToGlobal(Offset.zero).dy +
        scrollableRenderObject.size.height * focusAlignment;
  }

  final fallbackSize = MediaQuery.maybeSizeOf(fallbackContext);

  if (fallbackSize == null) {
    return 0;
  }

  return fallbackSize.height * focusAlignment;
}

double _globalTopOf(BuildContext context) {
  final renderObject = context.findRenderObject();

  if (renderObject is! RenderBox || !renderObject.hasSize) {
    return 0;
  }

  return renderObject.localToGlobal(Offset.zero).dy;
}

double _lerp(double start, double end, double progress) {
  return start + (end - start) * progress;
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.entry,
    required this.progress,
    required this.isExpanded,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final bool isExpanded;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TimelineRail(
            progress: progress,
            isFirst: isFirst,
            isLast: isLast,
            imageAssetPath: entry.pinImageAssetPath,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : WeddingDayTimeline._rowSpacing,
              ),
              child: _TimelineCard(
                entry: entry,
                progress: progress,
                isExpanded: isExpanded,
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({
    required this.progress,
    required this.isFirst,
    required this.isLast,
    required this.imageAssetPath,
  });

  final double progress;
  final bool isFirst;
  final bool isLast;
  final String? imageAssetPath;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageAssetPath != null;

    final dotSize =
        hasImage ? _lerp(24, 38, progress) : _lerp(13, 26, progress);

    final dotColor = Color.lerp(
      context.colorScheme.primary.withValues(alpha: 0.35),
      context.colorScheme.primary,
      progress,
    )!;

    return SizedBox(
      width: WeddingDayTimeline._railWidth,
      child: Stack(
        children: [
          if (!isFirst)
            const Positioned(
              top: 0,
              height: WeddingDayTimeline._dotCenterY,
              left: (WeddingDayTimeline._railWidth - 2) / 2,
              child: _TimelineRailLine(),
            ),
          if (!isLast)
            const Positioned(
              top: WeddingDayTimeline._dotCenterY,
              bottom: 0,
              left: (WeddingDayTimeline._railWidth - 2) / 2,
              child: _TimelineRailLine(),
            ),
          Positioned(
            top: WeddingDayTimeline._dotCenterY - dotSize / 2,
            left: (WeddingDayTimeline._railWidth - dotSize) / 2,
            child: Opacity(
              opacity: hasImage ? _lerp(0.58, 1.0, progress) : 1,
              child: Container(
                width: dotSize,
                height: dotSize,
                padding: EdgeInsets.all(hasImage ? 2 : 0),
                decoration: BoxDecoration(
                  color: hasImage
                      ? context.creamBackground.withValues(alpha: 0.92)
                      : dotColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.goldBrass.withValues(
                      alpha: _lerp(0.45, 0.8, progress),
                    ),
                    width: _lerp(1.5, 2.5, progress),
                  ),
                ),
                child: hasImage
                    ? ClipOval(
                        child: Image.asset(
                          imageAssetPath!,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineRailLine extends StatelessWidget {
  const _TimelineRailLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      color: context.goldBrass.withValues(alpha: 0.25),
    );
  }
}

class _TimelineCard extends HookWidget {
  const _TimelineCard({
    required this.entry,
    required this.progress,
    required this.isExpanded,
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    final iconController = useAnimationController(
      duration: const Duration(milliseconds: 950),
    );

    final iconAnimation = useMemoized(
      () => iconController.drive(
        CurveTween(
          curve: const Interval(
            0.28,
            1,
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
      [iconController],
    );

    final iconOpacity = useAnimation(iconAnimation);

    useEffect(
      () {
        if (isExpanded) {
          iconController.forward(from: 0);
        } else {
          iconController.stop();
          iconController.value = 0;
        }

        return null;
      },
      [isExpanded],
    );

    final hasIcon = entry.icon != null;
    final cardOpacity = _lerp(0.36, 1.0, progress);
    final textOpacity = _lerp(0.45, 1.0, progress);
    final iconMaxOpacity = _lerp(0.04, 0.095, progress);

    return Opacity(
      opacity: cardOpacity,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.creamBackground.withValues(alpha: 0.76),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.goldBrass.withValues(
                  alpha: _lerp(0.14, 0.42, progress),
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  if (hasIcon)
                    Positioned(
                      right: -24,
                      bottom: -28,
                      child: IgnorePointer(
                        child: Transform.rotate(
                          angle: -0.08,
                          child: Opacity(
                            opacity: isExpanded
                                ? iconOpacity * textOpacity * iconMaxOpacity
                                : 0,
                            child: Icon(
                              entry.icon,
                              size: 104,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 42, 14),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: textOpacity,
                          child: Text(
                            entry.time,
                            textAlign: TextAlign.left,
                            style: context.cardTime(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Opacity(
                          opacity: textOpacity,
                          child: Text(
                            entry.title,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: context.cardTitleCaps(
                              fontSize: 12,
                              letterSpacing: 1.3,
                            ),
                          ),
                        ),
                        if (entry.details != null)
                          ClipRect(
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              alignment: Alignment.topCenter,
                              heightFactor: isExpanded ? 1 : 0,
                              child: AnimatedOpacity(
                                opacity: isExpanded ? textOpacity : 0,
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeOut,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    entry.details!,
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    style: context.bodySerif(
                                      fontSize: 12,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: _TimelineCardToggle(
                      isExpanded: isExpanded,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineCardToggle extends StatelessWidget {
  const _TimelineCardToggle({
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {

    return AnimatedRotation(
      turns: isExpanded ? 0.125 : 0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Text(
        '+',
        style: context.faqToggle(),
      ),
    );
  }
}
