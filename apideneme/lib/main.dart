import 'package:apideneme/service/user_service.dart';
import 'package:flutter/material.dart';

import 'model/users_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  List<UsersModelData?> users = [];
  bool? isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Api Example'),
        ),
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading == true
                ? ListView.builder(
                    itemCount: users!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(users[index]!.firstName!),
                        subtitle: Text(users[index]!.email!),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index]!.avatar!),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Bir sorun oluştu.."),
                  ),
      ),
    );
  }
}
