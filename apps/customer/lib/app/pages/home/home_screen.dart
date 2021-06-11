import 'package:flutter/material.dart';
import 'package:pedigree/app/pages/filhotes/product_repository.dart';
import 'package:pedigree/app/pages/home/components/filhote_home_section.dart';
import 'components/home_title_section_widget.dart';
import 'components/pet_category_section_widget.dart';


class _Bloc {
  final _rep = ProductRepository();
  get news => _rep.recentlyAdded;
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    // final appBar = AppBar(
    //     leading: Icon(
    //       Icons.sort,
    //       color: Colors.grey[800],
    //     ),
    //     actions: [
    //       Padding(
    //         padding: EdgeInsets.only(right: 16),
    //         child: Icon(
    //           Icons.notifications_none,
    //           color: Colors.grey[800],
    //         ),
    //       ),
    //     ],
    //     );

    final body = SafeArea(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          HomeTitleSectionWidget(),
          PetCategorySectionWidget(),
          FilhoteHomeSection(
            sectionTitle: "Novos",
            stream: _Bloc().news,
          ),
        ],
      ),
    );

    return Scaffold(
      // appBar: appBar,
      body: body,
    );
  }
}
