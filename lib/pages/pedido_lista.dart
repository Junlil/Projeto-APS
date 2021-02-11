import 'package:compras/productos_model/producto_models.dart';
//import 'package:fancy_dialog/FancyAnimation.dart';
//import 'package:fancy_dialog/FancyGif.dart';
//import 'package:fancy_dialog/FancyTheme.dart';
//import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<ProdutosModelo> _cart;

  Cart(this._cart);
  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProdutosModelo> _cart;

  Container pagoTotal(List<ProdutosModelo> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text("Total:  R\$${valorTotal(_cart)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(List<ProdutosModelo> listaProdutos) {
    double total = 0.0;

    for (int i = 0; i < listaProdutos.length; i++) {
      total = total + listaProdutos[i].price * listaProdutos[i].quantity;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu_book),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: Text(
          'Detalhes',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _firstScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _firstScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _cart.length,
                  itemBuilder: (context, index) {
                    final String imagem = _cart[index].image;
                    var item = _cart[index];
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    width: 100,
                                    height: 100,
                                    child: new Image.asset(
                                        "assets/images/$imagem",
                                        fit: BoxFit.contain),
                                  )),
                                  Column(
                                    children: <Widget>[
                                      Text(item.name,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Colors.black)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.blue[600],
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Colors.blue[400],
                                                    offset: Offset(0.0, 1.0),
                                                  )
                                                ],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50.0),
                                                )),
                                            margin: EdgeInsets.only(top: 20.0),
                                            padding: EdgeInsets.all(2.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    _removeProduto(index);
                                                    valorTotal(_cart);
                                                  },
                                                  color: Colors.white,
                                                ),
                                                Text('${_cart[index].quantity}',
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.white)),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    valorTotal(_cart);
                                                    _addProduto(index);
                                                  },
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 38.0,
                                  ),
                                  Text(item.price.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0,
                                          color: Colors.black))
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.purple,
                        )
                      ],
                    );
                  }),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                padding: EdgeInsets.only(top: 50),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text("PAGAR"),
                  onPressed: () => {
                    //showDialog(
                    //    context: context,
                    //    builder: (BuildContext context) => FancyDialog(
                    //        title: "Aceitar compra",
                    //        descreption: "Enviar por WhatsApp",
                    //        animationType: FancyAnimation.BOTTOM_TOP,
                    //        theme: FancyTheme.FANCY,
                    //        gifPath: './assets/gifs/dedo.gif',
                    //        okFun: () => {print("it's working :)")}))
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String get newMethod => "it's working  :)";

  _addProduto(int index) {
    setState(() {
      _cart[index].quantity++;
    });
  }

  _removeProduto(int index) {
    setState(() {
      _cart[index].quantity--;
    });
  }
}
