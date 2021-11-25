import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:salonhouse/src/constantes/constantes.dart';
import 'package:salonhouse/src/models/productos_carrito_model.dart';

void guardardatos_wella_rojo_1_color_brillance() async {
  String pelu = Constantes().red_brillance;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 100,
      fotoString:
          "https://falabella.scene7.com/is/image/Falabella/12566424_1?wid=800&hei=800&qlt=70",
      nombre: 'WP BRILLIANCE MASK 150ML',
      precio: "18790",
      precio2Int: 18790,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 101,
      fotoString:
          "https://static.carethy.net/media/4/photos/products/455215/brilliance-acondicionador-cabello-fino-200ml_1_g.jpeg",
      nombre: 'WP BRILLIANCE SHAMPOO 1000ML',
      precio: "36690",
      precio2Int: 36690,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 102,
      fotoString:
          "http://200.29.3.91:8069/web/image/product.product/29970/image",
      nombre: 'WP BRILLIANCE CONDITIONER 1000ML',
      precio: "39990",
      precio2Int: 39990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 103,
      fotoString:
          "https://falabella.scene7.com/is/image/Falabella/12566424_1?wid=800&hei=800&qlt=70",
      nombre: 'WP BRILLIANCE MASK 500ML',
      precio: "38990",
      precio2Int: 38990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 104,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156894-1000-1000/57683.jpg?v=637442492450430000",
      nombre: 'WP BRILLIANCE BOOSTER 100ML -Intensificador Del Brillo',
      precio: "21290",
      precio2Int: 21290,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 105,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156894-1000-1000/57683.jpg?v=637442492450430000",
      nombre: 'WP BRILLIANCE LI BALM 150ML -BÁLSAMO EMBELLECEDOR EN SPRAY',
      precio: "21290",
      precio2Int: 21290,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().red_brillance);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

void guardardatos_wella_2_naranja_nutri_enrich() async {
  String pelu = Constantes().naranja2_nutri_enrich;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 200,
      fotoString:
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSjWQKzluPH0Ddbz7hlQIT_pjc-WRSbBPQDSscdevLVa9FGU67vBBRJBW0WZFnRpFe85PReOk_xlg&usqp=CAc",
      nombre: 'WP ENRICH SHAMPOO 250ML',
      precio: " 15,690",
      precio2Int: 15690,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 201,
      fotoString:
          "https://www.glamstore.com/web/image/product.template/18693/image?unique=b8e7cdc",
      nombre: 'WP ENRICH CONDITIONER 200ML',
      precio: "17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  //--
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 202,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156895-1000-1000/57684.jpg?v=637442492453100000",
      nombre: 'WP ENRICH MASK 150ML',
      precio: "18890",
      precio2Int: 18890, //21190
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 203,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156893-1000-1000/57682.jpg?v=637442492447300000",
      nombre: 'WP ENRICH SHAMPOO 1000ML',
      precio: "35690",
      precio2Int: 35690,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 204,
      fotoString: "http://pos.tua.cl/web/image/product.product/29971/image",
      nombre: 'WP ENRICH CONDITIONER 1000ML',
      precio: "39990",
      precio2Int: 39990,
      disponible: false,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 205,
      fotoString:
          "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSycrrrD1vz61rVLGkUf9RAOU2leo8fym3MVyEJhMa-qUnOIBTOcoc08PmaDK3PPMJmty7lOep5diI&usqp=CAc",
      nombre: 'WP ENRICH MASK 500ML',
      precio: "38990",
      precio2Int: 38990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 206,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156895-1000-1000/57684.jpg?v=637442492453100000",
      nombre: 'WP ENRICH DAILY BALM 150ML',
      precio: "16990",
      precio2Int: 16990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 207,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156895-1000-1000/57684.jpg?v=637442492453100000",
      nombre: 'WP ENRICH SELF WARM MASK 150ML',
      precio: "21290",
      precio2Int: 21290,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 208,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156896-1000-1000/57685.jpg?v=637442492454670000",
      nombre: 'WP NUTRI BOOSTER 100ML',
      precio: "21290",
      precio2Int: 21290,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().naranja2_nutri_enrich);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//falta este
