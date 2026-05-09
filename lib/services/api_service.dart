import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "https://wakeful-unjocose-lida.ngrok-free.dev";
  
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

  // Simpan token after lock in coy
  static String? _accessToken;

  static void setAccessToken(String token) {
    _accessToken = token;
  } 

  // Get Profile
  static Future<Map<String?, dynamic>>getMyProfile() async{
    if(_accessToken==null) {
      return{"Success":false, "message": "Belum Login"};
    }

    final response=await http.get(
      Uri.parse("$baseUrl/users/me"),
      headers: {
        "Authorization" : "Bearer $_accessToken",
        "ngrok-skip-browser-warning" : "true",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {"Success": true, "data": data};
    }else{
      return {"Success" : false, "message": data["detail"] ?? "Gagal mengambil profil"};
    }
  }
}