// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer/app/pages/filhotes/filhote_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:commons/commons.dart';

class PrecoFilhoteCard extends StatelessWidget {
  final Product pet;
  final VoidCallback onTap;

  PrecoFilhoteCard({
    required this.pet,
    required this.onTap,
  });

  final _bloc = FilhoteBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap, //TODO: Descomentar
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(right: 8),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: pet.imgUrl,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(pet.imgUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    pet.title,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.green,
                          primary: Colors.green,
                        ),
                        onPressed: () async {
                          String? phone = await _bloc.phone(pet.storeId);
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
                        child: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.pink,
                          primary: Colors.pink,
                        ),
                        onPressed: () async {
                          var instagram = await _bloc.instagram(pet.storeId);
                          if (instagram != null) {
                            launch('https://www.instagram.com/$instagram');
                          } else {
                            alert(
                              context,
                              'Desculpe, a loja não forneceu nenhum Instagram',
                            );
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  )
                  // child: Wrap(
                  //   alignment: WrapAlignment.center,
                  //   crossAxisAlignment: WrapCrossAlignment.center,
                  //   children: [
                  //     Icon(Icons.phone, size: 16),
                  //     SizedBox(
                  //       width: 2,
                  //     ),
                  //     Text('Contato'),
                  //   ],
                  // )),
                  // Text(
                  //   'R\$${pet.preco}',
                  //   style: TextStyle(
                  //     color: Colors.grey[600],
                  //     fontSize: 12,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
Widget tag(){
  return Container(
                    decoration: BoxDecoration(
                      color: pet.condition == "Adoption"
                          ? Colors.orange[100]
                          : pet.condition == "Disappear"
                              ? Colors.red[100]
                              : Colors.blue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      pet.condition,
                      style: TextStyle(
                        color: pet.condition == "Adoption"
                            ? Colors.orange
                            : pet.condition == "Disappear"
                                ? Colors.red
                                : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
}
*/

/*Pet Distance
Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        pet.location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "(" + pet.distance + "km)",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
*/