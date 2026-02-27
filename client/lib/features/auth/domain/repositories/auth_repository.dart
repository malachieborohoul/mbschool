import 'package:mbschool/core/domain/entities/user.dart';
import 'package:mbschool/core/utils/typedef.dart';



abstract interface class AuthRepository {


    ResultFuture<User> signIn(  {
        required String email,
      required String password,


     
  });
  
  ResultFuture<User> signUp(  {
    required String name,
    required String prenom,
    required String email,
    required String password,


     
  });




  ResultFuture<bool> signOut();
 

  



  ResultFuture<User> currentUserApi();
  ResultFuture<User> initApp();




   ResultFuture<bool> refreshToken();
  ResultFuture<String?> getAccessToken();


}
