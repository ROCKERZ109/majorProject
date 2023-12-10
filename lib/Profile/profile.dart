import 'package:flutter/material.dart';
import 'first.dart';
import '../sizeConfig.dart';
import 'profile_second.dart';

class profile_page extends StatefulWidget {
  final double? value;
  const profile_page({super.key, this.value});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollControler.animateTo(widget.value!,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
      //code will run when widget rendering complete
    });
    super.initState();
  }

  final ScrollController _scrollControler = ScrollController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SizedBox(
          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 18,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 10,
                        ),
                        // child: Padding(
                        //   padding: EdgeInsets.only(
                        //     top: SizeConfig.blockSizeVertical *2
                        //   ),
                        child: Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                SlideRightPageRoute(
                                  page: const TwoWidget(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 35,
                            ),
                          );
                        }),
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 10,
                          left: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        child: const Text(
                          "Account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Nunito Sans',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(
                      255, 230, 230, 230), // Customize the color of the line
                  thickness: 5.0, // Adjust the thickness of the line
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 4,
                    left: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  child: const Text(
                    "Account Info",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans',
                        fontSize: 40),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    left: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  child: Material(
                    elevation: 10,
                    color: Colors.grey[300],
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      radius: SizeConfig.safeBlockHorizontal * 15,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(fetched_image ==
                              "https://image-db.sfo3.digitaloceanspaces.com/"
                          ? "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=170667a&w=0&k=20&c=EpwfsVjTx8cqJJZzBMp__1qJ_7qSfsMoWRGnVGuS8Ew="
                          : fetched_image),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 6,
                    left: SizeConfig.blockSizeHorizontal *
                        2, // Adjust the left padding to 0
                  ),
                  child: const Text(
                    "Basic Info",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito Sans',
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView(
                  controller: _scrollControler,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Name",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1,
                        left: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      child: Text(
                        fetched_name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Phone Number",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1,
                        left: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      child: Text(
                        "$fetched_phone",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Email",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 1,
                        left: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      child: Text(
                        fetched_email,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Gender",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.safeBlockHorizontal),
                      child: Text(
                        fetched_gender,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Total Ride",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.safeBlockHorizontal),
                      child: Text(
                        "$fetched_total_rides",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Ride As Pilot",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.safeBlockHorizontal),
                      child: Text(
                        "$fetched_ride_as_pilot",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: const Text(
                        "Ride As Passenger",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.safeBlockHorizontal),
                      child: Text(
                        "$fetched_ride_as_passenger",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito Sans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 230, 230,
                          230), // Customize the color of the line
                      thickness: 1.0, // Adjust the thickness of the line
                    ),
                  ],
                )),
              ],
            ),
          )),
    );
  }
}

class SlideRightPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideRightPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(-1.0, 0.0);
            var end = Offset.zero;

            var slideAnimation = Tween<Offset>(
              begin: begin,
              end: end,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Adjust the curve if desired
              ),
            );

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
}
