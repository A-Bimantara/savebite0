import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "https://2133-59-153-129-31.ngrok-free.app";
  
// Register section
  static Future<Map<String, dynamic>> register({
    required String email,
    required String username,
    required String password,
  }) 
  async{
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {
        "Content-Type" : "application/json",
        "ngrok-skip-browser-warning": "true",
      },
      body: jsonEncode({
        "email": email,
        "username" : username,
        "password" : password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201){
      return {"Success": true, "data": data};
    } else {
      return {"Success": false, "message": data["detail"]};
    }
  }

// Login Section
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) 
  async{
    try {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type" : "application/json",
        "ngrok-skip-browser-warning": "true",
      },
      body: jsonEncode({
        "email": email,
        "password" : password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200){
      return {"Success": true, "data": data};
    } else {
      return {"Success": false, "message": data["message"] ?? "Login gagal, silahkan coba lagi!"};
    } 
  } catch (e) {
    return {"Success": false, "data": "Terjadi Kesalahan: $e"};
  }
  }
}