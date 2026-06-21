import 'dart:async';

import 'package:alisha_dawid_wedding_website/assets/timeline_pins/timeline_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/wedding_details/timeline_entry.dart';
import '../../../utils/extension/context_extension.dart';

enum _TimelineTransitionPhase {
  idle,
  closing,
  scrolling,
  opening,
  selected;

  double expansionProgress({
    required int entryIndex,
    required int? selectedEntryIndex,
    required double naturalExpansionProgress,
    required double closingExpansionProgress,
    required double closeProgress,
    required double openProgress,
  }) =>
      switch (this) {
        idle => naturalExpansionProgress,
        closing => closingExpansionProgress * (1 - closeProgress),
        scrolling => 0,
        opening => selectedEntryIndex == entryIndex ? openProgress : 0,
        selected => selectedEntryIndex == entryIndex ? 1 : 0,
      };
}

enum _TimelineMetric {
  estimatedRowExtent(180),
  rowSpacing(42),
  railWidth(80),
  dotCenterY(32),
  pinImageScale(1.18),
  expandStartProgress(0.42),
  expandEndProgress(0.92);

  const _TimelineMetric(this.value);

  final double value;

  static double get focusRadius => estimatedRowExtent.value * 0.95;

  static double get focusHoldRadius => estimatedRowExtent.value * 0.28;
}

enum _TimelineDuration {
  close(Duration(milliseconds: 120)),
  scroll(Duration(milliseconds: 500)),
  open(Duration(milliseconds: 170));

  const _TimelineDuration(this.value);

