import 'package:firechat/pages/auth/login_page.dart';
import 'package:firechat/pages/profile/profile_page.dart';
import 'package:firechat/service/auth_service.dart';
import 'package:firechat/service/sf_services.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
    required String userImgPath,
    required String userName,
    required String userEmail,
  })  : _userImgPath = userImgPath,
        _userName = userName,
        _userEmail = userEmail,
        super(key: key);

  final String _userImgPath;
  final String _userName;
  final String _userEmail;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  SharedPrefServices sharedPrefServices = SharedPrefServices();
  AuthServices authServices = AuthServices();

  void signOut() async {
    sharedPrefServices.setUserEmail(userEmail: "");
    sharedPrefServices.setUserName(userName: "");
    sharedPrefServices.setUserLoggedInStatus(isLoggedIn: false);
    await authServices.signOut();
    // nav
    if (!mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(
            height: 48,
          ),
          CircleAvatar(
            radius: 56,
            backgroundColor: Colors.grey,
            child: widget._userImgPath != ""
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(widget._userImgPath),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.person),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget._userName,
            textAlign: TextAlign.center,
          ),
          Text(
            widget._userEmail,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {},
            selected: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const Icon(Icons.groups),
            title: const Text('Groups'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            },
            selected: false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const Icon(Icons.account_box_rounded),
            title: const Text('Profile'),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Oh no! you\'re leaving..'),
                    content: const Text('are you sure?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Naah, Just kidding'),
                      ),
                      TextButton(
                        onPressed: signOut,
                        child: const Text('Yes, Log Me Out'),
                      ),
                    ],
                  );
                },
              );
            },
            selected: false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
