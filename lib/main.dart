import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:younghappychallenge/address/address_repository.dart';
import 'package:younghappychallenge/address/address_repository_impl.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/authentication/authentication_repository_impl.dart';
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/challenge_app.dart';
import 'package:younghappychallenge/core/configuration/environment.dart';
import 'package:younghappychallenge/core/storage_service.dart';
import 'package:younghappychallenge/testing_repository.dart';
import 'package:younghappychallenge/testing_repository_impl.dart';
import 'package:younghappychallenge/user/my_profile_store.dart';
import 'package:younghappychallenge/user/user_repository.dart';
import 'package:younghappychallenge/user/user_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final Environment environment = Dev();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final APIService apiService = APIService(endpoint: environment.apiEndpoint);
  final StorageService storageService = StorageService(storage);

  runApp(
    MultiProvider(
      providers: [
        Provider<Environment>(create: (context) => environment),
        Provider(create: (context) => MyProfileProvider()),
        Provider<TestingRepository>(
            create: (context) => TestingRepositoryImpl(apiService)),
        Provider<AuthenticationRepository>(
            create: (context) =>
                AuthenticationRepositoryImpl(apiService, auth)),
        Provider<AddressRepository>(
            create: (context) => AddressRepositoryImpl(apiService)),
        Provider<UserRepository>(
            create: (context) => UserRepositoryImpl(
                  auth,
                  storageService,
                  apiService,
                  Provider.of<MyProfileProvider>(context),
                )),
      ],
      child: ChallengeApp(),
    ),
  );
}
