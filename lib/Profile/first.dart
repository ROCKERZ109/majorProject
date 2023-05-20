import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import '../NoInternet/app_scaffold.dart';
import '../Screens/first.dart';
import '../Screens/passenger.dart';
import '../Screens/passengertripscreen.dart';
import '../Screens/pilot.dart';
import '../Screens/pilotripscreen.dart';
import '../Service/network_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../sizeConfig.dart';
import 'package:flutter/material.dart';
import 'profile_second.dart';

var fetched_name = 'Abc...';
var fetched_phone = 1234567890;
var fetched_email = "abc@gmail.com";
var fetched_gender = "male/female";
var fetched_image =
    "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=170667a&w=0&k=20&c=EpwfsVjTx8cqJJZzBMp__1qJ_7qSfsMoWRGnVGuS8Ew=";
var fetched_total_rides = 0;
var fetched_ride_as_pilot = 0;
var fetched_ride_as_passenger = 0;

class firstpage extends StatefulWidget {
  static var id = "FirstPage";
  const firstpage({
    super.key,
  });

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  void get_data(var phone) async {
    var response = await http
        .get(Uri.parse('http://209.38.239.47/users/user?phone=$phone'));
    // var data = response.statusCode;
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      setState(() {
        fetched_name = data[0]["name"];
        fetched_phone = data[0]["phone"];
        fetched_email = data[0]["email"];
        fetched_gender = data[0]["gender"];
        fetched_image = data[0]["image"];
        fetched_total_rides = data[0]["total"];
        fetched_ride_as_pilot = data[0]["pilot"];
        fetched_ride_as_passenger = data[0]["passenger"];
      });
    }
    print(data);
    print("\n\n");
  }

  // void method_fetching_for_total_rides(var phone)async
  // {
  //   var response_total_rides = await http.get(Uri.parse('http://209.38.239.47/users/getTotalRides?phone=$phone'));
  //   // var data = response.statusCode;
  //   var data_total;
  //   if(response_total_rides.statusCode==200)
  //   {
  //     data_total= jsonDecode(response_total_rides.body);
  //     setState(() {
  //       fetched_total_rides= data_total[0]["total"];
  //     });
  //   }
  //   print(data_total);
  // }
  // void method_fetching_for_rides_as_pilot(var phone)async
  // {
  //   var response_pilot_rides = await http.get(Uri.parse('http://209.38.239.47/users/getPilotRides?phone=$phone'));
  //   // var data = response.statusCode;
  //   var data_pilot;
  //   if(response_pilot_rides.statusCode==200)
  //   {
  //     data_pilot= jsonDecode(response_pilot_rides.body);
  //     setState(() {
  //       fetched_ride_as_pilot= data_pilot[0]["pilot"];
  //     });
  //   }
  //   print(data_pilot);
  // }
  // void method_fetching_for_rides_as_passenger(var phone)async
  // {
  //   var response_passenger_rides = await http.get(Uri.parse('http://209.38.239.47/users/getPassengerRides?phone=$phone'));
  //   // var data = response.statusCode;
  //   var data_passenger;
  //   if(response_passenger_rides.statusCode==200)
  //   {
  //     data_passenger= jsonDecode(response_passenger_rides.body);
  //     setState(() {
  //       fetched_ride_as_passenger= data_passenger[0]["passenger"];
  //     });
  //   }
  //   print(data_passenger);
  // }
  @override
  void initState() {
    // TODO: implement initState
    get_data(HelperVariables.Phone);
    // method_fetching_for_total_rides(7452976914);
    // method_fetching_for_rides_as_pilot(7452976914);
    // method_fetching_for_rides_as_passenger(7452976914);
    setState(() {
      polyCheck = false;
      destWidgetCheck = false;
      distance = 0;
      showOTPs = false;
      rideStarted = false;
      showOTP = false;
      polylineCoordinate = [];
      wayPointVal = const LatLng(0.0, 0.0);
      HelperVariables.passengercurrentLocation = LocationData.fromMap({"": ""});
      HelperVariables.pilotcurrentLocation = LocationData.fromMap({"": ""});
      //It could be a problem here
      HelperVariables.otherPhone = 0;
      HelperVariables.passengerDest = '';
    });
    super.initState();
  }

  var ctime;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.offline) {
      return noInternetScaff();
    } else {
      return WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
            //add duration of press gap
            ctime = now;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Press Back Button Again to Exit')));
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 230, 230, 230),
            foregroundColor: Colors.black,
            automaticallyImplyLeading: false,
            toolbarHeight: 150,
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 30,
                    ),
                    child: CircleAvatar(
                        radius: SizeConfig.safeBlockHorizontal * 11.75,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        child: Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TwoWidget()),
                              );
                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(fetched_image ==
                                      "https://imagenauft.fra1.digitaloceanspaces.com/"
                                  ? "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=170667a&w=0&k=20&c=EpwfsVjTx8cqJJZzBMp__1qJ_7qSfsMoWRGnVGuS8Ew="
                                  : fetched_image),
                              radius: SizeConfig.safeBlockHorizontal * 11.5,
                            ),
                            iconSize: SizeConfig.safeBlockVertical * 10.75,
                          );
                        })),
                  ),
                ],
              ),
            ],
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      // width:SizeConfig.safeBlockHorizontal*12,
                      height: SizeConfig.safeBlockVertical * 5.75,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  const Text(
                    "haratRide",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans',
                        fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          body: SizedBox(
            height: SizeConfig.safeBlockVertical * 90,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(70), topLeft: Radius.circular(70)),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          // top: SizeConfig.safeBlockVertical * 1,
                          // bottom: SizeConfig.safeBlockVertical *0,
                          left: SizeConfig.safeBlockHorizontal * 10,
                          right: SizeConfig.safeBlockHorizontal * 10,
                        ),
                        child: SizedBox(
                          // color: Colors.grey,
                          height: SizeConfig.safeBlockVertical * 17,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: const Color.fromARGB(255, 230, 230, 230),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.safeBlockVertical * 2,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2,
                                        ),
                                        child: const Text(
                                          "Ride With Mates",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical * 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          // top: SizeConfig.blockSizeVertical
                                          left: SizeConfig.safeBlockHorizontal *
                                              4,
                                        ),
                                        child: const Text(
                                          "For Graphians!",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 17),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    4),
                                        child: const Text(
                                          "By Graphians!",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: SizeConfig.safeBlockHorizontal * 2,
                                      top: SizeConfig.safeBlockVertical * 2,
                                      bottom: SizeConfig.safeBlockVertical * 2,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius:
                                          SizeConfig.safeBlockHorizontal * 14,
                                      backgroundImage:
                                          const AssetImage('assets/geul2.png'),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Container(
                        height: SizeConfig.safeBlockVertical * 20,
                        //
                        // child: Center(
                        //   child: Image.asset('assets/geul.png',
                        //   height:SizeConfig.safeBlockVertical * 22 ,
                        //     width: SizeConfig.safeBlockHorizontal*55,
                        //   ),
                        // ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 6),
                        height: SizeConfig.safeBlockVertical * 4,
                        child: const Text(
                          'Select your role below',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Nunito Sans',
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        // /   margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical*4),
                        width: SizeConfig.safeBlockHorizontal * 60,
                        height: SizeConfig.safeBlockVertical * 6,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => FirstScreen(
                                        screenName: PilotScreen.id)),
                                (Route<dynamic> route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.black,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text(
                            "Pilot",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito Sans',
                                fontSize: 21),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 6,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 60,
                        height: SizeConfig.safeBlockVertical * 6,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => FirstScreen(
                                        screenName: PassengerScreen.id)),
                                (Route<dynamic> route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.black,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text(
                            "Passenger",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NunitoSans',
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    }
  }
}
