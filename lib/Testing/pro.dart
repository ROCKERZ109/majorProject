// //
// // import 'package:provider/provider.dart';
// // import 'package:flutter/material.dart';
// //
// // void main() async {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       routes: {
// //         ProviderTest.id: (_) => const ProviderTest(),
// //       },
// //       initialRoute: ProviderTest.id,
// //     );
// //   }
// // }
// //
// // class ProviderTest extends StatefulWidget {
// //   static var id = 'ProviderTest';
// //
// //   const ProviderTest({Key? key}) : super(key: key);
// //
// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _ProviderTestState createState() => _ProviderTestState();
// // }
// //
// // class _ProviderTestState extends State<ProviderTest> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamProvider<MyModel>(
// //         create: (BuildContext context)=>GetModel(),
// //         initialData: MyModel(username:'People'),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           backgroundColor: Colors.lightBlue,
// //           title: const Text('Provider Test'),
// //           centerTitle: true,
// //         ),
// //         body: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Container(
// //               color: Colors.lightBlue,
// //               height: 200,
// //               width: 300,
// //               child: Consumer<MyModel>(
// //                 // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
// //                 builder: (context, MyModel, child) {
// //                   return Center(
// //                     child: Text(
// //                       MyModel.username,
// //                       style: const TextStyle(color: Colors.black, fontSize: 15),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //             Consumer<MyModel>(
// //               // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
// //               builder: (context, MyModel, child) {
// //                 return ElevatedButton(onPressed: (){
// //                   MyModel.doS();
// //                 }, child: const Text('Press me'));
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // // ignore: non_constant_identifier_names
// // Stream<MyModel> GetModel(){
// //
// //   return Stream<MyModel>.periodic(const Duration(seconds: 1),(x)=>MyModel(username:'$x')).take(52);
// // }
// // class MyModel with ChangeNotifier {
// // String username;
// // MyModel({required this.username});
// //
// //  Future<void> doS() async{
// //  await Future.delayed(const Duration(seconds: 2));
// //  username='BharatRide';
// //  }
// // // }
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/Profile/first.dart';
import 'package:veloce/Screens/passenger.dart';

import '../Screens/cross_feedback.dart';
import '../sizeConfig.dart';
import 'package:http/http.dart' as http;

class CrossFeedback extends StatefulWidget {
  static var id = 'ProviderTest';
  final String?role;
  final String?phone;
  final String?destination;
  const CrossFeedback({this.role,this.phone,this.destination}) ;

  @override
  // ignore: library_private_types_in_public_api
  _CrossFeedbackState createState() => _CrossFeedbackState();
}

class _CrossFeedbackState extends State<CrossFeedback> {
  var starRating=0.0;
  var paid='NULL';
  var NoColor=Colors.black;
  var YesColor=Colors.black;
  var experienceRating=0.0;
  TextEditingController _controller = new TextEditingController();
  var customFeedback;
  void updateRide(String api)async{
    var response = await http.get(Uri.parse('http://209.38.239.47/users/$api?phone=${int.parse(HelperVariables.Phone)}'));
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: ()async=>false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: SingleChildScrollView(
            child: AlertDialog(

              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: const Text(
                "How was your latest ride?",
                style: TextStyle(fontFamily: 'Nunito Sans'),
              ),
              titlePadding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 2,
                  left: SizeConfig.safeBlockVertical * 2,
                  bottom: SizeConfig.safeBlockVertical),
              actions: <Widget>[
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical,
                      vertical: SizeConfig.safeBlockVertical),
                  child: const Center(
                    child: Text(
                      "Rate your Co-rider",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.5),
                    ),
                  ),
                ),
                Center(
                    child: SmoothStarRating(
                      size: 35,
                      color: Colors.green,
                      allowHalfRating: true,
                      borderColor: Colors.grey,
                      defaultIconData: Icons.directions_bike,
                      halfFilledIconData: Icons.directions_bike,
                      filledIconData: Icons.directions_bike,
                      spacing: 10,
                      rating: starRating,
                      onRatingChanged: (rating) {
                        starRating = rating;
                        // print(starRating);
                        setState(() {});
                      },
                    )),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Riding experience",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.5),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: RatingBar.builder(
                          glow: false,
                          unratedColor: Colors.grey,

