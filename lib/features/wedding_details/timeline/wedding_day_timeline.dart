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
  static const _railWidth = 80.0;
  static const _dotCenterY = 32.0;
  static const _focusRadius = _estimatedRowExtent * 0.95;
  static const _focusHoldRadius = _estimatedRowExtent * 0.28;
  static const _pinImageScale = 1.18;
  static const _expandStartProgress = 0.42;
  static const _expandEndProgress = 0.92;

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

class _TimelineRowPositionReader extends StatelessWidget {
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

            final expansionProgress = expansionProgressForFocus(progress);

            return _TimelineRow(
              entry: entry,
              progress: progress,
              expansionProgress: expansionProgress,
              isFirst: isFirst,
              isLast: isLast,
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

double expansionProgressForFocus(double progress) {
  final rawProgress = ((progress - WeddingDayTimeline._expandStartProgress) /
          (WeddingDayTimeline._expandEndProgress -
              WeddingDayTimeline._expandStartProgress))
      .clamp(0.0, 1.0)
      .toDouble();

  return Curves.easeOutCubic.transform(rawProgress);
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
    required this.expansionProgress,
    required this.isFirst,
    required this.isLast,
  });

  final TimelineEntry entry;
  final double progress;
  final double expansionProgress;
  final bool isFirst;
  final bool isLast;

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
                expansionProgress: expansionProgress,
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
        hasImage ? _lerp(30, 76, progress) : _lerp(13, 26, progress);

    final dotColor = Color.lerp(
      context.colorScheme.primary.withValues(alpha: 0.35),
      context.colorScheme.primary,
      progress,
    )!;

    return SizedBox(
      width: WeddingDayTimeline._railWidth,
      child: Stack(
        clipBehavior: Clip.none,
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
            child: hasImage
                ? Opacity(
                    opacity: _lerp(0.58, 1.0, progress),
                    child: SizedBox(
                      width: dotSize,
                      height: dotSize,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipOval(
                              child: Transform.scale(
                                scale: WeddingDayTimeline._pinImageScale,
                                child: Image.asset(
                                  imageAssetPath!,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.goldBrass.withValues(
                          alpha: _lerp(0.45, 0.8, progress),
                        ),
                        width: _lerp(1.5, 2.5, progress),
                      ),
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

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.entry,
    required this.progress,
    required this.expansionProgress,
  });

  final TimelineEntry entry;
  final double progress;
  final double expansionProgress;

  @override
  Widget build(BuildContext context) {
    final hasIcon = entry.icon != null;
    final cardOpacity = _lerp(0.36, 1.0, progress);
    final textOpacity = _lerp(0.45, 1.0, progress);
    final detailsOpacity = textOpacity * expansionProgress;
    final iconMaxOpacity = _lerp(0.04, 0.095, progress);
    final iconOpacity = expansionProgress * textOpacity * iconMaxOpacity;

    return Opacity(
      opacity: cardOpacity,
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
                        opacity: iconOpacity,
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
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: expansionProgress,
                          child: Opacity(
                            opacity: detailsOpacity,
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
            ],
          ),
        ),
      ),
    );
  }
}
