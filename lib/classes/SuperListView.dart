import 'package:flutter/material.dart';

class SuperListView {
  List items = [];
  int page = 0;
  late Function itemGenerator;
  ScrollController scrollController = ScrollController();

  Function? setState;

  Future<void> loadListViewItems(int page) async {
    this.page = page;
    await setState!(page);
  }

  Widget build(BuildContext context,List listGetter,Function itemGenerator, Function(int page) setState) {
    if(page==0) {
      items=[];
    }
    items += listGetter;
    this.itemGenerator = itemGenerator;
    this.setState = setState;
    //with this variable we can handle if user did scroll many times at end of ListView we have just 1 request to DataGetter
    bool loaded = false;
    //add a listener to detect user scroll
    scrollController.addListener(() async {
      double maxScroll = scrollController.position.maxScrollExtent;
      double current = scrollController.position.pixels;
      //its mean user is end of listView
      if (maxScroll - current <= 300 && loaded == false) {
        loaded = true;
        await loadListViewItems(page + 1);
      } else if (maxScroll - current > 300) {
        //if user scrolled top and he was out of point of load new data it will change and let him with new scroll have new request ones.
        loaded = false;
      }
    });
    return RefreshIndicator(
        child: ListView.builder(
          controller: scrollController,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return itemGenerator(context, items[index], index);
          },
        ),
        onRefresh: () {
          return loadListViewItems(0);
        });
  }
}
