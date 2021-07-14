

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQr extends StatefulWidget {

  @override
  _CreateQrState createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {

   String data = "";

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crear QR '),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _crearCodigo(data),
              _crearInput(qrText),
              _crearBoton(),
            ],
          ),
        ),
      ),
    );
  }

   Widget _crearInput(TextEditingController qrText) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: qrText,
        autofocus: false, //Se abre el teclado cuando se incia la pagina
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: 'Inserte el Url',
          labelText: 'Url',
          suffixIcon: Icon( Icons.insert_link_rounded),
        ),

      ),
    );

  }

  Widget _crearBoton()  {
    FocusScope.of(context).requestFocus(new FocusNode());
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
            child: Text('GENERAR QR'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
              shape: StadiumBorder()
            ),
            onPressed: () {

              if(qrText.text.isNotEmpty) {
                setState(() {
                  data = qrText.text;
                });
              } 

            },
            
          ),
    );
  }


  _crearCodigo(String data) {

    if(data.isEmpty) {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.only(bottom: 25),
        child: QrImage(
          data: data,
          version: QrVersions.auto,
          size: 200.0,
        ),
      );
    }
    
  }

  final qrText = TextEditingController();
}

