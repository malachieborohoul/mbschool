import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/common/widgets/custom_users_container.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/common/widgets/nodata.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/users/screens/user_details_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/search/services/search_service.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/search_user_provider.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = "users-screen";
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final CourseManagerService _courseManagerService = CourseManagerService();
  final SearchService _searchService = SearchService();
  final TextEditingController _keyword = TextEditingController();
  bool isCharging = false;

  late Future<List<User>> users;
  late Future<List<User>> allUsers;
  void searchUsers(String nom) {
    // print(nom);
    if (nom.isEmpty) {
      getAllUsers();
      setState(() {
        isCharging = false;
      });
    } else {
      users = _searchService.searchUsers(context, nom);
      setState(() {
        isCharging = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  void getAllUsers() {
    users = _courseManagerService.getAllUsers(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(135),
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Text(
                      "Utilisateurs",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  width: size.width,
                  height: spacer,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: textWhite,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          '${assetImg}search_icon.svg',
                          color: secondary.withOpacity(0.5),
                          height: 15.0,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: size.width,
                          height: 38,
                          alignment: Alignment.topCenter,
                          child: TextFormField(
                            controller: _keyword,
                            onChanged: (text) {
                              // print(text);
                              setState(() {
                                isCharging = true;
                                searchUsers(text);
                              });
                            },
                            style: const TextStyle(fontSize: 15),
                            cursorColor: textBlack,
                            decoration: InputDecoration(
                              hintText: "Rechercher utilisateur",
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: secondary.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 10.0),
                    ],
                  ),
                )
              ],
            ),
          )),
      // body: isCharging == true || cours == null
      //     ? Loader()
      //     : Column(
      //         children: List.generate(
      //             cours.length, (index) => Text(cours[index].nom)),
      //       ),

      body: isCharging == true 
          ? const Loader():
           Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FutureBuilder(
                      future: users,
                      builder: (context, AsyncSnapshot<List<User>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return snapshot.data!.isEmpty ? const NoData(): ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, UserDetailsScreen.routeName,
                                      arguments: snapshot.data![i]);
                                  Provider.of<SearchUserProvider>(context,
                                          listen: false)
                                      .set_user(snapshot.data![i]);
                                },
                                child: CustomUsersContainer(
                                    user: snapshot.data![i]),
                              );
                            },
                          );
                        } else {
                          return const Loader();
                        }
                      }),
                ),
    );
  }
}
