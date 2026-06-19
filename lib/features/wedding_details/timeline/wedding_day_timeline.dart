import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import 'timeline_entry.dart';
import 'timeline_image_position.dart';

class WeddingDayTimeline extends HookWidget {
  const WeddingDayTimeline({
    required this.entries,
    this.trailingChild,
    this.trailingChildOverlap = 64,
    this.viewportHeightFactor = 0.62,
    this.focusAlignment = 0.26,
    super.key,
  });

  final List<TimelineEntry> entries;
  final Widget? trailingChild;
  final double trailingChildOverlap;
  final double viewportHeightFactor;
  final double focusAlignment;

  static const _rowExtent = 230.0;
  static const _railWidth = 46.0;
  static const _dotCenterY = 46.0;
  static const _focusRadius = _rowExtent * 0.85;
  static const _focusHoldRadius = _rowExtent * 0.28;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final expandedIndexes = useState<Set<int>>(<int>{});

    final viewportHeight =
        MediaQuery.sizeOf(context).height * viewportHeightFactor;

    final focusY = viewportHeight * focusAlignment;

    final topPadding = math.max(
      16.0,
      focusY - _rowExtent / 2,
    );

    final bottomPadding = trailingChild == null
        ? math.max(
            16.0,
            viewportHeight - focusY - _rowExtent / 2,
          )
        : 16.0;

    final itemCount = entries.length + (trailingChild == null ? 0 : 1);

