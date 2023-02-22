import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/images_assets.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Alice'),
              accountEmail: Text('Alicedemaillot@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child : ClipOval(
              child: Image.asset(
                ImagesAsset.Avatar,
                  width : 80,
                  height: 80,
                  fit : BoxFit.cover,
              ),

            )
          ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImagesAsset.Background),
                      fit: BoxFit.cover)),),
          ListTile(
            leading: Icon(Icons.favorite),
            title:  Text('Favoris'),
            onTap :()=> null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title:  Text('Partager'),
            onTap :()=> null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title:  Text('Paramatres'),
            onTap :()=> null,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title:  Text('Acceuil'),
            onTap :()=> null,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title:  Text('Se déconnecter'),
            onTap :()=> FirebaseAuth.instance.signOut(),
          )

        ],
      ),
    );
    throw UnimplementedError();
  }
}
