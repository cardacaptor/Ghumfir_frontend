// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../OldUI/Header/ContactBar.dart';
// import '../../OldUI/Header/HeaderFile.dart';
//
// class DescriptionDetail extends StatelessWidget {
//   final int index;
//
//   DescriptionDetail(this.index);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ContactBar(),
//               Stack(
//                 children: [
//                   Hero(
//                     tag: "card-to-description$index",
//                     child: Image.asset('assets/images/image_2.png',
//                         height: 640,
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.cover),
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     left: 0,
//                     child: HeaderFile(),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 86.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Kathmandu World Heritage Sites Tour",
//                       style: GoogleFonts.rufina(
//                         textStyle: TextStyle(
//                           fontSize: 38,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Text(
//                       "Lorem ipsum dolor sit amet consectetur. Vestibulum et neque enim sollicitudin amet feugiat. In sit nunc amet vitae vel id at maecenas. Arcu a risus augue pulvinar et rhoncus ac. Amet iaculis integer quis interdum aliquet vitae amet mattis. Ac ultricies dictum faucibus ultrices mauris nibh. Felis nulla tempor sagittis cras. Vitae venenatis placerat habitant nisi pharetra morbi turpis amet. Interdum at ullamcorper venenatis facilisis.Id cursus elit aliquet turpis id ultrices. In nisl tristique sapien nibh. Sit egestas velit duis lectus pharetra mauris varius egestas. Diam at eu blandit ultricies vitae nisl. Enim morbi lorem felis nulla tincidunt tincidunt sed. Ultrices nisl phasellus lobortis purus eu sagittis ipsum suspendisse. Eu nunc diam velit malesuada eros eget sollicitudin lacinia nibh. Odio fermentum scelerisque semper tristique semper tellus consectetur. Diam posuere fusce amet quisque. Malesuada eu malesuada non sit iaculis curabitur. Accumsan facilisis viverra amet lacus orci sed. Pellentesque arcu quis lorem a cursus quis egestas massa. Malesuada molestie praesent metus enim. Pulvinar mauris eget vestibulum mi. Mi tincidunt mi ullamcorper massa.Enim fermentum imperdiet dolor varius quis sed. Consequat mauris egestas fermentum elit nec purus leo duis porttitor. Vestibulum fermentum montes parturient bibendum vulputate diam ac. Dolor tincidunt ultrices odio dolor risus bibendum etiam mauris orci. Nunc sed sed morbi scelerisque convallis enim. Non tincidunt iaculis diam elementum aenean. Justo amet sed venenatis auctor. Ante egestas porta ullamcorper arcu nulla venenatis massa. Hac congue pellentesque in tempus.Tellus mauris eu eget sit aliquam consequat ultrices eros. Viverra viverra urna vivamus vulputate nibh lorem. Tortor augue id viverra rhoncus netus et sed. Vestibulum ullamcorper convallis vitae turpis. Aliquet curabitur non fusce enim quis arcu accumsan id. Integer risus condimentum bibendum sed in arcu ut proin. Proin sit morbi eget arcu id. Pulvinar eu vitae quisque gravida non est velit a. Ultrices at ultrices pulvinar elit laoreet dis bibendum blandit vivamus. Purus viverra semper et at elit habitant nulla. Urna feugiat nulla augue at.Integer viverra laoreet blandit odio fringilla varius. Curabitur phasellus facilisis eros et adipiscing semper vestibulum. Urna vulputate justo aliquet fames nisl vulputate. Aliquet lobortis pellentesque justo semper euismod. Vulputate leo velit fusce nulla tortor in. Tristique ipsum enim nisi eget adipiscing turpis tempor. Et pretium dictum natoque gravida turpis mauris est eu morbi. Neque pretium amet consequat facilisis urna sed. Turpis varius purus consectetur arcu mi. Eu molestie gravida duis libero ut libero maecenas. In tincidunt sit vel eget.",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       textAlign: TextAlign.justify,
//                     ),
//                     SizedBox(
//                       height: 73,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.thumb_up_outlined,
//                           size: 36,
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         Icon(
//                           Icons.thumb_down_outlined,
//                           size: 36,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 100,),
//                   ],
//                 ),
//               ),
//               // Recommenadation(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
