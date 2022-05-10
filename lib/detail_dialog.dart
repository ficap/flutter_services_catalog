import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/entities/provider_model.dart';

class DetailDialog extends StatelessWidget {
  final ProviderModel provider;
  final String userName = "Test Name";
  final String userSpeciality = "test speciality";
  final String userAbout = "I install and repair pipes that supply water and gas to, as well as carry waste away from, homes and businesses. I also install plumbing fixtures such as bathtubs, sinks, and toilets, and appliances, including dishwashers and washing machines.";
  final String showMore = "Show more";
  final String userPicture = "http://www.beaufox.com.au/wp-content/uploads/2015/10/team-4.jpg?9535a7";

  const DetailDialog({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Dialog(
      // backgroundColor: Colors.white,
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     // Text(provider.name),
      //     Text(provider.serviceType),
      //     Text(provider.address),
      //     Text(provider.phone)
      //   ],
      // ),
    // );

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(  // Bottom rectangular box
          margin: EdgeInsets.only(top: 40), // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(top: 60, left: 20, right: 20), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                userName,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                userSpeciality,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                userAbout,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              ButtonBar(
                buttonMinWidth: 100,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(showMore),
                    onPressed: () => {},
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar( // Top Circle with icon
          maxRadius: 40.0,
          child: buildImage(),
        ),
      ],
    );
  }

  Widget buildImage() {
    final image = Image.network(userPicture);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image.image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}