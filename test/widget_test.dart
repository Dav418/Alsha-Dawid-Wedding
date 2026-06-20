import 'package:alisha_dawid_wedding_website/app.dart';
import 'package:alisha_dawid_wedding_website/models/content/wedding_content.dart';
import 'package:alisha_dawid_wedding_website/content/repositories/wedding_content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _testWeddingContent = WeddingContent(
  couple: WeddingCouple(
    partner1Name: 'Alisha Fernandes',
    partner2Name: 'Dawid Gorski',
  ),
  event: WeddingEvent(
    dateDisplay: '17th OCTOBER 2026',
    locationDisplay: 'RICKMANSWORTH, UK',
    countdownUtc: DateTime.utc(2026, 10, 17, 9),
  ),
  contact: WeddingContact(email: 'test@example.com'),
  links: WeddingLinks(
    liveUpdatesUrl: 'https://example.com/live',
    venueMapQuery: 'Rickmansworth, UK',
    rsvpUrl: 'https://example.com/rsvp',
  ),
  ceremony: WeddingVenueSlot(
    time: '1:00 PM',
    addressLines: ['Rickmansworth WD3 1RR'],
  ),
  reception: WeddingVenueSlot(
    time: '4:00 PM',
    addressLines: ['The Grove'],
  ),
  weddingParty: WeddingPartyRoster(
    bridesmaids: [],
    groomsmen: [],
    parents: [],
  ),
  ourStoryPhotoUrls: [],
);

class _TestWeddingContentRepository extends WeddingContentRepository {
  @override
  Future<WeddingContent> build() async => _testWeddingContent;
}

void main() {
  testWidgets('renders root shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          weddingContentRepositoryProvider.overrideWith(
            _TestWeddingContentRepository.new,
          ),
        ],
        child: const WeddingWebsiteApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.textContaining('Alisha'), findsWidgets);
  });
}
