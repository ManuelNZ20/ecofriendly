import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../views/views.dart';

class HomeClientScreen extends StatelessWidget {
  static const String name = 'home_client_screen';
  const HomeClientScreen({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  final viewRoutes = const <Widget>[
    HomeView(),
    OrdersView(),
    CartView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: pageIndex,
      ),
    );
  }
}
