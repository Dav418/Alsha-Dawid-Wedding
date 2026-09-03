abstract final class StrapiConfig {
  static const baseUrl = 'https://cms.davbox.net';

  static const wedding = '/api/wedding';
  static const weddingPartyMembers = '/api/wedding-party-members';
  static const foodItems = '/api/food-items';
  static const storyEntries = '/api/story-entries';
  static const vendors = '/api/vendors';

  static String mediaUrl(String url) {
    final value = url.trim();

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return '$baseUrl${value.startsWith('/') ? value : '/$value'}';
  }
}
