// import 'package:flutter/material.dart';
// import 'package:ghumfir_f/Models/post_model.dart';
// import 'package:ghumfir_f/MyHomePage/Recommenadation/DescriptionDetail.dart';
//
// import '../../api.dart';
//
// class RecommendationCard extends StatelessWidget {
//   final PostModel item;
//
//   RecommendationCard(
//     this.item,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           clipBehavior: Clip.hardEdge,
//           width: 400,
//           height: 436,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 3,
//                 blurRadius: 7,
//                 offset: Offset(0, 2),
//               ),
//             ],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Hero(
//                 tag: "card-to-description${item.id}",
//                 child: Image.network(
//                   "${Api.baseUrl.substring(0, Api.baseUrl.length - 1)}${item.url}",
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.cover,
//                   height: 300,
//                 ),
//               ),
//               const SizedBox(
//                 height: 22,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Text(
//                   "Kathmandu World Heritage Sites Tour",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.3),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return DescriptionDetail(item.id);
//                   }));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: const [
//                       Text(
//                         "View Details",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xff0394B6),
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 1.3,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 12,
//                       ),
//                       Icon(
//                         Icons.arrow_circle_right_outlined,
//                         color: Color(0xff0394B6),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 100,
//           left: 0,
//           right: 0,
//           child: Container(
//             margin: EdgeInsets.all(12),
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.access_time_filled_sharp,
//                     color: Color(0xff2c5f2d),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   const Text("5 days"),
//                   Expanded(child: Container()),
//                   const Icon(
//                     Icons.location_pin,
//                     color: Color(0xff2c5f2d),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   const Text("Kathmandu"),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