void guardardatos_wella_3_rosa_blondie() async {
  String pelu = Constantes().rosa22_blonde_riched;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 300,
      fotoString:
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSjWQKzluPH0Ddbz7hlQIT_pjc-WRSbBPQDSscdevLVa9FGU67vBBRJBW0WZFnRpFe85PReOk_xlg&usqp=CAc",
      nombre: 'WP ENRICH SHAMPOO 250ML',
      precio: " 15,690",
      precio2Int: 15690,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 301,
      fotoString:
          "https://www.glamstore.com/web/image/product.template/18693/image?unique=b8e7cdc",
      nombre: 'WP ENRICH CONDITIONER 200ML',
      precio: "17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  //--
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 302,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156895-1000-1000/57684.jpg?v=637442492453100000",
      nombre: 'WP ENRICH MASK 150ML',
      precio: "18890",
      precio2Int: 18890, //21190
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 303,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156893-1000-1000/57682.jpg?v=637442492447300000",
      nombre: 'WP ENRICH SHAMPOO 1000ML',
      precio: "35690",
      precio2Int: 35690,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 304,
      fotoString: "http://pos.tua.cl/web/image/product.product/29971/image",
      nombre: 'WP ENRICH CONDITIONER 1000ML',
      precio: "39990",
      precio2Int: 39990,
      disponible: false,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 305,
      fotoString:
          "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSycrrrD1vz61rVLGkUf9RAOU2leo8fym3MVyEJhMa-qUnOIBTOcoc08PmaDK3PPMJmty7lOep5diI&usqp=CAc",
      nombre: 'WP ENRICH MASK 500ML',
      precio: "38990",
      precio2Int: 38990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 306,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156895-1000-1000/57684.jpg?v=637442492453100000",
      nombre: 'WP ENRICH DAILY BALM 150ML',
      precio: "16990",
      precio2Int: 16990,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 307,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156895-1000-1000/57684.jpg?v=637442492453100000",
      nombre: 'WP ENRICH SELF WARM MASK 150ML',
      precio: "21290",
      precio2Int: 21290,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 308,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156896-1000-1000/57685.jpg?v=637442492454670000",
      nombre: 'WP NUTRI BOOSTER 100ML',
      precio: "21290",
      precio2Int: 21290,
      disponible: true,
      timestampString: timestamp));

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().rosa22_blonde_riched);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//
void guardardatos_wella_4_rosa_blonde_richard() async {
  String pelu = Constantes().rosa4_volumen_rosa_blonde;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 400,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156876-1000-1000/57663.jpg?v=637442492388200000",
      nombre: 'WP COOL BLOND SHAMPOO 250ML',
      precio: " 17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 401,
      fotoString: "https://davimagen.cl/wp-content/uploads/2021/03/p08.jpg",
      nombre: 'WP COOL BLOND SHAMPOO 250ML',
      precio: "15990",
      precio2Int: 15990,
      disponible: true,
      timestampString: timestamp));
  //--

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().rosa4_volumen_rosa_blonde);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//lsito
void guardardatos_wella_5_blanco_color_motion() async {
  String pelu = Constantes().blanco5_color_motion;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 500,
      fotoString:
          "https://varelayrodriguez.com/wp-content/uploads/2020/09/WP-ColorMotion-Shampoo-250ml.jpg",
      nombre: 'WP COLORMO SHAMPOO 250ml',
      precio: " 17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 501,
      fotoString:
          "https://varelayrodriguez.com/wp-content/uploads/2020/09/WP-ColorMotion-Cond-200ml.jpg",
      nombre: 'WP COLORMO CONDITIONER 200ml',
      precio: "18990",
      precio2Int: 18990,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 502,
      fotoString:
          "https://apozona.com/wp-content/uploads/2021/02/wella-color-motion-mask-150-ml.jpg",
      nombre: 'WP COLORMO MASK 150ml',
      precio: "24690",
      precio2Int: 24690,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 503,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/159047-1000-1000/58152.jpg?v=637539258513000000",
      nombre: 'WP COLORMO SHAMPOO 1000ml',
      precio: "44290",
      precio2Int: 44290,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 504,
      fotoString:
          "https://varelayrodriguez.com/wp-content/uploads/2020/09/WP-ColorMotion-Mask-500ml-600x600.jpg",
      nombre: 'WP COLORMO MASK 500ml',
      precio: "48690",
      precio2Int: 48690,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 505,
      fotoString:
          "https://www.glamstore.com/web/image/product.template/27704/image?unique=5f898d0",
      nombre: 'CALP PRO COLOR MOTION WELLA 150ML',
      precio: "30990",
      precio2Int: 30990,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 506,
      fotoString:
          "https://www.glamstore.com/web/image/product.template/27702/image?unique=5f898d0",
      nombre: 'WP COLORMO POST COLOR TRT 500ml',
      precio: "65990",
      precio2Int: 65990,
      disponible: false,
      timestampString: timestamp));
  //--

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().blanco5_color_motion);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//falta
void guardardatos_wella_6_fusioncolor() async {
  String pelu = Constantes().blanco6_fusioncolor;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 601,
      fotoString:
          "http://pos.tua.cl/web/image/product.product/28137/image?unique=8ec1e6a",
      nombre: 'WP FUSION SHAMPOO 250ml',
      precio: " 17990",
      precio2Int: 17990,
      disponible: false,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 602,
      fotoString:
          "https://d3ugyf2ht6aenh.cloudfront.net/stores/999/095/products/4156041-5a4bffb210dd72a32915990753349458-480-0.png",
      nombre: 'WP FUSION CONDITIONER 200ml',
      precio: "18990",
      precio2Int: 18990,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 603,
      fotoString:
          "https://apozona.com/wp-content/uploads/2021/02/wella-color-motion-mask-150-ml.jpg",
      nombre: 'WP FUSION MASK 150ml',
      precio: "24690",
      precio2Int: 24690,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 604,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/157457-1000-1000/55789.jpg?v=637448606175100000",
      nombre: 'WP FUSION SHAMPOO 1000ml',
      precio: "44290",
      precio2Int: 44290,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 605,
      fotoString:
          "http://pos.tua.cl/web/image/product.product/27941/image?unique=8ec1e6a",
      nombre: 'WP FUSION CONDITIONER 1000ml',
      precio: "48690",
      precio2Int: 48690,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 606,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/157454-500-500/55787.jpg?v=637448606170730000",
      nombre: 'WP FUSION MASK 500ml',
      precio: "48690",
      precio2Int: 48690,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 607,
      fotoString: "http://pos.tua.cl/web/image/product.product/28135/image",
      nombre: 'WP FUSION PROTEC REF 70ml',
      precio: "25390",
      precio2Int: 25390,
      disponible: false,
      timestampString: timestamp));
  //--

  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().blanco6_fusioncolor);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//listo
