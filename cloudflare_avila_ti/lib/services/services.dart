import 'package:cloudflare_avila_ti/services/request.dart';
import 'package:cloudflare_avila_ti/services/secure.dart';

import '../models/zone_model.dart';
import '../pages/drawer/drawer.dart';
import '../utils.dart';

// SecureStorage
StoreSecureData sotoreSecureData = StoreSecureData();

// Internet Requests
HttpRequest httpRequest = HttpRequest();

// CloudFlare Urls
Endpoints cloudflareUrls = Endpoints();

// Pages
PageRoutes pageRoutes = PageRoutes();

// Colors
CloudflareColors cloudflareColors = CloudflareColors();


// Active Zone DNS
ZonesModel activeZoneModel = ZonesModel();