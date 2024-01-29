import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:note_app_with_mongo/models/notes_model.dart';
import 'package:note_app_with_mongo/models/user_model.dart';
import 'package:note_app_with_mongo/utils/server_exception.dart';

class NetworkRepo {
  String hostName = "192.168.0.100";
  final http.Client httpClient = http.Client();

  String _endPoint(String endPont) {
    return "http://$hostName:3000/v1$endPont";
  }

  final Map<String, String> _header = {
    "Content-Type": "application/json; charset=utf-8"
  };

  Future<UserModel> signUp(UserModel userModel) async {
    final encodedParams = jsonEncode(userModel.toMap());

    final response = await httpClient.post(
      Uri.parse(
        _endPoint("/users/signup"),
      ),
      body: encodedParams,
      headers: _header,
    );

    if (response.statusCode == 200) {
      final userData = UserModel.fromMap(jsonDecode(response.body)["response"]);

      return userData;
    } else {
      throw ServerException(error: jsonDecode(response.body)['response']);
    }
  }

  Future<UserModel> signIn(UserModel user) async {
    final encodedParams = jsonEncode(user.toMap());

    final response = await httpClient.post(
      Uri.parse(
        _endPoint("/users/signin"),
      ),
      body: encodedParams,
      headers: _header,
    );

    if (response.statusCode == 200) {
      final userData = UserModel.fromMap(jsonDecode(response.body)["response"]);
      return userData;
    } else {
      throw ServerException(error: jsonDecode(response.body)["response"]);
    }
  }

  Future<UserModel> getProfile(UserModel user) async {
    final response = await httpClient.get(
      Uri.parse(
        _endPoint('/users/getprofile?uid=${user.uid}'),
      ),
      headers: _header,
    );

    if (response.statusCode == 200) {
      final userData = UserModel.fromMap(jsonDecode(response.body)['response']);
      return userData;
    } else {
      throw ServerException(error: jsonDecode(response.body)['response']);
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final encodedParams = jsonEncode(user.toMap());

    final response = await httpClient.put(
      Uri.parse(
        _endPoint('/users/updateProfile'),
      ),
      body: encodedParams,
      headers: _header,
    );

    if (response.statusCode == 200) {
      final userData = UserModel.fromMap(jsonDecode(response.body)['response']);
      return userData;
    } else {
      throw ServerException(error: jsonDecode(response.body)['response']);
    }
  }

  //____________________________________________________________________
  //____________________________________________________________________
  //____________________________________________________________________
  //____________________________________________________________________
  //Adding notes

  Future<NoteModel> addNote(NoteModel noteModel) async {
    final encodedParams = jsonEncode(noteModel.toMap());
    final response = await httpClient.post(
      Uri.parse(
        _endPoint('/notes/addnote'),
      ),
      body: encodedParams,
      headers: _header,
    );

    if (response.statusCode == 200) {
      final data = NoteModel.fromMap(jsonDecode(response.body)['response']);
      return data;
    } else {
      throw ServerException(error: jsonDecode(response.body)["response"]);
    }
  }

  Future<List<NoteModel>> getNotes() async {
    final List<NoteModel> notesList = [];

    final response = await httpClient.get(
      Uri.parse(
        _endPoint('/notes/getnotes'),
      ),
      headers: _header,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['response'];
      for (var element in data) {
        notesList.add(NoteModel.fromMap(element));
      }
      log(notesList.length.toString());
      // print(notesList.map((e) => e.title.toString()));
      return notesList;
    } else {
      throw ServerException(error: jsonDecode(response.body)["response"]);
    }
  }

  Future<NoteModel> updateNote(NoteModel noteModel) async {
    final encodedParams = jsonEncode(noteModel.toMap());

    final response = await httpClient.put(
      Uri.parse(_endPoint('/notes/updatenote')),
      body: encodedParams,
      headers: _header,
    );

    if (response.statusCode == 200) {
      final noteData = NoteModel.fromMap(jsonDecode(response.body)['response']);
      return noteData;
    } else {
      throw ServerException(error: jsonDecode(response.body)['response']);
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    final encodedParams = jsonEncode(note.toMap());

    final response = await httpClient.delete(
      Uri.parse(
        _endPoint('/notes/deletenote'),
      ),
      body: encodedParams,
      headers: _header,
    );

    if (response.statusCode == 200) {
      // Note successfully deleted, no need to return any data
      return;
    } else {
      throw ServerException(error: jsonDecode(response.body)['response']);
    }
  }
}