  final Duration value;
}

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

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final scrollPosition = scrollableState?.position;
    final scrollListenable = scrollPosition ?? kAlwaysDismissedAnimation;

    final transitionPhase = useState(_TimelineTransitionPhase.idle);
    final transitionPhaseRef = useRef(transitionPhase.value);
    final selectedEntryIndex = useState<int?>(null);
    final selectedScrollOffset = useRef<double?>(null);

    final renderedExpansionValues = useRef<List<double>>(
      List.filled(entries.length, 0),
    );

    final closingExpansionValues = useRef<List<double>>(
      List.filled(entries.length, 0),
    );

    if (renderedExpansionValues.value.length != entries.length) {
      renderedExpansionValues.value = List.filled(entries.length, 0);
      closingExpansionValues.value = List.filled(entries.length, 0);
    }

    final closeController = useAnimationController(
      duration: _TimelineDuration.close.value,
    );

    final openController = useAnimationController(
      duration: _TimelineDuration.open.value,
    );

    final closeProgress = Curves.easeInCubic.transform(
      useAnimation(closeController),
    );

    final openProgress = Curves.easeOutCubic.transform(
      useAnimation(openController),
    );

    void setTransitionPhase(_TimelineTransitionPhase phase) {
      transitionPhaseRef.value = phase;
      transitionPhase.value = phase;
    }

    void returnToNaturalScrolling() {
      selectedEntryIndex.value = null;
      selectedScrollOffset.value = null;

      closeController
        ..stop()
        ..value = 0;

      openController
        ..stop()
        ..value = 0;

      setTransitionPhase(_TimelineTransitionPhase.idle);
    }

    useEffect(
      () {
        if (scrollPosition == null) {
          return null;
        }

        void handleScrollPositionChanged() {
          if (transitionPhaseRef.value != _TimelineTransitionPhase.selected) {
            return;
          }

          final lockedOffset = selectedScrollOffset.value;

          if (lockedOffset == null) {
            return;
          }

          final hasMovedAway = (scrollPosition.pixels - lockedOffset).abs() > 2;

          if (hasMovedAway) {
            returnToNaturalScrolling();
          }
        }

        scrollPosition.addListener(handleScrollPositionChanged);

        return () {
          scrollPosition.removeListener(handleScrollPositionChanged);
        };
      },
      [
        scrollPosition,
        closeController,
        openController,
      ],
    );

    Future<void> scrollToEntry({
      required int entryIndex,
      required BuildContext rowContext,
    }) async {
      if (scrollPosition == null) {
        return;
      }

      final scrollableContext = scrollableState?.context;

      final currentPhase = transitionPhaseRef.value;

      if (currentPhase == _TimelineTransitionPhase.closing ||
          currentPhase == _TimelineTransitionPhase.scrolling ||
          currentPhase == _TimelineTransitionPhase.opening) {
        return;
      }

      selectedEntryIndex.value = entryIndex;
      selectedScrollOffset.value = null;

      closingExpansionValues.value =
          List<double>.of(renderedExpansionValues.value);

      openController
        ..stop()
        ..value = 0;

      setTransitionPhase(_TimelineTransitionPhase.closing);

      await closeController.forward(from: 0);

      if (!rowContext.mounted) {
        returnToNaturalScrolling();
        return;
      }

      setTransitionPhase(_TimelineTransitionPhase.scrolling);

      await WidgetsBinding.instance.endOfFrame;

      if (!rowContext.mounted) {
        returnToNaturalScrolling();
        return;
      }

      if (scrollableContext != null && !scrollableContext.mounted) {
        returnToNaturalScrolling();
        return;
      }

      final rowRenderObject = rowContext.findRenderObject();
      final scrollableRenderObject = scrollableContext?.findRenderObject();

      if (rowRenderObject is! RenderBox ||
          !rowRenderObject.hasSize ||
          scrollableRenderObject is! RenderBox ||
          !scrollableRenderObject.hasSize) {
        returnToNaturalScrolling();
        return;
      }

      final focusY = scrollableRenderObject.localToGlobal(Offset.zero).dy +
          scrollableRenderObject.size.height * focusAlignment;

      final rowFocusY = rowRenderObject.localToGlobal(Offset.zero).dy +
          _TimelineMetric.dotCenterY.value;

      final requiredOffsetChange = rowFocusY - focusY;

      final targetOffset = (scrollPosition.pixels + requiredOffsetChange)
          .clamp(
            scrollPosition.minScrollExtent,
            scrollPosition.maxScrollExtent,
          )
          .toDouble();

      await scrollPosition.animateTo(
        targetOffset,
        duration: _TimelineDuration.scroll.value,
        curve: Curves.easeInOutCubic,
      );

      if (!rowContext.mounted) {
        returnToNaturalScrolling();
        return;
      }

      setTransitionPhase(_TimelineTransitionPhase.opening);

      await openController.forward(from: 0);

      if (!rowContext.mounted) {
        returnToNaturalScrolling();
        return;
      }

      selectedScrollOffset.value = scrollPosition.pixels;
      setTransitionPhase(_TimelineTransitionPhase.selected);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (topChild != null) topChild!,
        for (final indexedEntry in entries.indexed)
          _TimelineRowPositionReader(
            scrollListenable: scrollListenable,
            scrollableContext: scrollableState?.context,
            focusAlignment: focusAlignment,
            entryIndex: indexedEntry.$1,
            entry: indexedEntry.$2,
            transitionPhase: transitionPhase.value,
            selectedEntryIndex: selectedEntryIndex.value,
            closeProgress: closeProgress,
            openProgress: openProgress,
            closingExpansionProgress:
                closingExpansionValues.value[indexedEntry.$1],
            isFirst: indexedEntry.$1 == 0,
            isLast: indexedEntry.$1 == entries.length - 1,
            onExpansionResolved: (expansionProgress) {
              renderedExpansionValues.value[indexedEntry.$1] =
                  expansionProgress;
            },
            onTap: (rowContext) {
              unawaited(
                scrollToEntry(
                  entryIndex: indexedEntry.$1,
                  rowContext: rowContext,
                ),
              );
            },
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
    required this.entryIndex,
    required this.entry,
    required this.transitionPhase,
    required this.selectedEntryIndex,
    required this.closeProgress,
    required this.openProgress,
    required this.closingExpansionProgress,
    required this.isFirst,
    required this.isLast,
    required this.onExpansionResolved,
    required this.onTap,
  });

  final Listenable scrollListenable;
  final BuildContext? scrollableContext;
  final double focusAlignment;
  final int entryIndex;
  final TimelineEntry entry;
  final _TimelineTransitionPhase transitionPhase;
  final int? selectedEntryIndex;
  final double closeProgress;
  final double openProgress;
  final double closingExpansionProgress;
  final bool isFirst;
  final bool isLast;
  final ValueChanged<double> onExpansionResolved;
  final ValueChanged<BuildContext> onTap;

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
              rowFocusOffset: _TimelineMetric.dotCenterY.value,
              focusRadius: _TimelineMetric.focusRadius,
              focusHoldRadius: _TimelineMetric.focusHoldRadius,
            );

            final naturalExpansionProgress =
                expansionProgressForFocus(progress);

            final expansionProgress = transitionPhase.expansionProgress(
              entryIndex: entryIndex,
              selectedEntryIndex: selectedEntryIndex,
              naturalExpansionProgress: naturalExpansionProgress,
              closingExpansionProgress: closingExpansionProgress,
              closeProgress: closeProgress,
              openProgress: openProgress,
            );

            onExpansionResolved(expansionProgress);

            return _TimelineRow(
              entry: entry,
              progress: progress,
              expansionProgress: expansionProgress,
              isFirst: isFirst,
              isLast: isLast,
              onTap: () {
                onTap(rowContext);
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

double expansionProgressForFocus(double progress) {
  final rawProgress = ((progress - _TimelineMetric.expandStartProgress.value) /
          (_TimelineMetric.expandEndProgress.value -
              _TimelineMetric.expandStartProgress.value))
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
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final double expansionProgress;
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
            imageAssetPath: TimelineAssets.image(
              entry.title,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : _TimelineMetric.rowSpacing.value,
              ),
              child: _TimelineCard(
                entry: entry,
                progress: progress,
                expansionProgress: expansionProgress,
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
        hasImage ? _lerp(30, 76, progress) : _lerp(13, 26, progress);

    final dotColor = Color.lerp(
      context.colorScheme.primary.withValues(alpha: 0.35),
      context.colorScheme.primary,
      progress,
    )!;

    return SizedBox(
      width: _TimelineMetric.railWidth.value,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (!isFirst)
            Positioned(
              top: 0,
              height: _TimelineMetric.dotCenterY.value,
              left: (_TimelineMetric.railWidth.value - 2) / 2,
              child: const _TimelineRailLine(),
            ),
          if (!isLast)
            Positioned(
              top: _TimelineMetric.dotCenterY.value,
              bottom: 0,
              left: (_TimelineMetric.railWidth.value - 2) / 2,
              child: const _TimelineRailLine(),
            ),
          Positioned(
            top: _TimelineMetric.dotCenterY.value - dotSize / 2,
            left: (_TimelineMetric.railWidth.value - dotSize) / 2,
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
                                scale: _TimelineMetric.pinImageScale.value,
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
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final double expansionProgress;
  final VoidCallback onTap;

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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
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
      ),
    );
  }
}
