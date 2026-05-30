import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/repositories/wedding_content_repository.dart';
import '../../models/polaroid_layout.dart';
import '../../models/story_timeline_entry.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/heart_divider.dart';
import 'our_story_decorations.dart';

const _storyTimeline = [
  StoryTimelineEntry(
    title: 'HOW WE MET',
    description:
        'A chance meeting turned into a conversation that never ended.',
  ),
  StoryTimelineEntry(
    title: 'FIRST DATE',
    description: 'Good food, laughter and butterflies.',
  ),
  StoryTimelineEntry(
    title: 'THE PROPOSAL',
    description: 'The moment I said yes to forever.',
  ),
  StoryTimelineEntry(
    title: 'FAVOURITE MEMORIES',
    description: 'All the little moments that mean everything.',
  ),
  StoryTimelineEntry(
    title: "WHAT WE'RE LOOKING FORWARD TO",
    description: 'A lifetime of love, adventures and memories together.',
  ),
];

const _polaroidLayouts = [
  PolaroidLayout(top: 12, left: 8, rotation: -0.07),
  PolaroidLayout(top: 130, left: 30, rotation: 0.05),
  PolaroidLayout(top: 240, left: 10, rotation: -0.04),
  PolaroidLayout(top: 350, left: 34, rotation: 0.06),
];

/// Keeps copy readable on full-width browser windows.
const _maxPageWidth = 920.0;

/// Side-by-side only when the constrained column is wide enough.
const _sideBySideBreakpoint = 680.0;

const _basePolaroidWidth = 168.0;

@RoutePage()
class OurStoryPage extends ConsumerWidget {
  const OurStoryPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const OurStoryRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoUrls = ref
        .watch(weddingContentRepositoryProvider)
        .requireValue
        .ourStoryPhotoUrls;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxPageWidth),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final sideBySide = constraints.maxWidth >= _sideBySideBreakpoint;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _StoryHeader(),
                  const SizedBox(height: 28),
                  if (sideBySide)
                    _StorySideBySide(
                      photoUrls: photoUrls,
                      timeline: _storyTimeline,
                    )
                  else ...[
                    _StoryPhotoStack(
                      photoUrls: photoUrls,
                      compact: true,
                    ),
                    const SizedBox(height: 28),
                    _StoryTimeline(entries: _storyTimeline),
                  ],
                  const SizedBox(height: 36),
                  const _StoryFooter(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StoryHeader extends StatelessWidget {
  const _StoryHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Our Story',
          textAlign: TextAlign.center,
          style: AppTypography.scriptHero(scheme),
        ),
        const SizedBox(height: 10),
        const HeartAccent(),
        const SizedBox(height: 10),
        Text(
          'A LITTLE BIT OF OUR JOURNEY',
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(scheme),
        ),
      ],
    );
  }
}

class _StorySideBySide extends StatelessWidget {
  const _StorySideBySide({
    required this.photoUrls,
    required this.timeline,
  });

  final List<String> photoUrls;
  final List<StoryTimelineEntry> timeline;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 11,
          child: Align(
            alignment: Alignment.topCenter,
            child: _StoryPhotoStack(photoUrls: photoUrls),
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 13,
          child: _StoryTimeline(entries: timeline),
        ),
      ],
    );
  }
}

class _StoryPhotoStack extends StatelessWidget {
  const _StoryPhotoStack({
    required this.photoUrls,
    this.compact = false,
  });

  final List<String> photoUrls;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final count = photoUrls.length.clamp(0, _polaroidLayouts.length);

