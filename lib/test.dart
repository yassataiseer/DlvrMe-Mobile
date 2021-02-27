import 'package:http/http.dart' as http;

// Sending a GET request
void test(){
  Future<List<dynamic>> fetchUsers() async {
    var url = 'http://127.0.0.1:5000/Yassa Taiseer/yassa123';
    var response = await http.get(url);
    print(response);
  }

}