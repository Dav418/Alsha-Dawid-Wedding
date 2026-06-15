import 'map_poi.dart';

/// Nearby accommodation and points of interest around the wedding venues.
///
/// Coordinates are approximate; [MapPoi.googleMapsUrl] is the source of truth
/// for opening directions in Google Maps.
const mapPois = [
  MapPoi(
    id: 'premier-inn-rickmansworth',
    title: 'Premier Inn Rickmansworth',
    address: 'Batchworth Lock House, Rickmansworth, WD3 1JB',
    description:
        'A comfortable chain hotel beside the canal — handy for guests '
        'staying near Rickmansworth and The Grove.',
    latitude: 51.6358,
    longitude: -0.466694,
    googleMapsUrl: 'https://maps.app.goo.gl/xnwXh78xwUYFkxjY9?g_st=aw',
    category: MapPoiCategory.hotel,
  ),
  MapPoi(
    id: 'two-brewers',
    title: 'Two Brewers',
    address: 'The Common, Chipperfield, Kings Langley, WD4 9BS',
    description:
        'A village pub with rooms on Chipperfield Common — a relaxed spot '
        'for dinner or an overnight stay.',
    latitude: 51.703371,
    longitude: -0.492527,
    googleMapsUrl:
        'https://www.google.com/maps/place/Two+Brewers,+The+Common,+Chipperfield,+Kings+Langley+WD4+9BS/data=!4m2!3m1!1s0x4876423df35b12a9:0xb81352fd2855e856!18m1!1e1',
    category: MapPoiCategory.pub,
  ),
  MapPoi(
    id: 'bedford-arms-hotel',
    title: 'Bedford Arms Hotel',
    address: 'Chenies House, Chenies, Rickmansworth, WD3 6EQ',
    description:
        'A historic pub and hotel in pretty Chenies village — characterful '
        'rooms a short drive from the ceremony and reception.',
    latitude: 51.673354,
    longitude: -0.527191,
    googleMapsUrl:
        'https://www.google.com/maps/place/Bedford+Arms+(Hotel),+Chenies+House,+Chenies,+Rickmansworth+WD3+6EQ/data=!4m2!3m1!1s0x4876682ddb61e815:0x606a6050ff86bb8b!18m1!1e1',
    category: MapPoiCategory.pub,
  ),
  MapPoi(
    id: 'premier-inn-kings-langley',
    title: 'Premier Inn Kings Langley',
    address: '37 Hempstead Road, Kings Langley, WD4 8BR',
    description:
        'Modern budget hotel on the A41 — straightforward rooms with easy '
        'road links to Rickmansworth and Watford.',
    latitude: 51.716031,
    longitude: -0.450922,
    googleMapsUrl:
        'https://www.google.com/maps/place/Premier+Inn+Kings+Langley+hotel,+37+Hempstead+Rd,+Kings+Langley+WD4+8BR/data=!4m2!3m1!1s0x487641a2aa1f895b:0xbbb5606a964cb13c!18m1!1e1',
    category: MapPoiCategory.hotel,
  ),
];
