'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "img/share_image.png": "c054f34b6a6e700c8a11f4e39da25f0b",
"img/splash.jpg": "720adcfef022c2016c1d461a947dec53",
"main.dart.js": "c70c9da5336470c8860b1f0a3548c309",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"manifest.json": "ba71d260f71ee7cc3387632a70b65779",
"CNAME": "5c4826e7c75e04df7cddcaefd25a83e1",
"icons/Icon-512.png": "12bfa040da28ea5651cac9ce4278cd36",
"icons/favicon.png": "43c059cc35b613e47679b17080bd56b3",
"icons/Icon-192.png": "31bbe21e7ef604d7d0d2cd434fb5eace",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"assets/AssetManifest.json": "aa3e2159b2dda610eddd09263bb1b559",
"assets/shaders/ink_sparkle.frag": "ab4751ef630837e294889ca64470bb70",
"assets/packages/ranch_ui/assets/images/board.png": "36613029addb3ce876bc43cd244b975c",
"assets/packages/ranch_ui/assets/images/heads/baby_head.png": "d1cea8237a6952729dc355eadb5a27ca",
"assets/packages/ranch_ui/assets/images/heads/adult_head.png": "c564dcba250be7a90ad7d6c9b0d32a5b",
"assets/packages/ranch_ui/assets/images/heads/child_head.png": "837d21c2902a6657bf95336bb3397ac7",
"assets/packages/ranch_ui/assets/images/heads/teen_head.png": "9c6894b9e59946c1c09d66a23459c342",
"assets/packages/ranch_ui/assets/fonts/anybody/Anybody-Black.ttf": "e9e7277f3f8c2bd27605f6d4de9c9b55",
"assets/packages/ranch_ui/assets/fonts/anybody/Anybody-SemiBold.ttf": "7ad0688cfaaf57ee1139d9cd8894b943",
"assets/packages/ranch_ui/assets/fonts/anybody/Anybody-Regular.ttf": "7acd80c659b81aa7b42e31eb707aefb0",
"assets/packages/ranch_ui/assets/fonts/anybody/Anybody-Bold.ttf": "96757c1311cf092f888603cc05f13b87",
"assets/packages/ranch_ui/assets/fonts/anybody/OFL.txt": "428163f2b9cb726f3558370aeffe80b0",
"assets/packages/ranch_ui/assets/fonts/anybody/Anybody-Medium.ttf": "9a8fd7d68157c08ba43bd20d8fc725bd",
"assets/packages/ranch_ui/assets/fonts/mouse_memoirs/OFL.txt": "2ab28c244862d95a515e1bf838404c7a",
"assets/packages/ranch_ui/assets/fonts/mouse_memoirs/MouseMemoirs-Regular.ttf": "33abc4861357df983df6328dbc01ece3",
"assets/packages/ranch_components/assets/food/donut.png": "6b88e7594fbac57bc3e10d3530270fd8",
"assets/packages/ranch_components/assets/food/lollipop.png": "7379e25aa2416350c1a48cdeb14f0756",
"assets/packages/ranch_components/assets/food/cake.png": "624a75cfe5002027ce8492d6e9203417",
"assets/packages/ranch_components/assets/food/icecream.png": "9a217bb74f20257f2bb4d5ac467d35ae",
"assets/packages/ranch_components/assets/food/pancakes.png": "8ee988f78c3bc8db47afe2f5d7849196",
"assets/packages/ranch_components/assets/background/cow.png": "d274bfb24d2d1e42f7145d3adca3f140",
"assets/packages/ranch_components/assets/background/sheep_small.png": "ef8a5378f9d466268701ae03e252708c",
"assets/packages/ranch_components/assets/background/short_tree.png": "165e47cdcc68e6d0a7113a58b9b0a518",
"assets/packages/ranch_components/assets/background/barn.png": "d8f12e043be0df7432eb29a5b5848ab3",
"assets/packages/ranch_components/assets/background/sheep.png": "fd902da7a328dbc8d141b1b90d2dd425",
"assets/packages/ranch_components/assets/background/flower_duo.png": "0c4d1e2559ba6aa61886fd106fa04dda",
"assets/packages/ranch_components/assets/background/lined_tree.png": "318dce4a6e866c8e27bad0474be92e77",
"assets/packages/ranch_components/assets/background/grass.png": "fb2d42ff0a286fbffc06d2e3974d58a0",
"assets/packages/ranch_components/assets/background/flower_group.png": "f61d6407386de8d8f14dfbee3d4414ff",
"assets/packages/ranch_components/assets/background/flower_solo.png": "0274353f3d091cb940bb0a3b9ac1d28e",
"assets/packages/ranch_components/assets/background/lined_tree_short.png": "fc422c60e7d6344a5247980d58daa790",
"assets/packages/ranch_components/assets/background/tall_tree.png": "ce4236841ba949264aaf631850a72a5b",
"assets/packages/ranch_components/assets/animations/adult_petted.png": "59eda8264cda41a645e4463f4fe02645",
"assets/packages/ranch_components/assets/animations/teen_idle.png": "7d8a27811f4efec95978939b2316a868",
"assets/packages/ranch_components/assets/animations/baby_idle.png": "d2da78b71f3af2b0b81a501608e27e7d",
"assets/packages/ranch_components/assets/animations/baby_eat.png": "41bae058eeba9d8bbd9fb2c36dead173",
"assets/packages/ranch_components/assets/animations/adult_walk_cycle.png": "7cfcb5d9546e15c32ed8ab482382e700",
"assets/packages/ranch_components/assets/animations/child_walk_cycle.png": "75bfc9718d78da3e3929321af979fdd9",
"assets/packages/ranch_components/assets/animations/child_idle.png": "728cdb9cdf592c0c7d4d83c08483ded3",
"assets/packages/ranch_components/assets/animations/adult_idle.png": "ca4d7b7a7ee0cbb1e985e7c7c9e169cc",
"assets/packages/ranch_components/assets/animations/baby_walk_cycle.png": "ea4774b9ca01dec542ba0b5f55faf626",
"assets/packages/ranch_components/assets/animations/child_petted.png": "1939da543d2d93d8cf1b0b19d2b79b8e",
"assets/packages/ranch_components/assets/animations/adult_eat.png": "032c5dbcd1a7b5bff871828a3c16c846",
"assets/packages/ranch_components/assets/animations/baby_petted.png": "a0146de888eb28905c7728eb35a9d882",
"assets/packages/ranch_components/assets/animations/child_eat.png": "62d7c012093b0db652510b3a9ec20e87",
"assets/packages/ranch_components/assets/animations/teen_walk_cycle.png": "3899db630df18982d8ff2a4987f77fb5",
"assets/packages/ranch_components/assets/animations/teen_eat.png": "4de99095e5e016fe8af583dbadc2e578",
"assets/packages/ranch_components/assets/animations/teen_petted.png": "3d9cc3b97f9edf4af9873ec6eb4c6175",
"assets/packages/ranch_sounds/assets/music/sunset_memory_license.txt": "3b0c20d650cbce304c56f329aa1e9d22",
"assets/packages/ranch_sounds/assets/music/game_background.wav": "262f54195142ed7e3bff71c5178f3b97",
"assets/packages/ranch_sounds/assets/music/start_background.wav": "43da985a01b468c492403ecd028c5271",
"assets/packages/ranch_sounds/assets/music/sunset_memory.mp3": "64eeefec740f5e66a66b66f8859d8e49",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/title_unicorn.png": "8170dd59c76e0a32f5b90550cbdd09da",
"assets/assets/images/loading.png": "a0e5a1ab89d184b59f303c09a4b7cd3a",
"assets/assets/images/title_barn.png": "60f23a797a761ccef904d17a934f595e",
"assets/assets/images/title_background.png": "9cb5bd546aca7ce9f6e72a7423617fce",
"assets/assets/images/title_rainbow.png": "67df424a9c5fef4a80d2ae085982ddfa",
"assets/assets/images/title_board.png": "2314717529527795cb6dc4452ef8df43",
"assets/NOTICES": "fbbce894d7d4ac8f272bf77bf6cc4a71",
"index.html": "5135a899f1bff4553be58b7a3d2722f6",
"/": "5135a899f1bff4553be58b7a3d2722f6",
"favicon.png": "43c059cc35b613e47679b17080bd56b3",
"version.json": "dced3d0c1d0c687bc4aedd8142870a34"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
