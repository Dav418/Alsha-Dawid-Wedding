import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/party_member.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/gold_heart_rule.dart';

const _bridesmaids = [
  PartyMember(firstName: 'Sonia', lastName: "D'Souza"),
  PartyMember(firstName: 'Priya', lastName: 'Patel'),
  PartyMember(firstName: 'Megan', lastName: 'Lewis'),
  PartyMember(firstName: 'Emma', lastName: 'Wilson'),
];

const _groomsmen = [
  PartyMember(firstName: 'James', lastName: 'Smith'),
  PartyMember(firstName: 'Luke', lastName: 'Brown'),
  PartyMember(firstName: 'Matthew', lastName: 'Clarke'),
  PartyMember(firstName: 'Daniel', lastName: 'Hughes'),
];

const _parents = [
  PartyMember(
    firstName: 'Anita',
    lastName: 'Fernandes',
    honorific: 'Mrs.',
  ),
  PartyMember(
    firstName: 'Anthony',
    lastName: 'Fernandes',
    honorific: 'Mr.',
  ),
  PartyMember(
    firstName: 'Gracyna',
    lastName: 'Gorska',
    honorific: 'Mrs.',
  ),
  PartyMember(
    firstName: 'Marek',
    lastName: 'Gorski',
    honorific: 'Mr.',
  ),
];

@RoutePage()
class WeddingPartyPage extends StatelessWidget {
  const WeddingPartyPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const WeddingPartyRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _PartyHeader(),
          const SizedBox(height: 28),
          const _PartySection(
            title: 'BRIDESMAIDS',
            members: _bridesmaids,
          ),
          const SizedBox(height: 28),
          const GoldHeartRule(),
          const SizedBox(height: 28),
          const _PartySection(
            title: 'GROOMSMEN',
            members: _groomsmen,
          ),
          const SizedBox(height: 28),
          const GoldHeartRule(),
          const SizedBox(height: 28),
          const _PartySection(
            title: 'PARENTS',
            members: _parents,
          ),
        ],
      ),
    );
  }
}

class _PartyHeader extends StatelessWidget {
  const _PartyHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Our Wedding Party',
          textAlign: TextAlign.center,
          style: AppTypography.scriptHero(scheme),
        ),
        const SizedBox(height: 10),
        Text(
          'THE PEOPLE BY OUR SIDE',
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(scheme),
        ),
      ],
    );
  }
}

class _PartySection extends StatelessWidget {
  const _PartySection({
    required this.title,
    required this.members,
  });

  final String title;
  final List<PartyMember> members;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.sectionCaps(scheme),
        ),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 520 ? 4 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisExtent: columns == 4 ? 168 : 176,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return _PartyPortrait(member: members[index]);
              },
            );
          },
        ),
      ],
    );
  }
}

class _PartyPortrait extends StatelessWidget {
  const _PartyPortrait({required this.member});

  final PartyMember member;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const portraitSize = 104.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: portraitSize,
          height: portraitSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.goldBrass.withValues(alpha: 0.35),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textCharcoal.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              member.assetPath,
              width: portraitSize,
              height: portraitSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _PortraitPlaceholder(
                firstName: member.firstName,
                lastName: member.lastName,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          member.displayName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.portraitName(scheme),
        ),
      ],
    );
  }
}

class _PortraitPlaceholder extends StatelessWidget {
  const _PortraitPlaceholder({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final initials =
        '${firstName.isNotEmpty ? firstName[0] : ''}'
        '${lastName.isNotEmpty ? lastName[0] : ''}';

    return ColoredBox(
      color: AppColors.dustyRose.withValues(alpha: 0.28),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: AppTypography.portraitInitials(scheme),
        ),
      ),
    );
  }
}
