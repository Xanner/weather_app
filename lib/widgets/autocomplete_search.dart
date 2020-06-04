import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:weather_app/models/cities.dart';

class AutoComplete extends StatefulWidget {
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;
  bool _isFocused = false;

  TextEditingController controller = new TextEditingController();

  _AutoCompleteState();

  void _loadData() async {
    await Cities.loadCities();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              searchTextField = AutoCompleteTextField<City>(
                style: new TextStyle(color: Colors.white, fontSize: 22.0),
                decoration: new InputDecoration(
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  icon: IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  filled: true,
                  hintText: 'Twoja lokalizacja',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                itemSubmitted: (item) {
                  setState(() =>
                      searchTextField.textField.controller.text = item.name);
                },
                clearOnSubmit: false,
                key: key,
                suggestions: Cities.cities,
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.name,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                      ),
                      Text(
                        item.country,
                      )
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.name.compareTo(b.name);
                },
                itemFilter: (item, query) {
                  return item.name
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
