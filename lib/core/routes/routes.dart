import 'package:flutter_features/features/address_management/presentation/pages/shipping_address_page.dart';
import 'package:flutter_features/features/grade/presentation/pages/my_grade_page.dart';
import 'package:flutter_features/features/point/presentation/pages/point_page.dart';
import 'package:flutter_features/features/review/presentation/pages/review_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/cart_test_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: '/home',
    name: 'home',
    builder: (context, state) => HomePage(),
  ),

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

  GoRoute(
    path: '/address',
    name: 'address',
    builder: (context, state) => ShippingAddressPage(),
  ),

  GoRoute(
    path: '/grade',
    name: 'grade',
    builder: (context, state) => MyGradePage(),
  ),

  GoRoute(
    path: '/point',
    name: 'point',
    builder: (context, state) => PointPage(),
  ),

  GoRoute(
    path: '/review',
    name: 'review',
    builder: (context, state) => ReviewPage(),
  ),
];