    return SizedBox(
      height: viewportHeight,
      child: AnimatedBuilder(
        animation: scrollController,
        builder: (context, _) {
          final scrollOffset =
              scrollController.hasClients ? scrollController.offset : 0.0;

          return ListView.builder(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: bottomPadding,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == entries.length) {
                return Transform.translate(
                  offset: Offset(0, -trailingChildOverlap),
                  child: trailingChild!,
                );
              }

              final progress = focusProgressForItem(
                scrollOffset: scrollOffset,
                itemIndex: index,
                itemExtent: _rowExtent,
                itemFocusOffset: _dotCenterY,
                focusY: focusY,
                topPadding: topPadding,
                focusRadius: _focusRadius,
                focusHoldRadius: _focusHoldRadius,
              );

              final isExpanded = expandedIndexes.value.contains(index);

              return SizedBox(
                height: _rowExtent,
                child: _TimelineRow(
                  entry: entries[index],
                  progress: progress,
                  isExpanded: isExpanded,
                  isLeft: index.isEven,
                  isFirst: index == 0,
                  isLast: index == entries.length - 1,
                  onTap: () {
                    final updatedIndexes = {...expandedIndexes.value};

                    if (isExpanded) {
                      updatedIndexes.remove(index);
                    } else {
                      updatedIndexes.add(index);
                    }

                    expandedIndexes.value = updatedIndexes;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

double focusProgressForItem({
  required double scrollOffset,
  required int itemIndex,
  required double itemExtent,
  required double itemFocusOffset,
  required double focusY,
  required double topPadding,
  required double focusRadius,
  required double focusHoldRadius,
}) {
  final itemFocusY =
      topPadding + itemIndex * itemExtent + itemFocusOffset - scrollOffset;

  final distanceFromFocus = (itemFocusY - focusY).abs();

  if (distanceFromFocus <= focusHoldRadius) {
    return 1.0;
  }

  final fadeDistance = distanceFromFocus - focusHoldRadius;
  final fadeRadius = focusRadius - focusHoldRadius;
  final rawProgress = 1 - fadeDistance / fadeRadius;

  return rawProgress.clamp(0.0, 1.0).toDouble();
}

double _lerp(double start, double end, double progress) {
  return start + (end - start) * progress;
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.entry,
    required this.progress,
    required this.isExpanded,
    required this.isLeft,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final bool isExpanded;
  final bool isLeft;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final card = _TimelineSideCard(
      entry: entry,
      progress: progress,
      isExpanded: isExpanded,
      isLeft: isLeft,
      onTap: onTap,
    );

    return Row(
      children: [
        Expanded(
          child: isLeft ? card : const SizedBox.shrink(),
        ),
        _TimelineDot(
          progress: progress,
          isFirst: isFirst,
          isLast: isLast,
        ),
        Expanded(
          child: isLeft ? const SizedBox.shrink() : card,
        ),
      ],
    );
  }
}

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({
    required this.progress,
    required this.isFirst,
    required this.isLast,
  });

  final double progress;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final dotSize = _lerp(13, 26, progress);
    final dotColor = Color.lerp(
      scheme.primary.withValues(alpha: 0.35),
      scheme.primary,
      progress,
    )!;

    return SizedBox(
      width: WeddingDayTimeline._railWidth,
      height: WeddingDayTimeline._rowExtent,
      child: Stack(
        children: [
          if (!isFirst)
            const Positioned(
              top: 0,
              bottom: WeddingDayTimeline._rowExtent -
                  WeddingDayTimeline._dotCenterY,
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
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.goldBrass.withValues(
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
      color: AppColors.goldBrass.withValues(alpha: 0.25),
    );
  }
}

class _TimelineSideCard extends StatelessWidget {
  const _TimelineSideCard({
    required this.entry,
    required this.progress,
    required this.isExpanded,
    required this.isLeft,
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final bool isExpanded;
  final bool isLeft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLeft ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: isLeft ? 12 : 0,
          right: isLeft ? 0 : 12,
        ),
        child: _TimelineCard(
          entry: entry,
          progress: progress,
          isExpanded: isExpanded,
          isLeft: isLeft,
          onTap: onTap,
        ),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.entry,
    required this.progress,
    required this.isExpanded,
    required this.isLeft,
    required this.onTap,
  });

  final TimelineEntry entry;
  final double progress;
  final bool isExpanded;
  final bool isLeft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final cardOpacity = _lerp(0.36, 1.0, progress);
    final textOpacity = _lerp(0.45, 1.0, progress);

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
              color: AppColors.creamBackground.withValues(alpha: 0.76),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.goldBrass.withValues(
                  alpha: _lerp(0.14, 0.42, progress),
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  if (entry.imageAssetPath != null)
                    Positioned.fill(
                      child: Align(
                        alignment: _alignmentFor(entry.imagePosition),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AnimatedOpacity(
                            opacity: isExpanded ? textOpacity : 0,
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                entry.imageAssetPath!,
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      isLeft ? 36 : 14,
                      14,
                      isLeft ? 14 : 36,
                      14,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: isLeft
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: textOpacity,
                          child: Text(
                            entry.time,
                            textAlign:
                                isLeft ? TextAlign.right : TextAlign.left,
                            style: AppTypography.cardTime(scheme),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Opacity(
                          opacity: textOpacity,
                          child: Text(
                            entry.title,
                            textAlign:
                                isLeft ? TextAlign.right : TextAlign.left,
                            softWrap: true,
                            style: AppTypography.cardTitleCaps(
                              scheme,
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
                                    textAlign: isLeft
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.bodySerif(
                                      scheme,
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
                    left: isLeft ? 12 : null,
                    right: isLeft ? null : 12,
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
    final scheme = Theme.of(context).colorScheme;

    return AnimatedRotation(
      turns: isExpanded ? 0.125 : 0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Text(
        '+',
        style: AppTypography.faqToggle(scheme),
      ),
    );
  }
}

Alignment _alignmentFor(TimelineImagePosition position) {
  return switch (position) {
    TimelineImagePosition.topLeft => Alignment.topLeft,
    TimelineImagePosition.topRight => Alignment.topRight,
    TimelineImagePosition.bottomLeft => Alignment.bottomLeft,
    TimelineImagePosition.bottomRight => Alignment.bottomRight,
  };
}