    if (compact) {
      const photoWidth = 150.0;
      final slotSize = _PolaroidPhoto.rotatedBounds(
        width: photoWidth,
        rotation: 0.06,
      );

      return SizedBox(
        height: slotSize.height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemCount: count,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final layout = _polaroidLayouts[index];
            return SizedBox(
              width: slotSize.width,
              height: slotSize.height,
              child: Center(
                child: _PolaroidPhoto(
                  imageUrl: photoUrls[index],
                  rotation: layout.rotation,
                  width: photoWidth,
                ),
              ),
            );
          },
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = constraints.maxWidth;
        final photoWidth = columnWidth.isFinite && columnWidth > 0
            ? (columnWidth * 0.58).clamp(_basePolaroidWidth, 210.0)
            : _basePolaroidWidth;
        final scale = photoWidth / _basePolaroidWidth;
        final layouts = [
          for (var i = 0; i < count; i++)
            PolaroidLayout(
              top: _polaroidLayouts[i].top * scale,
              left: _polaroidLayouts[i].left * scale,
              rotation: _polaroidLayouts[i].rotation,
            ),
        ];
        final stackHeight = _PolaroidPhoto.stackHeight(
          layouts: layouts,
          width: photoWidth,
        );
        final stackWidth = _PolaroidPhoto.stackWidth(
          layouts: layouts,
          width: photoWidth,
        );

        return SizedBox(
          height: stackHeight,
          width: double.infinity,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: stackWidth,
              height: stackHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (var i = 0; i < count; i++)
                    Positioned(
                      top: layouts[i].top,
                      left: layouts[i].left,
                      child: _PolaroidPhoto(
                        imageUrl: photoUrls[i],
                        rotation: layouts[i].rotation,
                        width: photoWidth,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PolaroidPhoto extends StatelessWidget {
  const _PolaroidPhoto({
    required this.imageUrl,
    required this.rotation,
    this.width = 168,
  });

  final String imageUrl;
  final double rotation;
  final double width;

  static Size frameSize(double width) {
    final imageHeight = width * 0.92;
    return Size(width, 10 + imageHeight + width * 0.18 + 10);
  }

  static Size rotatedBounds({
    required double width,
    required double rotation,
  }) {
    final frame = frameSize(width);
    const shadowPadding = 16.0;
    final boundsWidth = frame.width * math.cos(rotation).abs() +
        frame.height * math.sin(rotation).abs() +
        shadowPadding;
    final boundsHeight = frame.width * math.sin(rotation).abs() +
        frame.height * math.cos(rotation).abs() +
        shadowPadding;
    return Size(boundsWidth, boundsHeight);
  }

  static double stackHeight({
    required List<PolaroidLayout> layouts,
    required double width,
  }) {
    if (layouts.isEmpty) {
      return 0;
    }

    var maxBottom = 0.0;
    for (final layout in layouts) {
      final bounds = rotatedBounds(width: width, rotation: layout.rotation);
      maxBottom = math.max(maxBottom, layout.top + bounds.height);
    }
    return maxBottom + 12;
  }

  static double stackWidth({
    required List<PolaroidLayout> layouts,
    required double width,
  }) {
    if (layouts.isEmpty) {
      return 0;
    }

    var maxRight = 0.0;
    for (final layout in layouts) {
      final bounds = rotatedBounds(width: width, rotation: layout.rotation);
      maxRight = math.max(maxRight, layout.left + bounds.width);
    }
    return maxRight + 12;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final imageHeight = width * 0.92;

    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.polaroidWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.textCharcoal.withValues(alpha: 0.14),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, width * 0.18),
        child: Image.network(
          imageUrl,
          width: width - 20,
          height: imageHeight,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return Container(
              width: width - 20,
              height: imageHeight,
              color: AppColors.creamBackground,
              alignment: Alignment.center,
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: scheme.tertiary.withValues(alpha: 0.7),
                ),
              ),
            );
          },
          errorBuilder: (_, __, ___) => Container(
            width: width - 20,
            height: imageHeight,
            color: AppColors.dustyRose.withValues(alpha: 0.35),
            alignment: Alignment.center,
            child: Icon(
              Icons.image_outlined,
              color: scheme.primary.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryTimeline extends StatelessWidget {
  const _StoryTimeline({required this.entries});

  final List<StoryTimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final gold = scheme.tertiary;

    return Column(
      children: [
        for (var i = 0; i < entries.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28,
                  child: Column(
                    children: [
                      const HeartAccent(),
                      if (i < entries.length - 1)
                        Expanded(
                          child: Container(
                            width: 1,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: gold.withValues(alpha: 0.5),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: i < entries.length - 1 ? 26 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entries[i].title,
                          style: AppTypography.timelineTitle(scheme),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          entries[i].description,
                          style: AppTypography.timelineBody(scheme),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _StoryFooter extends StatelessWidget {
  const _StoryFooter();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const StoryFooterFlourish(),
        const SizedBox(height: 22),
        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'From the moment we met, we knew our story was worth writing.',
              textAlign: TextAlign.center,
              style: AppTypography.scriptQuote(scheme),
            ),
          ),
        ),
      ],
    );
  }
}
