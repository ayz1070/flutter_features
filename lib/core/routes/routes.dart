import 'package:go_router/go_router.dart';

import 'cart_routes.dart';
import 'home_routes.dart';

final List<GoRoute> appRoutes = [
  ...homeRoutes,
  ...cartRoutes,
];