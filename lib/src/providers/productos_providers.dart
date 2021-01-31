
import 'dart:convert';
//import 'dart:io';

import 'package:http/http.dart' as http;
//Este packete sirve para ver que tipo de archivo es lo que subimos
//Ya sea png jpg gig etc ↓↓ tenemos que importar en el pumbyaslc
//import 'package:mime_type/mime_type.dart';
import 'package:validationform/src/models/product_model.dart';

class ProductosProvider{

  final String _url = 'https://flutter-varios-e3959-default-rtdb.firebaseio.com';


  Future<bool> crearProducto( ProductModel producto ) async {

    final url = '$_url/productos.json';
    
    final resp = await http.post(url, body: productModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print (decodedData);

    return true;
  }

   Future<bool> editarProducto( ProductModel producto ) async {

    final url = '$_url/productos/${producto.id}.json';
    
    final resp = await http.put(url, body: productModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print (decodedData);

    return true;

  
   
  }

  Future<List<ProductModel>> cargarProductos() async{

    final url = '$_url/productos.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel>productos = new List();
      if (decodedData == null) return [];

      decodedData.forEach((id, prod) {
        final prodTemp = ProductModel.fromJson(prod);
        prodTemp.id = id;
        productos.add(prodTemp);
       });

    //print(productos);
    return productos;
  }

  Future<int> borrarProducto(String id ) async {

    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print (resp.body);
    return 1;
  }
  //subirImagen
   /* Future<String> subirImagen ( File imagen) async {

    final url = Uri.parse('url del api a subir');
    final mimeType = mime(imagen.path).split('/'); //iamge/jpeg <-ejemplo

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );
    imageUploadRequest.files.add();

    final streamResponse = await imageUploadRequest.send();
    } */
}