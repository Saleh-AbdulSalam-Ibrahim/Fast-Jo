import 'dart:async';
import 'dart:math';
import 'package:fast_jo_u/components/Divider.dart';
import 'package:fast_jo_u/methods/assistantMethods.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_jo_u/components/Divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MainScreen extends StatefulWidget {
  static const String idScreen='mainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}
displayToastMsg(String msg, BuildContext context)
{
  Fluttertoast.showToast(msg: msg);
}


class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GlobalKey<ScaffoldState> scaffoldKey= GlobalKey<ScaffoldState>();
  late GoogleMapController newGoogleMapController;
  late Position currentPosition;

  var geoLocator=Geolocator();
  double bottomPaddingOfMap=0;

  Future<void> locatePosition()
  async {

    if ( !(await Permission.location.request().isGranted)) {
      // Either the permission was already granted before or the user just granted it.
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      print(statuses[Permission.location]);
    }else{

      Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //currentPosition=position;//it is incorrect

      // print('position: $position \n current position: $currentPosition ');

      //LatLng latLngPosition= LatLng(currentPosition.altitude, currentPosition.longitude);
      CameraPosition cameraPosition= CameraPosition(target: LatLng(position.latitude,position.longitude)
          ,zoom: 17.4746);
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      String address=await AssistantMethods.searchCoordinateAddress(position);
      print('this is the Address : $address');
    }}

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(32.5644066,35.8779895 ),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 170.0,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset('images/user_icon.png',height: 65.0,width: 65.0,),
                      const SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Profile Name',style: TextStyle(fontSize: 16.0,fontFamily: 'bolt-semibold'),
                          ),
                          SizedBox(height: 6.0,),
                          Text('Visit Profile'),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(height: 12.0,),
              ///////use components folder to simplify codes
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History',style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile',style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About',style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Transform.rotate(
                  angle: 180 * pi / 180,
                  child: Icon(Icons.logout),),
                title: Text('Logout',style: TextStyle(fontSize: 15.0),),
              ),
              //////look to another apps
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController mapController) {
              newGoogleMapController=mapController;
              _controllerGoogleMap.complete(mapController);
              newGoogleMapController=mapController;
              setState(() {
                bottomPaddingOfMap=280.0;
              });
              locatePosition();
            },
          ),
          ////HamburgerButton for Drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: (){
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu_rounded,color: Colors.blueAccent,),
                  radius: 25.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,//distance from frame of screen
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 280.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 18.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  )
                ],

              ),
              child: Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    SizedBox(height: 6.0,),
                    Text('Hi there,',style: TextStyle(fontSize: 12.0),),
                    Text('Where to?',style: TextStyle(fontSize: 20.0,fontFamily: 'bolt-semibold'),),
                    SizedBox(height: 20.0,),
                    Container(
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent,
                            blurRadius: 8.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7,0.7),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.search,color: Colors.blueAccent,),
                            SizedBox(height: 10.0,),
                            Text('Search Drop Off'),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.0,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.home,color: Colors.grey,),
                        ),
                        SizedBox(height: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Home'),
                            SizedBox(height: 4.0,),
                            Text('Your living home address', style: TextStyle(color: Colors.black54,
                                fontSize: 12.0),),

                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    DividerWidget(),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.work,color: Colors.grey,),
                        ),
                        SizedBox(height: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Work'),
                            SizedBox(height: 4.0,),
                            Text('Your Office address', style: TextStyle(color: Colors.black54,
                                fontSize: 12.0),),

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
