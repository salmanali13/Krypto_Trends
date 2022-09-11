//-----------------------------------------------------------
// This screen shows the favourite list items
// With the ability to unfavourite each item by sliding left
//-----------------------------------------------------------

//External Imports----------------------------------------
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Internal Imports----------------------------------------
import '../main.dart';
import '../models/favourite_model.dart';
import '../widget/favouriteItemList.dart';
import '../widget/app_drawer.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite-screen';
  DateTime lastPressed = DateTime.now();

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List favouriteCurruncies;
  @override
  void initState() {
    favouriteCurruncies =
        Provider.of<Favourites>(context, listen: false).favourites;
    print('THis is Favourite screens initstate');
    super.initState();
  }

  @override
  void dispose() {
    ScaffoldMessenger.of(context).dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(favouriteCurruncies);
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(widget.lastPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        widget.lastPressed = DateTime.now();
        if (isExitWarning) {
          // final snackBar = Text("");
          Fluttertoast.showToast(msg: "Tap Again to Exit");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(FontAwesomeIcons.alignLeft))),
          title: Text('Favorites'),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: favouriteCurruncies.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.starHalfAlt,
                      size: 100,
                      color: Colors.white54,
                    ),
                    Container(
                      height: 20,
                    ),
                    Text(
                      "No Favourites",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    ),
                  ],
                ),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        alignment: Alignment.topCenter,
                        height: upperNotification &&
                                favouriteCurruncies.length != null
                            ? 60
                            : 0,
                        width: MediaQuery.of(context).size.width,
                        duration: Duration(milliseconds: 300),
                        child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                upperNotification = !upperNotification;
                                favouriteCurruncies = Provider.of<Favourites>(
                                        context,
                                        listen: false)
                                    .favourites;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black38,
                            ),
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 10,
                            ),
                            label: Text("Slide to Un-Favourite",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))),
                      ),
                      ListView.builder(
                        itemBuilder: (_, i) => Dismissible(
                          direction: DismissDirection.endToStart,
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            Provider.of<Favourites>(context, listen: false)
                                .toggleFavouriteStatus(
                                    favouriteCurruncies[i].id,
                                    favouriteCurruncies[i].price);

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.black54,
                                action: SnackBarAction(
                                  label: "Undo",
                                  textColor: Colors.amber,
                                  onPressed: () {
                                    setState(() {
                                      Provider.of<Favourites>(context,
                                              listen: false)
                                          .toggleFavouriteStatus(
                                              favouriteCurruncies[i].id,
                                              favouriteCurruncies[i].price);
                                      favouriteCurruncies =
                                          Provider.of<Favourites>(context,
                                                  listen: false)
                                              .favourites;
                                    });
                                  },
                                ),
                                content: Text(
                                  '${favouriteCurruncies[i].id} is Unfavourited',
                                  style: TextStyle(fontSize: 16),
                                )));
                          },
                          secondaryBackground: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            margin: EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 8,
                            ),
                            color: Colors.red,
                            elevation: 3,
                            child: ListTile(
                                trailing: Icon(
                              Icons.delete_forever_rounded,
                              size: 33,
                              color: Colors.white,
                            )),
                          ),
                          background: Container(),
                          child: FavouriteListItem(
                            favouriteCurruncies[i].id,
                            favouriteCurruncies[i].isFavourite,
                            favouriteCurruncies[i].id,
                          ),
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: favouriteCurruncies.length,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