void guardardatos_wella_7_oil_refrrection() async {
  String pelu = Constantes().blanco_7oilreflec;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156520-1000-1000/51920.png?v=637442490811770000",
      nombre: 'WP OIL REF SHAMPOO 250 ml',
      precio: " 17990",
      precio2Int: 17990,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 701,
      fotoString: "http://pos.tua.cl/web/image/product.product/27479/image",
      nombre: 'WP OIL REF CONDITIONER 200 ml',
      precio: "18990",
      precio2Int: 18990,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 702,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156519-1000-1000/51919.png?v=637442490809730000",
      nombre: 'WP OIL REF MASCARA 150 ml',
      precio: "24690",
      precio2Int: 24690,
      disponible: true,
      timestampString: timestamp));
  //--
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 703,
      fotoString:
          "https://www.glamstore.com/web/image/product.template/19987/image?unique=c789591",
      nombre: 'WP OIL REF SHP 1000 ml',
      precio: "42290",
      precio2Int: 42290,
      disponible: true,
      timestampString: timestamp));
  //--

  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 704,
      fotoString:
          "https://www.glamstore.com/web/image/product.template/19987/image?unique=c789591",
      nombre: 'WP OIL REF MASK 500 ml',
      precio: "42290",
      precio2Int: 42290,
      disponible: true,
      timestampString: timestamp));
  //--

  //aceite
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 705,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/157332-1000-1000/51921.png?v=637448605560230000",
      nombre: 'Aceite Oil Reflections 100 ML',
      precio: "22290",
      precio2Int: 22290,
      disponible: true,
      timestampString: timestamp));
  //--
  //--
  //aceite
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 706,
      fotoString: "http://pos.tua.cl/web/image/product.product/27524/image",
      nombre: 'Aceite Oil Reflections light 100 ML',
      precio: "22290",
      precio2Int: 22290,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 707,
      fotoString: "http://pos.tua.cl/web/image/product.product/27524/image",
      nombre: 'WP OIL REF SERUM 10X6 ml',
      precio: "50990",
      precio2Int: 50990,
      disponible: true,
      timestampString: timestamp));
  //--
  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().blanco_7oilreflec);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

