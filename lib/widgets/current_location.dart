import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  final String _currentAddress;

  CurrentLocation(this._currentAddress);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(_currentAddress)),
    );
  }
}
