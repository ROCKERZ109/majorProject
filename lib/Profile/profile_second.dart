import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/Screens/splashscreen.dart';

import 'first.dart';
import '../sizeConfig.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'safety_page.dart';
import 'report_an_issue_page.dart';
import 'package:http/http.dart'as http;

class TwoWidget extends StatefulWidget {
   const TwoWidget({
    super.key,
  });

  @override
  State<TwoWidget> createState() => _TwoWidgetState();
}

class _TwoWidgetState extends State<TwoWidget> {
var phone;

var counter=false;

void get_data(context) async{
  var response = await http.get(Uri.parse('http://209.38.239.47/users/updateToken?phone=${HelperVariables.Phone}&token=null'));
  if(response.statusCode==200)
    {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=>const SplashScreen()), (route) => false);
    }
}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          leadingWidth: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0,
              ),
              child: CircleAvatar(
                radius: SizeConfig.safeBlockHorizontal*11.75,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> const profile_page()),
                        );


                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(fetched_image=="https://imagenauft.fra1.digitaloceanspaces.com/"?"https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=170667a&w=0&k=20&c=EpwfsVjTx8cqJJZzBMp__1qJ_7qSfsMoWRGnVGuS8Ew=":fetched_image),
                        radius:  SizeConfig.safeBlockHorizontal*11.75,
                      ),
                      iconSize: 270,
                    );
                  }
                ),
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              fetched_name,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito Sans',
                  fontSize: 35),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        body: Stack(
          children: [
            Visibility(
              visible: !counter,
              child: SizedBox(
                height: SizeConfig.safeBlockVertical * 90,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: Material(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child:
                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 10,
                            width: SizeConfig.safeBlockVertical * 20,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor:
                                    const Color.fromARGB(255, 230, 230, 230),
                                    splashFactory: NoSplash.splashFactory,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 0)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.feedback_outlined,
                                        size: 40,
                                      ),
                                      Text(
                                        "Feedback",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Nunito Sans',
                                            fontSize: 17),
                                      )
                                    ])),
                          ),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal * 5,
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 10,
                            width: SizeConfig.safeBlockVertical * 20,
                            child: Builder(
                              builder: (context) {
                                return ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>const profile_page(value: 300,)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor:
                                        const Color.fromARGB(255, 230, 230, 230),
                                        splashFactory: NoSplash.splashFactory,
                                        elevation: 0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.motorcycle,
                                            size: 40,
                                          ),
                                          Text(
                                            "Rides",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Nunito Sans',
                                                fontSize: 17),
                                          )
                                        ]));
                              }
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical * 7,
                            horizontal: SizeConfig.safeBlockHorizontal * 9),
                        child:Material(
                          // height: SizeConfig.safeBlockVertical * 17,
                          child: Builder(
                              builder: (context) {
                                return ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> const safety_protocol_page(),)
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        splashFactory: NoSplash.splashFactory,
                                        elevation: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig.safeBlockVertical,
                                                    bottom: SizeConfig.safeBlockVertical),
                                                child: const Text(
                                                  "Safety Protocol",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 25),
                                                ),
                                              ),
                                              Padding(
                                                padding:EdgeInsets.only(

                                                    bottom: SizeConfig.safeBlockVertical),
                                                child: const Text(
                                                  "Adhere to safety guidelines for passengers and pilots during rides",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.warning_amber_outlined,
                                          size: 70,
                                        )
                                      ],
                                    ));
                              }
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 8,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 70,
                        height: SizeConfig.safeBlockVertical * 6,
                        child: Builder(
                            builder: (context) {
                              return ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=> const ReportIssueForm(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 230, 230, 230),
                                  foregroundColor: Colors.black,
                                  splashFactory: NoSplash.splashFactory,
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "Report an issue",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 20),
                                ),
                              );
                            }
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 70,
                        height: SizeConfig.safeBlockVertical * 6,
                        child: ElevatedButton(
                          onPressed: () {
                           setState(() {
                             counter=true;
                               get_data(context);
                           });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito Sans',
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
      Visibility(
        visible: counter,
        child: Center(
          child: SizedBox(
            height: SizeConfig.safeBlockVertical*19,
            width: SizeConfig.safeBlockHorizontal*80,
            child: Card(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  Text("Logging out",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily:"Nunito Sans"
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
          ],
        ));
  }
}
