import 'package:flutter_riverpod/flutter_riverpod.dart';

// Estado que representa la pestaña activa
class TabState extends StateNotifier<int> {
  TabState() : super(0); // La pestaña inicial es la primera (índice 0)

  void setTabIndex(int index) {
    state = index; // Actualiza el índice de la pestaña activa
    print(index);
  }
}

// Proveedor del estado del TabBar
final tabProvider = StateNotifierProvider<TabState, int>((ref) => TabState());
