import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.getSelectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.setSelectedMenuOpt = i,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.compass_calibration ),
          label: 'Direcciones'
        ),
      ],
    );
  }
}
