'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "styles.css": "baa57cc3315e1f8d2bf29e810043c9b5",
"favicon.png": "a3bca2eb2b96e061da1ef34b74c3c382",
"manifest.json": "3c4ad9ce548ae5a120f5297646aa0dce",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-maskable-192.png": "1704b077dfe9c9202d01ae5811700f51",
"icons/Icon-maskable-512.png": "52671be5ac7319064f07c5b6dc176381",
"icons/Icon-512.png": "52671be5ac7319064f07c5b6dc176381",
"icons/Icon-192.png": "1704b077dfe9c9202d01ae5811700f51",
"version.json": "b3d76f3115df3e1b9f2e322fd7c4bb4f",
"pay_success.html": "b4bf01b5d6db064bb4a458a966a505d6",
"main.dart.js": "20ec7f9c5c7b1ef1649e1cf39d905abb",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"index.html": "da684673e5edb00cd944b3af132ba6af",
"/": "da684673e5edb00cd944b3af132ba6af",
"assets/env/development.env": "c0a05b70765015adfee629759bbaa665",
"assets/env/production.env": "cf49545de7099185f897431e1bfd2902",
"assets/AssetManifest.json": "35ffbabe6bcec411a9e78ec2803eb2c0",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/shaders/ink_sparkle.frag": "ab4751ef630837e294889ca64470bb70",
"assets/NOTICES": "b23697ec4e80bd57e7080373994f7034",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/images/common/copy.png": "b498406e836b1cd4df1de641f31d4d28",
"assets/assets/images/common/outline.png": "749e83a18f5fbbc3c33d4c9ff526a024",
"assets/assets/images/common/collapse.png": "376e54f5108a7970e4321f6951078083",
"assets/assets/images/common/selected.png": "96442cb43c1e3b8438a87623be110533",
"assets/assets/images/common/arrow.png": "0325228627b85751c5e1d232d7021473",
"assets/assets/images/common/phone.png": "0a7d49b35b0d81ebb65b9b3fe660be32",
"assets/assets/images/common/unselected.png": "5a7e8bdb2da1036d256c794bb89639ae",
"assets/assets/images/common/add.png": "8c7d09fb7bdfdf1f3e4af5c0de434a45",
"assets/assets/images/common/expand.png": "3e745105c84bd8a289b34961390c7447",
"assets/assets/images/common/clear.png": "60d4cda87e5b5507630ab156e76918f2",
"assets/assets/images/common/edit.png": "754cb9828b1992afee8f946ba1387add",
"assets/assets/images/common/location.png": "0a542a87f7c78ec8095719458fe2df4d",
"assets/assets/images/orders/arrow.png": "d82dd65dc00b72637983188f260e571d",
"assets/assets/images/activity/time.png": "8dec0b6f8c4d3b904e217b3aa23dd112",
"assets/assets/images/activity/wechat.png": "0e35f4ac1a897e70c51a5c7f7d5560e7",
"assets/assets/images/activity/phone.png": "fd1cd09853501f4072ebbad717836f6f",
"assets/assets/images/activity/done.png": "aa85a38deb2570abef9a64c3ad95e80f",
"assets/assets/images/activity/location.png": "e071ca2ab330ee31924287cf1e840be1",
"assets/assets/images/project_details/paster_blockie.png": "711f80c3f868bf1c50726fb612cf4437",
"assets/assets/images/project_details/hint.png": "83a92b9f00f22b4a606e49be8ddc26f9",
"assets/assets/images/project_details/paster_2d.png": "cd8c767a65e91d692127e89923391b39",
"assets/assets/images/project_details/paster_3d.png": "01ff0057255fe7d65f8fe3a4202e9499",
"assets/assets/images/app_bar/back.png": "747822d1252f8e91057df919ce653bb5",
"assets/assets/images/app_bar/order.png": "82e6c991d64fc4ca6c9ecbfd284dc43f",
"assets/assets/images/app_bar/menu.png": "a798e7f6d31a115f6fb0213f4de12c90",
"assets/assets/images/app_bar/share.png": "2112807b9e67587817cf973844cd95b2",
"assets/assets/images/app_bar/user.png": "817a08b79e57474a479bcc5e31274a3a",
"assets/assets/images/app_bar/logo.png": "d91779f3ba8ddf1a736927ac31c5d404",
"assets/assets/images/app_bar/qr_code.png": "f28822f52670211c050d1a25e96c5227",
"assets/assets/images/app_bar/close.png": "60d4cda87e5b5507630ab156e76918f2",
"assets/assets/images/app_bar/info.png": "86a7c3077e7243247c53a381bc602faa",
"assets/assets/images/app_bar/settings.png": "d58095230e34d71503ba010a385cd225",
"assets/assets/images/app_bar/home.png": "2ec07a7164f10b84bd843e9f81c7df86",
"assets/assets/images/activities/location.png": "ae0603b785aa176df25673174538b22e",
"assets/assets/images/projects_management/ticket_checking.png": "ae0a966950af6e3091668bfbba2a12f9",
"assets/assets/images/projects_management/selected.png": "96442cb43c1e3b8438a87623be110533",
"assets/assets/images/projects_management/hold_verification.png": "a5d02eeda9a0d2a97f79951a3bcfb895",
"assets/assets/images/projects_management/airdrop_nft.png": "c08e045ae03f10d35e700781385c222f",
"assets/assets/images/projects_management/unselected.png": "4ef77bb2b11eeb2d4e1a841dfbd9b0f5",
"assets/assets/images/projects_management/add_whitelist.png": "4c1851055f01419297b38f11d2cfa075",
"assets/assets/images/profile/empty_tag.png": "4282c49c6c0bae7bae272f5cddec9eb4",
"assets/assets/images/profile/empty_video_nft.png": "97fbfea90f06b822221845a0d424a5d4",
"assets/assets/images/profile/empty_sport_nft.png": "8838e96eaf063d4cbb713edac32dff73",
"assets/assets/images/profile/tag_add.png": "e457130364663311630cdbe069493f2a",
"assets/assets/images/profile/edit_profile_background.png": "d18183326827546ad27d06eea3cf2d8e",
"assets/assets/images/profile/label_background.png": "2fa19a037913203864eea584d3003d1c",
"assets/assets/images/update_region/location.png": "52bc8e9d5db43a98c66e82d624db2c32",
"assets/assets/images/order_creation/decrease.png": "8567469d1029d918561adb45b5d6f1e6",
"assets/assets/images/order_creation/increase_disabled.png": "e00ccb8eb1cff39a0cf6c48f5eb6d18c",
"assets/assets/images/order_creation/increase.png": "3875d1cb75a4d037466f9cd5b4b0dd65",
"assets/assets/images/order_creation/decrease_disabled.png": "a53d090f24c8a3bed924b8ac5476a339",
"assets/assets/json_files/countries.json": "d944567afa750d32768e414cdfd171e1"
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
