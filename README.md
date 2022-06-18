# SUPER LIST VIEW
With this Package you can have a dynamic super ListView Widget allows to you:
1. less code to create ListView
2. scroll to load Items
3. refresh and reUpdate ListViewItems with pulling top
## Installation
Run following command at terminal:
```
dart pub add super_list_view
```
or add this line to ```pubspec.yaml```
```
dependencies:
  super_list_view: ^0.0.1
```
than
```
flutter get pub
```
## usage
let's know what we need to build this widget:

1. ```listViewItems``` : a variable every time update with ```setState()``` It will stack to previous Data in ```ListViewItems``` so you should not add new data to previous data as follow. simple:if you wans show new items, just put new item in this variable with ```setState```.

2. ```getListViewItems``` : a Function what load data and change ```listViewItems``` with ```setState()```. it has just has one param ```page```
3. ```page``` : what is page? its a value say to you, what you have to load from your api or etc.

4. SuperListView().build(): it has 3 params and rerutns your ```SuperListView```.

   a. ```context``` is your BuildContext for your View

   b.```listViewItems```:your new items for your superListView

   c.```item builder```: its a function has 3 params and returns a Widget which is your View per your items. we can see this function prams:
    1. ```context```: no need to explane:)

   2. ```item```: its your item for this index of your ```listViewItems```.

     3. ```index```: your item counter

    d. ```set```: a callBackFunction runs when ```superListView``` want new data. you can handle that just with a Function and its pareter is ```page``` what you can pass to ```getListViewItems``` function to load new data
```

import 'package:flutter/material.dart';
import 'package:flutter/SuperListView.dart';
.
.
.
class ThisState extends State {
  List listViewItems = [];

  @override
  void initState() {
    super.initState();
   //get first data from api
    getListViewItems(0);
  }

  getListViewItems(int page) async {
    //this Function update and load ListViewItems from every where you want
    //you have to update ListViewItem Variable here to effect to superListView with setState()
    //Note: you have to just add NewItems to "ListViewItems",because SuperListView stack new data to old data
    List res = Requst.fromSomeWhere();
    setState(() {
      listViewItems = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: SuperListView().build(context,
          listViewItems,
          (BuildContext context, item, index) {
        //with this item you can access to data for this index of ListViewItems
               retrun Text(index.toString()+ '. ' +item['name']);
      }, (int page) {
        //this function runs after ListView needed to load more data, its return page and you have to update "listViewItems" with setData method
        getListViewItems(page);
      }),
    );
  }
}

```

## License
[MIT](https://choosealicense.com/licenses/mit/)