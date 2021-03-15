import 'package:http/http.dart' as http;

// Sending a GET request
void test(){
  Future<List<dynamic>> fetchUsers() async {
    var url = 'http://127.0.0.1:5000/Yassa Taiseer/yassa123';
    var response = await http.get(url);
    print(response);
  }

}
return new FlutterMap(

options: MapOptions(
zoom: 30.0,
),
children: snapshot.data
    .map((user) =>
FlutterMap(
options: MapOptions(
zoom: 13.0,
),

layers: [
TileLayerOptions(
urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
subdomains: ['a', 'b', 'c']

),
MarkerLayerOptions(

markers: [
Marker(
width: 80.0,
height: 80.0,
point: LatLng(user.latitude,user.longitude),
builder: (context) =>
IconButton(
icon: Icon(Icons.location_on),
color: Colors.redAccent,
iconSize: 45,
onPressed: () {
showDialog(
context: context,
builder: (_){
return AlertDialog(title: Text
("Address is:"+user.address+"\n"+"The item is: "+user.item+"\n"+"Price: \$"+user.price.toString()+"\n"+"Product info: "+user.description,),);
},
);
},
),
),
],
),
],
)