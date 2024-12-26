// import 'package:flutter/material.dart';

// import 'package:client/components/tab.dart';
// import 'package:client/providers/theme.dart';

// class CustomTabBar extends StatelessWidget {
//   CustomTabBar({
//     super.key,
//     required this.tabs,
//     this.active = "",
//     this.enabled = true,
//     this.handler,
//   });

//   final void Function(String)? handler;
//   final List<String> tabs;
//   final String active;
//   final bool enabled;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * .1,
//       child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: tabs
//               .map((tab) => RealmTab(
//                     label: tab,
//                     active: tab.toLowerCase() == active.toLowerCase(),
//                     handler: enabled ? handler : (s) {},
//                   ))
//               .toList()),
//     );
//   }
// }
