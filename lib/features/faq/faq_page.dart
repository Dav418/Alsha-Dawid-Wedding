import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/repositories/wedding_content_repository.dart';
import '../../models/faq_item.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../router/app_router.gr.dart';
import '../../utils/open_contact_email.dart';
import '../../widgets/heart_divider.dart';

const _faqs = [
  FaqItem(
    question: 'CAN I BRING A PLUS ONE?',
    answer:
        "We've reserved a seat just for you. If your invitation includes a plus one, you'll see it on your RSVP card.",
  ),
  FaqItem(
    question: 'ARE CHILDREN INVITED?',
    answer:
        'Our wedding will be an adults-only celebration. We adore your little ones, '
        'but we hope you will understand and enjoy a well-deserved night off together.',
  ),
  FaqItem(
    question: 'WHAT TIME SHOULD I ARRIVE?',
    answer:
        'Please arrive by 1:45 PM so everyone is seated before the ceremony at 2:00 PM.',
  ),
  FaqItem(
    question: 'IS PARKING AVAILABLE?',
    answer:
        'Yes — free parking is available on site at both the church and The Grove. '
        'If you would rather not drive, Rickmansworth Station is about five minutes away by taxi. '
        'We would recommend allowing a little extra time on the day, as spaces can fill up quickly '
        'for a Saturday wedding in October. Ushers will be on hand to point you in the right direction '
        'when you arrive.',
  ),
  FaqItem(
    question: 'WHAT IS THE DRESS CODE?',
    answer:
        'Formal attire with black tie optional. Think romantic autumn elegance — rich tones, '
        'soft fabrics, and your finest celebration outfit. We would love it if you avoided wearing white or ivory.',
  ),
  FaqItem(
    question: 'WILL THE WEDDING BE INDOORS?',
    answer: 'Both the ceremony and reception are indoors.',
  ),
  FaqItem(
    question: 'WHEN SHOULD I RSVP BY?',
    answer:
        'Please respond by 1 August 2026 through the RSVP page on this site. '
        'If you think you should have heard from us and have not, do get in touch — we would hate for you to miss it.',
  ),
];

@RoutePage()
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const FaqRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _FaqHeader(),
          const SizedBox(height: 22),
          const HeartDivider(),
          const SizedBox(height: 22),
          for (var i = 0; i < _faqs.length; i++) ...[
            _FaqAccordionTile(item: _faqs[i]),
            if (i < _faqs.length - 1) const SizedBox(height: 12),
          ],
          const SizedBox(height: 32),
          const _FaqContactSection(),
        ],
      ),
    );
  }
}

class _FaqHeader extends StatelessWidget {
  const _FaqHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Frequently Asked Questions',
          textAlign: TextAlign.center,
          style: AppTypography.scriptHero(scheme, fontSize: 48, height: 1.08),
        ),
        const SizedBox(height: 10),
        Text(
          'EVERYTHING YOU NEED TO KNOW',
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(
            scheme,
            color: AppColors.sageGreen,
          ),
        ),
      ],
    );
  }
}

class _FaqAccordionTile extends HookWidget {
  const _FaqAccordionTile({required this.item});

  final FaqItem item;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.creamBackground.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.goldBrass.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textCharcoal.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => expanded.value = !expanded.value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.question,
                          style: AppTypography.faqQuestion(scheme),
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedRotation(
                        turns: expanded.value ? 0.125 : 0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        child: Text(
                          '+',
                          style: AppTypography.faqToggle(scheme),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                alignment: Alignment.topCenter,
                child: expanded.value
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                        child: Text(
                          item.answer,
                          style: AppTypography.faqAnswer(scheme),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqContactSection extends ConsumerWidget {
  const _FaqContactSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email =
        ref.watch(weddingContentRepositoryProvider).requireValue.contact.email;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Still have a question? Feel free to contact us.',
          textAlign: TextAlign.center,
          style: AppTypography.scriptQuote(scheme, fontSize: 28),
        ),
        const SizedBox(height: 20),
        Center(
          child: FilledButton(
            onPressed: () async {
              final opened = await openContactEmail(email);
              if (!opened && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not open email for $email.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(168, 44),
              padding: const EdgeInsets.symmetric(horizontal: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'CONTACT US',
              style: AppTypography.buttonLabel(scheme),
            ),
          ),
        ),
      ],
    );
  }
}
