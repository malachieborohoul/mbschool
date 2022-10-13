import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_right_tween.dart';
import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_search_field.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/promotion.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/search/services/search_service.dart';
import 'package:mbschool/models/cours.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = 'search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<Cours> cours = [];

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeader(),
          ),
          SliverToBoxAdapter(
              child: cours == null
                  ? Loader()
                  : Padding(
                      padding: const EdgeInsets.all(appPadding),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: spacer,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const CustomHeading(
                                //     title: "Tous les cours",
                                //     subTitle: "Reprenons",
                                //     color: textBlack),
                                SlideUpTween(
                                  offset: 40,
                                  child: Text(
                                    "${cours.length} Cours",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: secondary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: spacer,
                            ),
                            Column(
                              children: List.generate(cours.length, (index) {
                                return SlideRightTween(
                                  duration: Duration(milliseconds: index * 500),
                                  curve: Curves.easeInOutCubic,
                                  offset: 80,
                                  child: OpacityTween(
                                    begin: 0,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  DetailCourseScreen.routeName,
                                                  arguments: cours[index]);
                                            },
                                            child: CustomCourseCardShrink(
                                                thumbNail:
                                                    cours[index].vignette,
                                                title: cours[index].titre,
                                                nom: cours[index].nom,
                                                prenom: cours[index].prenom,
                                                price: cours[index].prix.isEmpty
                                                    ? "Gratuit"
                                                    : cours[index].prix))),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    )),
        ],
      )),
    );
  }
}

const _maxHeaderExtent = 200.0;
const _minHeaderExtent = 120.0;
const _maxFontSize = 25.0;
const _minFontSize = 20.0;
const _marginLeft = 170.0;

class _SearchHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    const _searchWidth = 300.0;
    print(percent);

    return Container(
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Stack(
          children: [
            Positioned(
              // width: (_searchWidth * (1 - percent)).clamp(60.0, _searchWidth),
              top: (30 * (1 - percent)).clamp(25, 30),
              right: (_marginLeft * (1 - percent)).clamp(150, _marginLeft),
              child: Text(
                "Recherche",
                style: TextStyle(
                    fontSize: (_maxFontSize * (1 - percent))
                        .clamp(_minFontSize, _maxFontSize),
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: appPadding,
            // ),
            Positioned(
              // left: (150*(1-percent)).clamp(33.0, 150),
              top: (80 * (1 - percent)).clamp(10.0, 80),
              width: (_searchWidth * (1 - percent)).clamp(60.0, _searchWidth),
              child: CustomSearch(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class CustomSearch extends StatefulWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  TextEditingController _keyword = TextEditingController();

  SearchService _searchService = SearchService();

  @override
  void dispose() {
    _keyword.dispose();
    super.dispose();
  }

  void searchCourses(String textField) async {
    cours = await _searchService.searchCourses(context, textField);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return 
    Container(
      width: size.width,
      height: spacer,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: textWhite, borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            child: Container(
              child: SvgPicture.asset(
                assetImg + 'search_icon.svg',
                color: secondary.withOpacity(0.5),
                height: 15.0,
              ),
            ),
          ),
          Flexible(
            child: Container(
              width: size.width,
              height: 38,
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _keyword,
                onChanged: (text) {
                  searchCourses(text);
                    
                },
                style: TextStyle(fontSize: 15),
                cursorColor: textBlack,
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: secondary.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  
  }
}



//  body: exigences == null ||
//               sections == null ||
//               lecons == null ||
//               isCourseInFav == null
//           ? Loader()
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * .4,
//                         width: MediaQuery.of(context).size.width,
//                         color: Colors.transparent,
//                         child: Hero(
//                           tag: widget.cours.vignette,
//                           child: ClipRRect(
//                             child: Image.network(
//                               widget.cours.vignette,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: textWhite,
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                       backgroundColor: textBlack,
//                                       content: VideoDisplay(
//                                           videoUrl:
//                                               'https://res.cloudinary.com/dshli1qgh/video/upload/v1660467558/dogs%20/i7nluycv93dqouta4cmt.mp4'),
//                                     ));
//                           },
//                           splashColor: Colors.grey,
//                           child: Icon(Icons.play_arrow),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: EdgeInsets.only(
//                       //     left: MediaQuery.of(context).size.width * 0.8,
//                       //     top: MediaQuery.of(context).size.height * 0.4,
//                       //   ),
//                       //   child:  Icon(
//                       //     color: Color.fromARGB(255, 255, 0, 0),
//                       //     Icons.favorite_outline_rounded,
//                       //   ),
//                       // ),
//                     ],
//                   ),
                  
//                   SlideDownTween(
//                       offset: 25,
//                       child: OpacityTween(
//                           begin: 0,
//                           child: CustomDetailCourseInfoHeader(
//                             cours: widget.cours,
//                             isCourseInFav: isCourseInFav!,
//                           ))),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: appPadding,
//                         right: appPadding,
//                         bottom: appPadding),
//                     child: Container(
//                       width: double.infinity,
//                       height: 50,
//                       child: TabBar(
//                           labelColor: Colors.black,
//                           indicatorColor: primary,
//                           controller: _tabController,
//                           tabs: const [
//                             OpacityTween(
//                               begin: 0,
//                               child: Tab(
//                                 text: "Apropos",
//                               ),
//                             ),
//                             OpacityTween(
//                               begin: 0,
//                               child: Tab(
//                                 text: "Lecons",
//                               ),
//                             ),
//                             OpacityTween(
//                               begin: 0,
//                               child: Tab(
//                                 text: "Avis",
//                               ),
//                             ),
//                           ]),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: appPadding,
//                         right: appPadding,
//                         bottom: appPadding),
//                     child: Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: third,
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                       ),
//                       child: OpacityTween(
//                         begin: 0.0,
//                         child: Padding(
//                           padding: const EdgeInsets.all(appPadding),
//                           child:
//                               TabBarView(controller: _tabController, children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Ce cours contient",
//                                   style:
//                                       TextStyle(color: textWhite, fontSize: 20),
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text(
//                                   "15 leçons",
//                                   style: TextStyle(color: textWhite),
//                                 ),
//                                 Divider(
//                                   thickness: 0.5,
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 Text(
//                                   "15 leçons",
//                                   style: TextStyle(color: textWhite),
//                                 ),
//                                 Divider(
//                                   thickness: 0.5,
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 for (int i = 0; i < sections.length; i++)
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       left: appPadding,
//                                       right: appPadding,
//                                       bottom: appPadding,
//                                     ),
//                                     child: CustomCourseCurriculum(
//                                       section: sections[i],
//                                       cours: widget.cours,
//                                     ),
//                                   )
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Les exigences du cours",
//                                   style:
//                                       TextStyle(color: textWhite, fontSize: 20),
//                                 ),
//                                 for (int i = 0; i < exigences.length; i++)
//                                   CustomExigenceCours(exigence: exigences[i])
//                               ],
//                             ),
//                           ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
