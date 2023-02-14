import 'package:flutter/material.dart';
import 'package:blabloglucy/models/consult_model.dart';
import 'package:blabloglucy/utills/constant.dart';

class ConsultGroupCard extends StatelessWidget {
  const ConsultGroupCard({
    Key? key,
    required this.consultModel,
  }) : super(key: key);

  final ConsultModel consultModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.asset(
            consultModel.imagePath,
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            decoration: const BoxDecoration(color: Color(0x33000000)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    consultModel.consultName,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.fontFamilyName,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget itemDesign(ConsultModel item) {
//   return Card(
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(
//         Radius.circular(12),
//       ),
//     ),
//     semanticContainer: true,
//     clipBehavior: Clip.antiAlias,
//     child: Stack(
//       children: [
//         Image.asset(
//           item.imagePath,
//           fit: BoxFit.fitHeight,
//           height: MediaQuery.of(context).size.height,
//         ),
//         Container(
//           decoration: const BoxDecoration(color: Color(0x33000000)),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: Text(
//                   item.consultName,
//                   // textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: Constant.fontFamilyName,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
