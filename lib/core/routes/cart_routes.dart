import 'package:go_router/go_router.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/cart_test_page.dart';

final cartRoutes = [
  GoRoute(
    path: '/cart',
    name: 'cart',
    builder: (context, state) => CartPage(),
  ),

  GoRoute(
    path: '/cartTest',
    name: 'cartTest',
    builder: (context, state) => CartTestPage(),
  ),

];