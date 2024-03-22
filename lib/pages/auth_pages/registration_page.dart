import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica/controller/auth_controller.dart';
import 'package:prueba_tecnica/pages/auth_pages/login_page.dart';
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    List images = [
      "g.png",
      "f.png",
      "t.png"
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/signup.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.16,),
                    const CircleAvatar(                  
                      radius: 60,
                      backgroundImage: AssetImage(
                        "assets/img/rick.png"
                      ),
                    )
                  ],
                ),
              ),
               Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 7,
                                blurRadius: 10,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail, color: Colors.orange[400],),
                          hintText: "Correo",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 7,
                                blurRadius: 10,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(    
                        controller: passwordController,
                        obscureText: true,              
                        decoration: InputDecoration(    
                          prefixIcon: Icon(Icons.lock, color: Colors.orange[400],),                  
                          hintText: "Constraseña",                      
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: (){
                  AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                },
                child: Container(
                  width: width * 0.5,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          image: AssetImage("assets/img/loginbtn.png"),
                          fit: BoxFit.cover)),
                  child: const Center(
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              RichText(text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=(()=>Get.to(const LoginPage())),
                text: "Ya tienes cuenta? ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[400]
                )
              )), 
            
              SizedBox(
                height: height * 0.05,
              ),
              RichText(
                text: TextSpan(
                    text: "O iniciar sesión con...",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                   ),
              ),
              Wrap(
                children: List<Widget>.generate(
                  3,
                  (index){
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white, 
                        child: CircleAvatar(
                          radius: 25,                    
                          backgroundImage: AssetImage(                        
                            "assets/img/"+images[index]
                      
                          ),
                        ),
                      ),
                    );
                  }
                )        
              )
            ],
          
              ),
        ),
    );
  }
}