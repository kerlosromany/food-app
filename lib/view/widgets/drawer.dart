import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/view/screens/my_profile.dart';
import 'package:food_app/view/screens/review_cart.dart';
import 'package:food_app/view/screens/wish_list_page.dart';

class HeaderDrawerWidget extends StatefulWidget {
  late UserProvider userProvider;
  HeaderDrawerWidget({super.key, required this.userProvider});

  @override
  State<HeaderDrawerWidget> createState() => _HeaderDrawerWidgetState();
}

class _HeaderDrawerWidgetState extends State<HeaderDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      backgroundColor: Color(0xffd1ad17),
      child: ListView(
        children: [
          DrawerHeader(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 43,
                    child: CircleAvatar(
                      // ignore: unnecessary_null_comparison
                      backgroundImage: userData.userImage != null
                          ? NetworkImage(
                              userData.userImage,
                            )
                          : const NetworkImage(
                              'https://img.freepik.com/free-vector/can-mixed-vegies_1308-13637.jpg?size=338&ext=jpg&ga=GA1.2.109477537.1664322018',
                            ),
                      radius: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userData.userName),
                      const SizedBox(height: 5),
                      Text(userData.userEmail, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 30,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(width: 2),
                              ),
                            ),
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          listTile(icon: Icons.home_outlined, title: "Home"),
          listTile(
            icon: Icons.shop_outlined,
            title: "Review Cart",
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ReviewCart()));
            },
          ),
          listTile(
            icon: Icons.person_outline,
            title: "My Profile",
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MyProfileScreen(userProvider: widget.userProvider,)));
            },
          ),
          listTile(icon: Icons.notifications_outlined, title: "Notification"),
          listTile(icon: Icons.star_outline, title: "Rating & Review"),
          listTile(
            icon: Icons.favorite_outline,
            title: "WishList",
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => WishListScreen()));
            },
          ),
          listTile(icon: Icons.copy_outlined, title: "Raise a complaint"),
          listTile(icon: Icons.format_quote_outlined, title: "FAQs"),
          Container(
            height: 350,
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Contact Support"),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text("Call Us"),
                    SizedBox(width: 10),
                    Text("+956562314654"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Mail Us"),
                    const SizedBox(width: 10),
                    Text(userData.userEmail),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
