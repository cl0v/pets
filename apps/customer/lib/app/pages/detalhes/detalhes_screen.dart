import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/app/pages/categoria/categoria_bloc.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

import 'package:customer/app/pages/filhotes/filhote_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesScreen extends StatefulWidget {
  final Product pet;

  const DetalhesScreen({
    Key? key,
    required this.pet,
  }) : super(key: key);
  @override
  _DetalhesScreenState createState() => _DetalhesScreenState();
}

class _DetalhesScreenState extends State<DetalhesScreen> {
  final _bloc = FilhoteBloc();
  final _cBloc = CategoryBloc();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      shadowColor: Colors.black.withOpacity(.1),
      // Caso a imagem seja
      // Branca vai dar um help
      elevation: 1,
      leading: BackButton(),
    );

    final body = SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _petCoolImage(),
          _petTitleAndPrice(),
          // _featureRow(),
          FutureBuilder<String>(
              future: _cBloc.fetchEspecieDescription(widget.pet.category),
              builder: (c, s) {
                if (s.hasData) {
                  if (s.data != null) {
                    return Sobre(
                      title: "Sobre",
                      text: s.data!,
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          
          //TODO: Ver informacoes do canil >> // nao precisa ainda
          // Sobre(
          //   title: "Sobre o Canil",
          //   text: "Canil de nestão é so qualidade brow",
          // ),
          SizedBox(
            height: 72,
          )
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: body,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.pink,
            child: FaIcon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              var instagram = await _bloc.instagram(widget.pet.storeId);
              if (instagram != null) {
                launch('https://www.instagram.com/$instagram');
              } else {
                alert(
                  context,
                  'Desculpe, a loja não forneceu nenhum Instagram',
                );
              }
            },
          ),
          SizedBox(
            width: 12,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.green,
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              String? phone = await _bloc.phone(widget.pet.storeId);
              if (phone != null) {
                launch(
                    'https://api.whatsapp.com/send?phone=$phone&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20mais%20sobre%20o%20filhote%20que%20vi%20no%20aplicativo');
              } else {
                alert(
                  context,
                  'Desculpe, a loja não forneceu nenhum número',
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Padding _featureRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          PetFeature(value: "45 dias", feature: "Idade"),
          PetFeature(value: "Cinza", feature: "Cor"),
          // buildPetFeature("11 Kg", "Weight"),
        ],
      ),
    );
  }

  Container _petTitleAndPrice() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pet.title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                // Text(
                //   'R\$${widget.pet.price != '' ? widget.pet.price : 'não informado'}',
                //   style: TextStyle(
                //     // color: Colors.grey[00],
                //     // fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // )
              ],
            ),

            // favorite(true),
          ],
        ),
      ),
    );
  }

  Hero _petCoolImage() {
    return Hero(
      tag: widget.pet.imgUrl,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              widget.pet.imgUrl,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }

  favorite(bool isFavorite) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFavorite ? Colors.red[400] : Colors.white,
      ),
      child: Icon(
        Icons.favorite,
        size: 24,
        color: isFavorite ? Colors.white : Colors.grey[300],
      ),
    );
  }
}

class PetFeature extends StatelessWidget {
  final String value;
  final String feature;

  const PetFeature({Key? key, required this.value, required this.feature})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              feature,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sobre extends StatelessWidget {
  final String title;
  final String text;

  const Sobre({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          // padding: EdgeInsets.only(left: 16, top: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
