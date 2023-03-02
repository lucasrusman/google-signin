import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  static Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account?.authentication;
      // print(account);
      // print(googleKey?.idToken);
      final signInWithGoogleEndpoint = Uri(
          scheme: 'https',
          host: 'google-signin-server-production.up.railway.app',
          path: '/google');
      final session = await http
          .post(signInWithGoogleEndpoint, body: {'token': googleKey?.idToken});
      print('------------------');
      print(session.body);
      return account;
    } catch (e) {
      print('Error en google signin');
      print(e);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
