import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

var clientID = "universitsavtest";
var apikey = "Dm3PTJLVYNxUj2DjsabQoMNgXTcWrKgnkFfy72FFKdDyn3bzGO";

var userID = "";

Future<String> createNaturalUser(String name, String firstname) async {
  var jsonParams = {
    "firstName": firstname,
    "LastName": name,
    "Birthday": 1463496101,
    "Nationality": "FR",
    "CountryOfResidence": "FR",
    "Email": "$firstname$name@gmail.com"
  };

  var uri = "https://api.sandbox.mangopay.com/v2.01/$clientID/users/natural";

  Uri uripost = Uri.parse(uri);
  http.Response response = await http.post(uripost,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic dW5pdmVyc2l0c2F2dGVzdDpEbTNQVEpMVllOeFVqMkRqc2FiUW9NTmdYVGNXcktnbmtGZnk3MkZGS2REeW4zYnpHTw=='
      },
      body: jsonEncode(jsonParams));
  Map<String, dynamic> responseJson = json.decode(response.body);
  userID = responseJson['Id'];
  return userID;
}

Future<String> pay(String userID, double montant) async {
  var jsonParams = {
    "AuthorId": userID,
    "DebitedFunds": {
      "Currency": 'EUR',
      "Amount": montant,
    },
    "Fees": {
      "Currency": 'EUR',
      "Amount": 0,
    },
    "ReturnURL": 'https://www.google.com',
    "CardType": 'CB_VISA_MASTERCARD',
    "CreditedWalletId": 104279924,
    "Culture": 'FR',
  };

  var uri = "https://api.sandbox.mangopay.com/v2.01/$clientID/payins/card/web";

  Uri uripost = Uri.parse(uri);
  http.Response response = await http.post(uripost,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic dW5pdmVyc2l0c2F2dGVzdDpEbTNQVEpMVllOeFVqMkRqc2FiUW9NTmdYVGNXcktnbmtGZnk3MkZGS2REeW4zYnpHTw=='
      },
      body: jsonEncode(jsonParams));
  Map<String, dynamic> responseJson = json.decode(response.body);
  var redirectURL = responseJson['RedirectURL'];
  print(redirectURL);
  return redirectURL;
}
