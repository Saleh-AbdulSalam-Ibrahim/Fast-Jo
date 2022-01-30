import 'package:geolocator/geolocator.dart';
import 'configMaps.dart';
import 'requestAssistant.dart';

class AssistantMethods
{

  static Future<String> searchCoordinateAddress(Position position)async
  {
    String placeAddress='';
    String url='https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    var response= await RequestAssistant.getRequest(url);

    if(response != 'failed')
    {
    placeAddress=response['results'][0]['formatted_address'];
    /*
    https://developers.google.com/maps/documentation/geocoding/start

    "results" : [
      {
       "formatted_address" : "279 Bedford Ave, Brooklyn, NY 11211, USA",
       "geometry" : {
            "location" : {
               "lat" : 40.7142484,
               "lng" : -73.9614103
            },
            }
            "geometry" : {
            "location" : {
               "lat" : 40.7142484,
               "lng" : -73.9614103
            },
            ],
   "status" : "OK"
}
     */
    }
    else
      {
        placeAddress='failed!! the Address is Unknown';
        print(placeAddress);
      }
    return placeAddress;
  }
}