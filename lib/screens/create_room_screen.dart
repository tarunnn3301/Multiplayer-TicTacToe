import 'package:flutter/material.dart';
import '../resources/socket_methods.dart';
import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  int _quantity = 1; // Variable to hold the selected quantity

  void incrementQuantity() {
    setState(() {
      if (_quantity < 10) {
        _quantity++;
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20,80,20,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: 'Create Room',
                fontSize: 60,
              ),
              SizedBox(height: size.height * 0.07),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname',
              ),
              SizedBox(height: size.height * 0.045),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText( shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: 'Total Rounds',
                fontSize: 27,),
                SizedBox(width: 10,),
                CustomText( shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: ' =',
                fontSize: 24,),
                SizedBox(width: 10,),
                  IconButton(
                    onPressed: decrementQuantity,
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    _quantity.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: incrementQuantity,
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              CustomButton(
                onTap: () => _socketMethods.createRoom(
                  _nameController.text,_quantity
                ),
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
