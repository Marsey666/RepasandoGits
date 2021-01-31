



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validationform/src/models/product_model.dart';
import 'package:validationform/src/providers/productos_providers.dart';
import 'package:validationform/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey           = GlobalKey<FormState>();
  final scaffoldKey       = GlobalKey<ScaffoldState>();
  final productosProvider = new ProductosProvider();
  
  final _picker = ImagePicker();
  ProductModel producto = new ProductModel();
  bool _guardado = false;
  
  File foto;
  @override
  Widget build(BuildContext context) {
  
    

    final ProductModel prodData = ModalRoute.of(context).settings.arguments;

    if ( prodData != null){
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selccionarFoto,
          ),
          IconButton (
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key:  formKey,
            child: Column(

              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _creaarDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _crearNombre() {

   return TextFormField(
     initialValue: producto.titulo,
     textCapitalization: TextCapitalization.sentences,
     decoration: InputDecoration(
       labelText: 'Producto'
     ),
     onSaved: (value)=> producto.titulo = value,
     validator: (value){
       if ( value.length < 3 ){
         return 'Ingrese el nombre del producto';
       } else {
         return null;
       }
     },
   );
 }

 Widget _crearPrecio() {

   return TextFormField(
     initialValue: producto.valor.toString(),
     keyboardType: TextInputType.numberWithOptions(decimal: true),
     decoration: InputDecoration(
       labelText: 'Precio'
     ),
     onSaved: (value)=> producto.valor = double.parse(value),
     validator: (value){
       
       if ( utils.isNumeric(value)){
         return null;

       }else {
         return 'Sólo número';
       }
       
     },
   );
 }

 Widget _creaarDisponible(){

   return SwitchListTile(
     value: producto.disponible,
     title: Text('Disponible'),
     activeColor: Colors.deepPurple,
     onChanged: (value)=> setState((){
       producto.disponible = value;
     }),
   );


 }

 Widget  _crearBoton() {
   return RaisedButton.icon(

       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20.0)
       ),
       color: Colors.deepPurple,
       textColor: Colors.white,
       label: Text('Guardar'),
       icon:Icon(Icons.save),
       onPressed: (_guardado) ? null : _submit,
   );
 }

 void _submit(){

   if (!formKey.currentState.validate()) return;
   
   
   formKey.currentState.save();

   
   setState(() {_guardado = true;});

   if ( producto.id == null ){
     productosProvider.crearProducto(producto);
   }else{
     productosProvider.editarProducto(producto);
   }
   Navigator.pop(context);
   // se llama al evento ↓↓_openSnackBarWithoutAction (context: context);
 }
   //Crear un snackBar para el registro de guardado ver más adelante
  /* void _openSnackBarWithoutAction ({@required BuildContext context}) {
    final snackBar = SnackBar(
      content: Text("Esto es una SnackBar sin evento asociado"),
      duration: Duration(seconds: 3),
    );

    
  } */

  Widget _mostrarFoto(){

    if ( producto.fotoUrl != null){
      //  todo tengo que hacer esto
      return Container();
    }else{
      if(foto != null){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }

  }
  _selccionarFoto() async{
      _procesarImagen( ImageSource.gallery);
  }

  _tomarFoto() async{
      _procesarImagen( ImageSource.camera);
  }
  _procesarImagen(ImageSource origen ) async {
   
    final  pickedFile = await _picker.getImage(source: origen);
  
      foto = File(pickedFile.path);
      if (foto != null){
        producto.fotoUrl = null;
      }
      setState(() { });


  }
}