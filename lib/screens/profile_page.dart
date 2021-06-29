import 'package:easystory/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easystory/models/profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isObscurePassword = true;
  late Future <Profile> userProfile;
  ProfileProvider provider = new ProfileProvider();

  @override
  void initState() { 
    super.initState();
    userProfile = provider.getAll();
  } 

  Widget _ProfileDetails(Profile profile){
    return Text(profile.firstName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
    future: userProfile,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      var user = snapshot.data! as Profile;

      return _ProfileDetails(user);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
);
    /*
    return Scaffold(
      appBar: AppBar(
          title: Text('Perfil de Usuario'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,  
            ),
            onPressed: (){},  
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ), 
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.white
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1621202432974-5e3aac3f5f10?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGJsb25kZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60'
                            )
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white
                            ),
                            color: Colors.blue
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,

                          ),
                        )
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 30),
                buildTextField("Nombre", "Karla", false),
                buildTextField("Apellido", "Peschi", false),
                buildTextField("Email", "karla@gmail.com", false),
                buildTextField("Teléfono", "954345223", false),
                buildTextField("Suscriptores", "154", false),
                buildTextField("Suscripciones", "2", false),
                //buildTextField("Password", "*****", true),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: (){},
                      child: Text("CANCEL",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                      )),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("SAVE", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white
                      )),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
    */
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField ? 
            IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: (){},
            ): null,
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        )
        ),
      ),
    );
  }
}
