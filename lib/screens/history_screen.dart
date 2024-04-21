import 'package:flutter/material.dart';
import 'package:doggie_shop/utilities/local_storage_service.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> history = LocalStorageService.getDogHistory();
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Image.network(
              history[index],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
