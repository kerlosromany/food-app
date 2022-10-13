// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class ProductUnitWidget extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;
//   const ProductUnitWidget(
//       {super.key, required this.onTap, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.only(left: 2),
//         height: 30,
//         width: 50,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(fontSize: 10, color: Colors.black),
//               ),
//             ),
//             const Icon(
//               Icons.arrow_drop_down,
//               size: 25,
//               color: Colors.yellow,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
