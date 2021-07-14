import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/pages/direcciones_page.dart';
import 'package:qr_app/pages/mapas_page.dart';
import 'package:qr_app/providers/db_provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/widgets/custom_navigatorbar.dart';
import 'package:qr_app/widgets/scan_button.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon( Icons.add_link_rounded ),
            onPressed: (){
              
              Navigator.pushNamed(context, 'crear');

            },
          ),
        ],
      ),
      body: _HomePageBody(),
      
     bottomNavigationBar: CustomNavigationBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }

}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    
    //Cambiar para mostrar la página respectiva
    final currentIndex = uiProvider.getSelectedMenuOpt;

    // Usar el ScanlistProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch( currentIndex ) {

      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();

      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();

    }

  }
}