                          initialRating: 3,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                );
                              case 1:
                                return const Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 2:
                                return const Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 3:
                                return const Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 4:
                                return const Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                              default:
                                return const Icon(Icons.close);
                            }
                          },
                          onRatingUpdate: (rating) {
                            experienceRating = rating;
                            // print("Experience Rating is: $experienceRating");
                          },
                        ))),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Visibility(
                  visible:widget.role=='pilot'?true:false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockVertical * 2,
                        vertical: SizeConfig.safeBlockVertical * 2),
                    child: Align(
                      alignment:
                      Alignment(0, SizeConfig.safeBlockVertical * -0.09),
                      child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Did the passenger pay you the amount?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito Sans',
                                    fontSize: 16.5),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                             NoColor)),
                                      onPressed: () {
                                        NoColor=Colors.blue;
                                        YesColor=Colors.black;
                                        paid="No";
                                        setState(() {

                                        });
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Nunito Sans',
                                            fontSize: 14),
                                      )),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              YesColor)),
                                      onPressed: () {
                                        setState(() {
                                           NoColor=Colors.black;
                                           YesColor=Colors.blue;
                                           paid="yes";
                                        });
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Nunito Sans',
                                            fontSize: 14),
                                      )),
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical * 2,
                      vertical: SizeConfig.safeBlockVertical * 2),
                  child: Align(
                    alignment: Alignment(0, SizeConfig.safeBlockVertical * -0.09),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _controller,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Write your feedback...",
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito Sans',
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical * 2,
                      vertical: SizeConfig.safeBlockVertical * 1),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {

                        customFeedback = _controller.text;
                        // print("Star Rating is: $starRating");
                        // print("Experience Rating is: $experienceRating");
                        // print("Custom Feedback is: $customFeedback");
                        CrossFeedbackDialog().postFeedback(other: widget.phone,role: widget.role,phone:int.parse(HelperVariables.Phone),starRating:starRating.toString(),experienceRating: experienceRating.toString(),paid:paid,customFeedback:customFeedback,destination:widget.destination, );
                        Navigator.pushNamedAndRemoveUntil(context, firstpage.id, (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Feedback Submitted"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        widget.role=='pilot'? updateRide('updatePilotRide'):updateRide('updatePassengerRide');
                        updateRide('updateTotalRide');
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     firstpage.id, (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text("Submit"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
// }
// class _ProviderTestState extends State<ProviderTest> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<MyModel>(
//         create: (BuildContext context)=>GetModel(),
//
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.lightBlue,
//           title: const Text('Provider Test'),
//           centerTitle: true,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               color: Colors.lightBlue,
//               height: 200,
//               width: 300,
//               child: Consumer<MyModel>(
//                 // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//                 builder: (context, MyModel, child) {
//                   return Center(
//                     child: Text(
//                       MyModel.username,
//                       style: const TextStyle(color: Colors.black, fontSize: 15),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Consumer<MyModel>(
//               // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//               builder: (context, MyModel, child) {
//                 return ElevatedButton(onPressed: (){
//                   MyModel.doS();
//                 }, child: const Text('Press me'));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore: non_constant_identifier_names
//  GetModel(){
//   return MyModel(username: 'Ride');
// }
// class MyModel with ChangeNotifier {
// String username;
// MyModel({required this.username});
// int a=0;
// void doS() async{
//   a++;
//  username=a.toString();
//  notifyListeners();
//  print(username);
//  }
// }
// // // import 'package:provider/provider.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // //
// // // void main() async {
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       routes: {
// // //         ProviderTest.id: (_) => const ProviderTest(),
// // //       },
// // //       initialRoute: ProviderTest.id,
// // //     );
// // //   }
// // // }
// // //
// // // class ProviderTest extends StatefulWidget {
// // //   static var id = 'ProviderTest';
// // //
// // //   const ProviderTest({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   _ProviderTestState createState() => _ProviderTestState();
// // // }
// // //
// // // class _ProviderTestState extends State<ProviderTest> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return ChangeNotifierProvider(
// // //       create: (BuildContext context) => MyModel(),
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           backgroundColor: Colors.lightBlue,
// // //           title: Text('Provider Test'),
// // //           centerTitle: true,
// // //         ),
// // //         body: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           crossAxisAlignment: CrossAxisAlignment.center,
// // //           children: [
// // //             Container(
// // //               color: Colors.lightBlue,
// // //               height: 200,
// // //               width: 300,
// // //               child: Consumer<MyModel>(
// // //                 builder: (context, MyModel, child) {
// // //                   return Center(
// // //                     child: Text(
// // //                       '${MyModel.a}',
// // //                       style: TextStyle(color: Colors.black, fontSize: 15),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //             Container(
// // //               child: Consumer<MyModel>(
// // //                 builder: (context, MyModel, child) {
// // //                   return ElevatedButton(onPressed: (){
// // //                     MyModel.doS();
// // //                   }, child: Text('Press me'));
// // //                 },
// // //               ),
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class MyModel with ChangeNotifier {
// // //   int a = 1;
// // //
// // //   void doS() {
// // //     a++;
// // //     print(a);
// // //     notifyListeners();
// // //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'websocket_service.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<String>.value(value: WebSocketService().stream, initialData: 'a',),
//       ],
//       child: MaterialApp(
//         title: 'WebSocket Example',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: HomeScreen(),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Go to Second Screen'),
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => SecondScreen()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen'),
//       ),
//       body: Center(
//         child: StreamBuilder<String>(
//           stream: context.watch<Stream<String>>(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }
//             return Text(snapshot.data!);
//           },
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:veloce/Screens/pilot.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'br_verification',
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String _aadhaarCard = "";
//   String _bikeRc = "";
//   String _carRc = "";
//   String _drivingLicence = "";
//
//   final TextEditingController _aadhaarCardController = TextEditingController();
//   final TextEditingController _bikeRcController = TextEditingController();
//   final TextEditingController _carRcController = TextEditingController();
//   final TextEditingController _drivingLicenceController =
//   TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Black Theme UI"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 16.0),
//             Text(
//               "Enter Aadhaar Card Number",
//               style: TextStyle(fontSize: 16.0),
//             ),
//             ElevatedButton(
//                 style: TextButton.styleFrom(
//                   primary: Colors.blue,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PilotScreen()),
//                   );
//
//                 },
//                 child: Text('Tap Here'),
//             ),
//             TextField(
//               controller: _aadhaarCardController,
//               decoration: InputDecoration(
//                 hintText: "Aadhaar Card Number",
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _aadhaarCard = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               "Enter Bike RC Number",
//               style: TextStyle(fontSize: 16.0),
//             ),
//             TextField(
//               controller: _bikeRcController,
//               decoration: InputDecoration(
//                 hintText: "Bike RC Number",
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _bikeRc = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             SizedBox(height: 16.0),
//             Text(
//               "Enter Driving Licence Number",
//               style: TextStyle(fontSize: 16.0),
//             ),
//             TextField(
//               controller: _drivingLicenceController,
//               decoration: InputDecoration(
//                 hintText: "Driving Licence Number",
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _drivingLicence = value;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }
}