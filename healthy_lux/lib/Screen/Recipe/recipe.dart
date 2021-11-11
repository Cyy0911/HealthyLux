import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/appbar.dart';
import 'package:healthy_lux/Components/bottom_navigation_bar.dart';
import 'package:healthy_lux/Model/pdf_api.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:screenshot/screenshot.dart';

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  CollectionReference ref = FirebaseFirestore.instance.collection("recipe");

  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BuildBottomNavigationBar(),
      backgroundColor: AppTheme.whiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BuildAppBar(
          title: 'Recipe',
          backButton: true,
        ),
      ),
      body: recipeBody(),
    );
  }

  Widget recipeBody() {
    return StreamBuilder(
      stream: ref.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
            itemBuilder: (_, index) {
              var doc = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => Screenshot(
                            controller: _screenshotController,
                            child: Dialog(
                              backgroundColor: AppTheme.grey300Color,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: ListView(children: <Widget>[
                                  Image.network(
                                    doc['imageUrl'],
                                    fit: BoxFit.fill,
                                    height: 300,
                                    width: 300,
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(snapshot.data!.docs[index]['name'],
                                      style:
                                          AppTheme.defaultTextStyle20Black(true)
                                              .copyWith(
                                                  color: AppTheme.brownColor)),
                                  const SizedBox(height: 17.0),
                                  Text(snapshot.data!.docs[index]['calories'],
                                      style: AppTheme.defaultTextStyle17Black(
                                          true)),
                                  const SizedBox(height: 16.0),
                                  Text('Ingredients:',
                                      style: AppTheme.defaultTextStyle18Black(
                                          true)),
                                  Text(snapshot.data!.docs[index]['ingredient'],
                                      style: AppTheme.defaultTextStyle16Black(
                                          true)),
                                  const SizedBox(height: 17.0),
                                  Text('Instructions:',
                                      style: AppTheme.defaultTextStyle18Black(
                                          true)),
                                  Text(
                                      snapshot.data!.docs[index]['instruction'],
                                      style: AppTheme.defaultTextStyle16Black(
                                          true)),
                                  const SizedBox(height: 20.0),
                                  TextButton(
                                      onPressed: () async {
                                        final pdfFile = await PdfApi.generate(
                                            snapshot.data!.docs[index]['name'],
                                            snapshot.data!.docs[index]
                                                ['calories'],
                                            snapshot.data!.docs[index]
                                                ['ingredient'],
                                            snapshot.data!.docs[index]
                                                ['instruction'],
                                            doc['imageUrl']);

                                        PdfApi.openFile(pdfFile);
                                      },
                                      child: Text(
                                        "Print",
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ))
                                ]),
                              ),
                            ),
                          ));
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 150,
                  color: Colors.black12,
                  child: Center(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.network(
                              snapshot.data!.docs[index]['imageUrl'],
                              fit: BoxFit.cover,
                              height: 120,
                              width: 100,
                            ),
                            Text(
                              snapshot.data!.docs[index]['name'],
                              textAlign: TextAlign.center,
                              style: AppTheme.defaultTextStyle15Black(true)
                                  .copyWith(color: AppTheme.brownColor),
                            ),
                            Text(
                              snapshot.data!.docs[index]['calories'],
                              textAlign: TextAlign.center,
                              style: AppTheme.defaultTextStyle15redAccent(true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