//------------wella colors profesional
void guardardatos_wella_pelu_emulsiones_y_decolorantes() async {
  String pelu = Constantes().emulsiones_wella;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
//DECOLORANTES
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/155992-500-500/7239.jpg?v=637442488725130000",
      nombre: 'DECOLORANTE 800G',
      precio: " 41290",
      precio2Int: 41290,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156006-1000-1000/19876.jpg?v=637442488771170000",
      nombre: 'DECOLORANTE 400G',
      precio: " 20990",
      precio2Int: 20990,
      disponible: true,
      timestampString: timestamp));

  //COLOR PERFEC
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://cdn.webshopapp.com/shops/1867/files/120887690/wella-welloxon-perfect.jpg",
      nombre: 'COLOR PERFEC 10 VOL 1000 ML',
      precio: " 7290",
      precio2Int: 7290,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://teveslindapro.cl/wp-content/uploads/2021/08/Oxidante-20-Vol-Welloxon-Perfect-300x300.jpg",
      nombre: 'COLOR PERFEC 20 VOL 1000 ML',
      precio: " 7200",
      precio2Int: 7200,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://www.tremendatienda.com/content/images/thumbs/0001546_888418-MLU43533657320_092020_600.jpeg",
      nombre: 'COLOR PERFEC 30 VOL 1000 ML',
      precio: " 7290",
      precio2Int: 7290,
      disponible: true,
      timestampString: timestamp));
  // color touch
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/155758-500-500/1752.jpg?v=637442487696070000",
      nombre: 'COLOR TOUCH 6v 1000 ML',
      precio: " 7290",
      precio2Int: 7290,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/155761-1000-1000/1754.jpg?v=637442487705430000",
      nombre: 'COLOR TOUCH 13v 1000 ML',
      precio: " 7200",
      precio2Int: 7200,
      disponible: true,
      timestampString: timestamp));
  //

  // color touch
  //--
  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().emulsiones_wella);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}

void guardardatos_wella_pelu_1_color_perfec() async {
  String pelu = Constantes().colorperfec;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  List<Productoscarrito> peluqeurialist = [];
//DECOLORANTES
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/155992-500-500/7239.jpg?v=637442488725130000",
      nombre: 'DECOLORANTE 800G',
      precio: " 41290",
      precio2Int: 41290,
      disponible: true,
      timestampString: timestamp));
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/156006-1000-1000/19876.jpg?v=637442488771170000",
      nombre: 'DECOLORANTE 400G',
      precio: " 20990",
      precio2Int: 20990,
      disponible: true,
      timestampString: timestamp));

  //COLOR PERFEC
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://cdn.webshopapp.com/shops/1867/files/120887690/wella-welloxon-perfect.jpg",
      nombre: 'COLOR PERFEC 10 VOL 1000 ML',
      precio: " 7290",
      precio2Int: 7290,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://teveslindapro.cl/wp-content/uploads/2021/08/Oxidante-20-Vol-Welloxon-Perfect-300x300.jpg",
      nombre: 'COLOR PERFEC 20 VOL 1000 ML',
      precio: " 7200",
      precio2Int: 7200,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://www.tremendatienda.com/content/images/thumbs/0001546_888418-MLU43533657320_092020_600.jpeg",
      nombre: 'COLOR PERFEC 30 VOL 1000 ML',
      precio: " 7290",
      precio2Int: 7290,
      disponible: true,
      timestampString: timestamp));
  // color touch
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/155758-500-500/1752.jpg?v=637442487696070000",
      nombre: 'COLOR TOUCH 6v 1000 ML',
      precio: " 7290",
      precio2Int: 7290,
      disponible: true,
      timestampString: timestamp));
  //
  peluqeurialist.add(new Productoscarrito(
      categoriaProducto: pelu,
      codigo: 700,
      fotoString:
          "https://tuachl.vteximg.com.br/arquivos/ids/155761-1000-1000/1754.jpg?v=637442487705430000",
      nombre: 'COLOR TOUCH 13v 1000 ML',
      precio: " 7200",
      precio2Int: 7200,
      disponible: true,
      timestampString: timestamp));
  //

  // color touch
  //--
  final moviesRef = FirebaseFirestore.instance
      .collection('Productos')
      .doc('Catalogo')
      .collection(Constantes().colorperfec);

  for (var i = 0; i < peluqeurialist.length; i++) {
    moviesRef.add(peluqeurialist[i].toJson());
  }
}
