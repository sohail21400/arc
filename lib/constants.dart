import 'package:flutter/material.dart';

BuildContext myAppContext;

final headingOne = TextStyle(fontSize: 40, fontWeight: FontWeight.w600);

final subTitleStyle = TextStyle(fontSize: 17);

final superSubTitle = TextStyle(fontSize: 14);

Widget settingsContentCard(BuildContext context, Icon icon, String title, Widget trailing) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        leading: icon,
        title: Text(title),
        trailing: trailing,
        onTap: () {},
      ),
    ),
  );
}


