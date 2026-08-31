'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "9faff98ae0ecb1cd5cc4041559750cf5",
"version.json": "c2159cf6dc2d4e150a27f9056d1543ff",
"index.html": "8af5cf813dfa46fc46ffd6051ad1866a",
"/": "8af5cf813dfa46fc46ffd6051ad1866a",
"main.dart.js": "4c9ba7e9c4e9815ad8413e265688bf55",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "28bef0286418a6bf28addd92d368ee0f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "ee8fabd92cd30598306bc5b04869d726",
"assets/AssetManifest.json": "8d8a2e8c41ff1666b7e2361d47c8be63",
"assets/NOTICES": "5477acbbaec013f6242d90b559620998",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "963acd5e27cc8ac606e339084b2a6122",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/assets/home/rsvp_button.png": "444c3a3ac27f60b820106f09d42a72e7",
"assets/lib/assets/home/home_assets.dart": "87892d95fa4c74cf754dcd5644668062",
"assets/lib/assets/home/right_floral_cluster.png": "e0e081c61e79192f046ba1f3d1a6ec5e",
"assets/lib/assets/home/left_floral_cluster.png": "2409a590354a1894393f1a3dc3a24d58",
"assets/lib/assets/home/monogram_ad_wreath.png": "f1e1ea64667fbeeaed737b979115dea4",
"assets/lib/assets/home/bottom_floral_ribbon.png": "bbc67b9469c0bde3140631706ed7a547",
"assets/lib/assets/home/seal.png": "85e321cb9494e14b2af7e63b53ded7be",
"assets/lib/assets/paws_at_work.png": "3dc1972d2b40fb14e9a177c7a6f32394",
"assets/lib/assets/bouncer_dog.png": "1cdd3fc372801c102560cd16c17c4635",
"assets/lib/assets/timeline_pins/send_off.png": "45bb94e83ff10ad492e4bc3eb9599cdf",
"assets/lib/assets/timeline_pins/timeline_assets.dart": "1aa7e7a987a979ab4f0b70dc30912f0c",
"assets/lib/assets/timeline_pins/buffet_opens.png": "1cdf87d9b8bea6fbd231e38a9b30c140",
"assets/lib/assets/timeline_pins/blessings_brides_sendoff.png": "fea86a72747e7ba297e7b5ddb827ccc0",
"assets/lib/assets/timeline_pins/receiving_line_group_photo.png": "2908a10050ef8944086d271ba4f169b8",
"assets/lib/assets/timeline_pins/first_dance.png": "cd288f5cb5c28288014df1f954ce8270",
"assets/lib/assets/timeline_pins/reception_guest_arrival.png": "49e2cf62847fbc932a4e64fbd5694fcf",
"assets/lib/assets/timeline_pins/nuptial_mass.png": "8f6f48e22e33d9350ab7f9898c6d8715",
"assets/lib/assets/timeline_pins/toast_speeches.png": "ed5d48687982ea6a3b0d4d6f2c4ed806",
"assets/lib/assets/timeline_pins/grand_entrance.png": "bea9588cf019a0da00be51977dde905c",
"assets/lib/assets/timeline_pins/refreshments_private_photos.png": "506048c6e345295872c052631cc5f41c",
"assets/AssetManifest.bin": "f3d64e6b5a1ebccd6c05ff777516d6fd",
"assets/fonts/MaterialIcons-Regular.otf": "8cb7908f17d81932a3f29d4f2cec1239",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
