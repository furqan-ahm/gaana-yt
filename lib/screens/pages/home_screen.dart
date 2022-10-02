import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/searchController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:gaana/player.dart';
import 'package:gaana/widgets/songTile.dart';
import 'package:get/get.dart';


class HomeScreen extends GetView<SearchController> {
const HomeScreen({ Key? key }) : super(key: key);


@override
  // TODO: implement controller
  SearchController get controller => Get.put(SearchController());

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Gaana ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text('YT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      controller: controller.searchTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Lookin for something specific?'
                      ),
                      onSubmitted: (val){
                        if(val.isNotEmpty)controller.search(val);
                      },
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.search),
                  onPressed: (){
                    if(controller.searchTextController.text.isNotEmpty)controller.search(controller.searchTextController.text);
                  }
                )
              ],
            ),
            SizedBox(height: 20,),
            Obx(
              () {
                return controller.loading?
                Center(child: CircularProgressIndicator(color: primaryColor,))
                :ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.results.length,
                      itemBuilder: (context, index)=>SongTile(song: Song.fromVideo(controller.results[index]))
                    );
              }
            ),
          ],
        ),
      ),
    );
  }
}