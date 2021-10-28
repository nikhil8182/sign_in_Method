// main.dart file
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
// // initializing the firebase app
//   await Firebase.initializeApp();
//
// // calling of runApp
//   runApp(GoogleSignIn());
// }
//
// class GoogleSignIn extends StatefulWidget {
//   GoogleSignIn({Key key, List<String> scopes}) : super(key: key);
//   @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }
//
// class _GoogleSignInState extends State<GoogleSignIn> {
//   @override
//   Widget build(BuildContext context) {
//     // we return the MaterialApp here ,
//     // MaterialApp contain some basic ui for android ,
//     return MaterialApp(
//       //materialApp title
//       title: 'GEEKS FOR GEEKS',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//
//       // home property contain SignInScreen widget
//       home: SignInScreen(),
//     );
//   }
// }
//
//
//
//
// class SignInScreen extends StatefulWidget {
//   SignInScreen({Key key}) : super(key: key);
//
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.blue,
//               Colors.red,
//             ],
//           ),
//         ),
//         child: Card(
//           margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
//           elevation: 20,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 "GEEKS FOR GEEKS",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: MaterialButton(
//                   color: Colors.teal[100],
//                   elevation: 10,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 30.0,
//                         width: 30.0,
//                         decoration: BoxDecoration(
//                           // image: DecorationImage(
//                           //     image:
//                           //         AssetImage('assets/images/googleimage.png'),
//                           //     fit: BoxFit.cover),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text("Sign In with Google")
//                     ],
//                   ),
//
//                   // by onpressed we call the function signup function
//                   onPressed: () {
//                     signup(context);
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // function to implement the google signin
// // creating firebase instance
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future<void> signup(BuildContext context) async {
//     GoogleSignInAccount googleSignInAccount = await _googleSignIn.;
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken);
//
//       // Getting users credential
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User user = result.user;
//
//       if (result != null) {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => HomePage()));
//       } // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//     }
//   }
// }
//
//
//
//
// // Home page screen
//
//
// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//
//         // on appbar text contaning 'GEEKS FOR GEEKS'
//         title: Text("GEEKS FOR GEEKS"),
//         ),
//
//     // In body text contaning 'Home page ' in center
//     body: Center(child:Text('Home page'),),
//     );
//   }
// }



//
// import 'dart:async';
// import 'dart:convert' show json;
//
// import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
//
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Google Sign In',
//       home: SignInDemo(),
//     ),
//   );
// }
//
// class SignInDemo extends StatefulWidget {
//   @override
//   State createState() => SignInDemoState();
// }
//
// class SignInDemoState extends State<SignInDemo> {
//   GoogleSignInAccount _currentUser;
//   String _contactText = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact(_currentUser);
//       }
//     });
//     _googleSignIn.signInSilently();
//   }
//
//   Future<void> _handleGetContact(GoogleSignInAccount user) async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       Uri.parse('https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names'),
//       headers: await user.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }
//
//   String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//           (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//             (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }
//
//   Future<void> _handleSignIn() async {
//     try {
//       print("pressed");
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print("incorrect pass");
//       print(error);
//     }
//   }
//
//   Future<void> _handleSignOut() => _googleSignIn.disconnect();
//
//   Widget _buildBody() {
//     GoogleSignInAccount user = _currentUser;
//     if (user != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text("Signed in successfully."),
//           Text(_contactText),
//           ElevatedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           ElevatedButton(
//             child: const Text('REFRESH'),
//             onPressed: () => _handleGetContact(user),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           ElevatedButton(
//             child: const Text('SIGN IN'),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }


import 'package:flutter/material.dart';
import 'loginPage.dart';

void main(){
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
