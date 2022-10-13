import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/view/widgets/drawer.dart';

class MyProfileScreen extends StatefulWidget {
  late UserProvider userProvider;
  MyProfileScreen({super.key, required this.userProvider});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
      var userData = widget.userProvider.currentUserData;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: HeaderDrawerWidget(userProvider: widget.userProvider),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "My Profile",
          style: TextStyle(color: textColor),
        
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                color: primaryColor,
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.userName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(userData.userEmail),
                          ],
                        ),
                        const SizedBox(width: 15),
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 20,
                          child: CircleAvatar(
                            backgroundColor: scaffoldBackgroundColor,
                            child: Icon(Icons.edit),
                            radius: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _listTile(
                    title: "My Orders",
                    iconData: Icons.shop_outlined,
                  ),
                  _listTile(
                    title: "My Delivery Address",
                    iconData: Icons.location_on_outlined,
                  ),
                  _listTile(
                    title: "Refer a Friend",
                    iconData: Icons.person_outline,
                  ),
                  _listTile(
                    title: "Terms & Conditions",
                    iconData: Icons.file_copy_outlined,
                  ),
                  _listTile(
                    title: "Privacy Policy",
                    iconData: Icons.podcasts_outlined,
                  ),
                  _listTile(
                    title: "About",
                    iconData: Icons.add_chart,
                  ),
                  _listTile(
                    title: "Log Out",
                    iconData: Icons.exit_to_app_outlined,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 85),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 50,
              child: CircleAvatar(
                // ignore: unnecessary_null_comparison
                backgroundImage: userData.userImage != null
                    ? NetworkImage(userData.userImage)
                    : const NetworkImage(
                        'https://img.freepik.com/free-vector/can-mixed-vegies_1308-13637.jpg?size=338&ext=jpg&ga=GA1.2.109477537.1664322018'),
                radius: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile({
    required IconData iconData,
    required String title,
  }) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
