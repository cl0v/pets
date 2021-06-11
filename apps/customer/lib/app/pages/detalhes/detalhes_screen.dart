// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

import 'package:pedigree/app/pages/filhotes/filhote_bloc.dart';
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
          _featureRow(),
          Sobre(
            title: "Sobre",
            text:
                "Rottweiler é uma raça de cães molossos desenvolvida na Alemanha. Criada por açougueiros da região de Rottweil para o trabalho com o gado, logo tornou-se um eficiente cão de guarda e boiadeiro, e cão de tração.",
          ),
          Sobre(
            title: "Sobre o Canil",
            text: "Canil de nestão é so qualidade brow",
          ),
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
                Text(
                  'R\$${widget.pet}',
                  style: TextStyle(
                    // color: Colors.grey[00],
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () async {
                var phone = await _bloc.phone(widget.pet.storeId);
                if (phone != '') {
                  //"whatsapp://send?phone=$phone";
                  //https://api.whatsapp.com/send?phone=$phone&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20mais%20sobre%20o%20filhote%20que%20vi%20no%20aplicativo
                  // launch("tel://214324234");
                  launch('https://api.whatsapp.com/send?phone=$phone&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20mais%20sobre%20o%20filhote%20que%20vi%20no%20aplicativo');
                } else {
                  alert(context, 'Desculpe, a loja não forneceu nenhum número');
                }
              },
              label: Text('Negociar'),
              icon: Icon(
                Icons.phone,
              ),
            )
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
