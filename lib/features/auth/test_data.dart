import 'package:flutter/material.dart';
import 'package:savebite0/services/api_service.dart';

class TestDataPage extends StatefulWidget {
  const TestDataPage({super.key});

  @override 
  State<TestDataPage> createState() => _TestDataPageState();
}

class _TestDataPageState extends State<TestDataPage> {
  String _result = 'Loading..';

  @override
  void initState (){
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final profil = await ApiService.getMyProfile();
    setState(() {
      _result = 
      '''
      data : ${profil["data"]}
      username : ${profil["data"]?["username"]}
      ''';
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Test data aja wi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(_result),
      ),
    );
  }
}