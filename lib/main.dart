import 'package:compras/pages/otra_pagina.dart';
import 'package:compras/pages/pedido_lista.dart';
import 'package:compras/productos_model/producto_models.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BookStore'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProdutosModelo> _produtosModelo = List<ProdutosModelo>();

  List<ProdutosModelo> _listaCarro = List<ProdutosModelo>();

  @override
  void initState() {
    super.initState();
    _produtosDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------Menu Lateral------
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 38,
                  ),
                  if (_listaCarro.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    )
                ],
              ),
              onTap: () {
                if (_listaCarro.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_listaCarro),
                    ),
                  );
              },
            ),
          )
        ],
      ),
      drawer: Container(
        width: 170.0,
        child: Drawer(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.blue,
            child: new ListView(
              padding: EdgeInsets.only(top: 50.0),
              children: <Widget>[
                Container(
                  height: 150,
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text(''),
                    accountEmail: new Text(''),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('assets/images/book.png'),
                            fit: BoxFit.fill)),
                  ),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Página Principal',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.home,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OutraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Perfil',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.account_circle,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OutraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Procurar',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.search,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OutraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Login/SignOut',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.login,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OutraPagina(),
                  )),
                ),
                new Divider(),
              ],
            ),
          ),
        ),
      ),
      //--------------------------
      body: _quadroProdutos(),
    );
  }

  GridView _quadroProdutos() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _produtosModelo.length,
      itemBuilder: (context, index) {
        final String imagem = _produtosModelo[index].image;
        var item = _produtosModelo[index];
        return Card(
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new Image.asset("assets/images/$imagem",
                          fit: BoxFit.contain),
                    ),
                    Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          item.price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: (!_listaCarro.contains(item))
                                  ? Icon(
                                      Icons.shopping_cart,
                                      color: Colors.green,
                                      size: 38,
                                    )
                                  : Icon(
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                      size: 38,
                                    ),
                              onTap: () {
                                setState(() {
                                  if (!_listaCarro.contains(item))
                                    _listaCarro.add(item);
                                  else
                                    _listaCarro.remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ));
      },
    );
  }

  void _produtosDb() {
    var list = <ProdutosModelo>[
      ProdutosModelo(
        name: 'A Rev. dos Bichos',
        image: 'Livro1.png',
        price: 19.9,
      ),
      ProdutosModelo(
        name: 'Hibisco Roxo',
        image: 'Livro2.png',
        price: 49.9,
      ),
      ProdutosModelo(
        name: 'Real English',
        image: 'Livro3.png',
        price: 72.0,
      ),
      ProdutosModelo(
        name: 'Contos de Fadas Nórdicos',
        image: 'Livro4.png',
        price: 75.9,
      ),
      ProdutosModelo(
        name: 'Contos de H.P. Lovecraft',
        image: 'Livro5.png',
        price: 19.9,
      ),
      ProdutosModelo(
        name: 'A Menina que Roubava Livros',
        image: 'Livro6.png',
        price: 29.9,
      ),
    ];

    setState(() {
      _produtosModelo = list;
    });
  }
}
