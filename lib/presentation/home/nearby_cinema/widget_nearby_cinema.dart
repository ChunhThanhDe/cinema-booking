// /*
//  * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
//  * @ Created: 2024-12-21 21:28:06
//  * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
//  */

// import 'dart:async';

// import 'package:cinema_booking/common/widgets/space/widget_spacer.dart';
// import 'package:cinema_booking/core/configs/theme/app_font.dart';
// import 'package:cinema_booking/domain/entities/cinema/cinema.dart';
// import 'package:cinema_booking/presentation/home/bloc/home_bloc.dart';
// import 'package:cinema_booking/presentation/home/nearby_cinema/bloc/nearby_cinema_bloc.dart';
// import 'package:cinema_booking/presentation/router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class WidgetNearbyCine extends StatefulWidget {
//   const WidgetNearbyCine({super.key});

//   @override
//   State<WidgetNearbyCine> createState() => _WidgetNearbyCineState();
// }

// class _WidgetNearbyCineState extends State<WidgetNearbyCine> {
//   List<CinemaEntity> cines = [];

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<NearbyCineBloc>(
//       create: (context) => NearbyCineBloc(homeBloc: BlocProvider.of<HomeBloc>(context)),
//       child: BlocBuilder<NearbyCineBloc, NearbyCineState>(
//         builder: (context, state) {
//           if (state is NearbyCineLoaded) {
//             cines.clear();
//             cines.addAll(state.cines);

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child:
//                             Text('Nearby cinemas'.toUpperCase(), style: AppFont.medium_black2_14),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             _openAllCine();
//                           },
//                           child: Text('View all',
//                               style: AppFont.medium_default_10, textAlign: TextAlign.right),
//                         ),
//                       )
//                     ],
//                   ),
//                   WidgetSpacer(height: 14),
//                   _buildGoogleMap()
//                 ],
//               ),
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }

//   _openAllCine() {
//     // TODO:
//   }

//   Completer<GoogleMapController> _controller = Completer();

//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(21.013298, 105.827523),
//     zoom: 14.4746,
//   );

//   _buildGoogleMap() {
//     return Container(
//       height: 168,
//       child: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         markers: Set<Marker>.of(markers.values),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);

//           LatLng southwest = LatLng(20.994607, 105.786714);
//           LatLng northeast = LatLng(21.047550, 105.840251);

//           Future.delayed(Duration(seconds: 1), () {
//             controller.animateCamera(
//               CameraUpdate.newLatLngBounds(
//                   LatLngBounds(southwest: southwest, northeast: northeast), 0),
//             );
//           });

//           _createMarker(context);
//         },
//       ),
//     );
//   }

//   Future<void> _createMarker(BuildContext context) async {
//     final icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(4, 4)), 'assets/ic_nearby_theatre.png');

//     markers.clear();
//     cines.forEach((cine) {
//       final markerIdVal = cine.id;
//       final latLng = LatLng(cine.lat, cine.lng);

//       final MarkerId markerId = MarkerId(markerIdVal);

//       final Marker marker = Marker(
//         markerId: markerId,
//         icon: icon,
//         position: latLng,
//         infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
//         onTap: () {},
//       );

//       markers[markerId] = marker;
//     });

//     setState(() {
//       markers.length;
//     });
//   }
// }
