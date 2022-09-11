//-----------------------------------------------------------
// This is the privacy policy screen
//-----------------------------------------------------------

import 'package:flutter/material.dart';

class PrivacyPolicySCreen extends StatelessWidget {
  const PrivacyPolicySCreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(color: Colors.white70),
                text:
                    "This has been written to inform visitors and our users of the core policies of TechRhyme Apps regarding collection, use, and disclosure of Personal Information if in case anyone decides to use our Services.",
              ),
            ),
            SizedBox(height: 20),
            headingBuilder("Our Apps don’t store users’ data"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "Guarding the privacy of our users is our priority. None of our app's store or misuse any kind of data of our users.")),
            SizedBox(height: 20),
            headingBuilder("Ads Support"),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(color: Colors.white70),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "All of the Apps developed by TechRhyme Support Ads. We are aware of the reservations and uncertainties users might have in their minds. We ensure that we only enable the advertisements provided by authenticated channels."),
                  TextSpan(
                      text:
                          "If you use our Service, then you agree to the collection and use of information by Authorized companies as described in this policy. The Personal Information that we get after your approval is used to ensure an improved and reliable Service. We do not use or share your information with anyone except the registered authenticated third parties mentioned in this Privacy Policy."),
                ],
              ),
            ),
            SizedBox(height: 20),
            headingBuilder("Information Collection and Fair Use"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "For a better experience, while using our Service, we may ask you to provide us with certain personally identifiable information as per the basic requirements of our apps. But that is to inform you that this information will be retained on your device and is not collected by us for any misuse or so. Any such information is only used to enable our users to use certain specified features in some of our apps. For example, location access for showing location in maps. And keeping up with the privacy protection principles users can disable that access any time if they wish to.")),
            SizedBox(height: 20),
            headingBuilder("Third Party Apps"),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(color: Colors.white70),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "From time to time, we may also receive personal information about you from other third-party sources. For example, if you clicked on an advertisement, you will be directed to another service and we will be able to collect information about the source of ad network and advertising campaign that generated that click or install."),
                  TextSpan(
                      text:
                          "Though our apps use third party services that may collect information used for authentication still we don’t collect or store any of your private data."),
                  TextSpan(
                      text:
                          "Following are some of the third-party service providers used by our apps."),
                  TextSpan(
                      text: "-Google Play Services",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "-AdMob",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "-Facebook Advertisement manager",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(height: 20),
            headingBuilder("Log Data"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "We want you to know that whenever during use of our Services, in a case of an error in the app we collect data and information (through third party products) on your device, named “Log Data”. This data is compiled and utilized to trace app crashes and bugs. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app while using our Service, the time and date of use of the Service, and other stats regarding this.")),
            SizedBox(height: 20),
            headingBuilder("Usage of Permissions"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "We might ask for some permissions like Camera permission, read/write external storage just for storing data and using it for serving data offline and storing images that you request to save. We will use location just to serve content better and will not misuse or store it. Some of our apps also need an active internet connection.")),
            SizedBox(height: 20),
            headingBuilder("Cookies"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "Though our Services do not use “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve the user experience by boosting up the data recovery. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some features of our provided Services.")),
            SizedBox(height: 20),
            headingBuilder("Security"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "You can trust us with your provided Information as we strive to use commercially acceptable means of protecting it from any misuse. Safety, security, and integrity of our users’ data are an integral part of our Vision. We do assure to take every possible measure and step to ensure the avoidance of security breach.")),
            SizedBox(height: 20),
            headingBuilder("Changes to This Privacy Policy"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "We keep updating our Privacy Policy periodically. And that is why, you are advised to review this page often so to keep up with the updated rules and policies. These changes are effective immediately after they are posted on this page. However, we do notify our users about any new big changes and updates to our policy. ")),
            SizedBox(height: 20),
            headingBuilder("Contact Us"),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    text:
                        "If you have any query or suggestions regarding our Privacy Policy or any have objection, do not hesitate to contact us through mail at techrhyme.apps@gmail.com")),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }

//-----------------------------------------------------------
//-----------------------------------------------------------
//This is the headings builder
//-----------------------------------------------------------
  Text headingBuilder(String heading) {
    return Text(
      "$heading",
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
