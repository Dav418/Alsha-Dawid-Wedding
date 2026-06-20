import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../assets/wedding_party/wedding_party_assets.dart';
import '../../content/data/wedding_content.dart';
import '../../content/repositories/wedding_content_repository.dart';
import '../../models/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/page_availability_gate.dart';
import '../../widgets/party_member_polaroid_overlay.dart';
import '../../utils/extension/context_extension.dart';

@RoutePage()
class WeddingPartyPage extends ConsumerWidget {
  const WeddingPartyPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const WeddingPartyRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final party =
        ref.watch(weddingContentRepositoryProvider).requireValue.weddingParty;

    return PageAvailabilityGate(
      page: AppPage.weddingParty,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PartyHeader(),
            const SizedBox(height: 28),
            _PartySection(
              title: 'BRIDESMAIDS',
              members: party.bridesmaids,
            ),
            const SizedBox(height: 28),
            const HeartDivider(),
            const SizedBox(height: 28),
            _PartySection(
              title: 'GROOMSMEN',
              members: party.groomsmen,
            ),
            const SizedBox(height: 28),
            const HeartDivider(),
            const SizedBox(height: 28),
            _PartySection(
              title: 'PARENTS',
              members: party.parents,
            ),
            const SizedBox(height: 28),
            const HeartDivider(),
            const SizedBox(height: 28),
            _PartySection(
              title: 'PAWS OF HONOR',
              members: party.parents,
            ),
          ],
        ),
      ),
    );
  }
}

class _PartyHeader extends StatelessWidget {
  const _PartyHeader();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          'Our Wedding Entourage',
          textAlign: TextAlign.center,
          style: context.scriptHero(),
        ),
        const SizedBox(height: 10),
        Text(
          'THE PEOPLE BY OUR SIDE',
          textAlign: TextAlign.center,
          style: context.capsLabel(),
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
  final List<WeddingPartyMember> members;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.sectionCaps(),
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

  final WeddingPartyMember member;

  @override
  Widget build(BuildContext context) {
    const portraitSize = 104.0;
    final assetPath = WeddingPartyAssets.portrait(
      member.firstName,
      member.lastName,
    );

    final placeholder = _PortraitPlaceholder(
      firstName: member.firstName,
      lastName: member.lastName,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => showPartyMemberPolaroid(
              context,
              member: member,
              assetPath: assetPath,
              imagePlaceholder: placeholder,
            ),
            child: Container(
              width: portraitSize,
              height: portraitSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.goldBrass.withValues(alpha: 0.35),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.textCharcoal.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  assetPath,
                  width: portraitSize,
                  height: portraitSize,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => placeholder,
                ),
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
          style: context.portraitName(),
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
    final initials = '${firstName.isNotEmpty ? firstName[0] : ''}'
        '${lastName.isNotEmpty ? lastName[0] : ''}';

    return ColoredBox(
      color: context.dustyRose.withValues(alpha: 0.28),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: context.portraitInitials(),
        ),
      ),
    );
  }
}
