abstract final class HygraphConfig {
  static const endpoint =
      'https://eu-west-2.cdn.hygraph.com/content/cmt74cn3j03re07w37b6liyri/master';

  static const weddingContentQuery = r'''
query WeddingContent {
  weddings(first: 1) {
    couple {
      partner1Name
      partner2Name
    }

    event {
      dateDisplay
      locationDisplay
      countdownUtc
    }

    contact {
      email
    }

    links {
      liveUpdatesUrl
      venueMapQuery
      rsvpUrl
    }

    ceremony {
      time
      addressLines
    }

    reception {
      time
      addressLines
    }

    weddingParty {
      bridesmaids {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      brideSquad {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      groomsmen {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      flowerGirls {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      pageBoys {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      parents {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      maidOfHonor {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      bestMan {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }

      dogs {
        firstName
        lastName
        honorific
        bio
        photo {
          url
        }
      }
    }

    ourStoryPhotos {
      blurb
      description
      image {
        url
      }
    }

    gallery {
      url
    }

    permissions

    food {
      culture
      items(first: 100) {
        name
        description
        contains
        allergens
        spiceLevel
        wikipediaUrl
        course
        image {
          url
        }
      }
    }
  }
}
''';
}
