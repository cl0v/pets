import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:commons/commons.dart';

class FilhoteHomeSection extends StatelessWidget {
  final String sectionTitle;
  final Stream<List<Product>> stream;

  const FilhoteHomeSection({
    Key? key,
    required this.sectionTitle,
    required this.stream,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              // Icon(
              //   Icons.more_horiz,
              //   color: Colors.grey[800],
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 280,
            child: StreamBuilder<List<Product>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    var list = snapshot.data!;
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: list
                          .map(
                            (f) => PetCard(
                              f: f,
                              // onTap: () {},
                            ),
                          )
                          .toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
        ),
      ],
    );
  }
}

class PetCard extends StatelessWidget {
  final Product f;

  const PetCard({Key? key, required this.f}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: EdgeInsets.only(right: 8, left: 16, bottom: 16),
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: f.imgUrl,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(f.imgUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Container(
                        height: 30,
                        width: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(4),
                          ),
                          color: Colors.yellow[400],
                        ),
                        child: Center(
                          child: Text(
                            'NOVO',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        )
                        // Icon(
                        //   Icons.new_releases,
                        //   size: 16,
                        //   color: Colors.white,
                        // ),
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  f.title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
