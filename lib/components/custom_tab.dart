// import 'package:flutter/material.dart';

// class CustomTab extends StatelessWidget {
//   CustomTab(
//       {super.key,
//       required this.label,
//       this.active = false,
//       this.handler,
//       this.enabled = true});

//   final void Function(String)? handler;
//   final String label;
//   final bool active;
//   final bool enabled;

//   @override
//   Widget build(BuildContext context) {
//     // if( handler != null ) {
//     //   return GestureDetector(
//     //     //onTap: () => handler!( label ),
//     //     child: buildTab(),
//     //   );
//     // }

//     //return buildTab();

//     return Expanded(
//       child: GestureDetector(
//         onTap: enabled && handler != null ? () => handler!(label) : null,
//         child: Stack(children: [
//           Positioned.fill(
//             child: ColorFiltered(
//               colorFilter: ColorFilter.mode(
//                 _theme.color,
//                 _theme.blendMode,
//               ),
//               child: Image.asset(
//                 "assets/ui/tab.png",
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//               child: Text(label,
//                   style: enabled
//                       ? (active ? _theme.textLargeBold : _theme.textLarge)
//                       : _theme.textLarge
//                           .copyWith(color: _theme.colorDisabled))),
//         ]),
//       ),
//     );
//   }
// }
