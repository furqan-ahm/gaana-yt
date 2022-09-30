import 'package:flutter/cupertino.dart';
import 'package:gaana/constants.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchController extends GetxController{

  Rx<VideoSearchList?> _result=Rx<VideoSearchList?>(null);

  TextEditingController searchTextController = TextEditingController();

  final RxBool _loading=true.obs;

  bool get loading => _loading.value;
  VideoSearchList get results => _result.value!;

  search(String query) async{
   _loading.value=true;
   _result.value = await yt.search(query);
    _loading.value=false;
  }


  @override
  void onInit() {
    search('Music');
    super.onInit();
  }

}