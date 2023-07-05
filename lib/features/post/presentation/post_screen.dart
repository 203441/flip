import 'package:app_auth/features/post/presentation/post_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:app_auth/features/post/domain/usecases/post_usecase.dart';
import 'package:app_auth/features/post/domain/entities/post.dart';
import 'dart:io';

import 'my_posts.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  // controlador para el campo de descripción
  final _descriptionController = TextEditingController();

  // variable para guardar la ruta del archivo seleccionado
  String? _selectedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 229, 0, 1),
     appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(255, 229, 0, 1),  
        elevation: 0.0,
     ),
      body:
          // icono para seleccionar archivo, campo para agregar descripción y botón para subir
          Column(
        children: [
          const Text(
            "Subir archivo",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:   30,
              color: Colors.black,
              fontWeight: FontWeight.bold,

            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                // escoger un archivo
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mp3', 'pdf'],
                );
                if (result != null && result.files.isNotEmpty) {
                    // guardar la ruta del archivo seleccionado en lugar de subirlo de inmediato
                    _selectedFilePath = result.files.single.path!;
                  }
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Descripción",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:   30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Descripción',
                border: InputBorder.none, // Elimina el borde del TextFormField
                contentPadding: EdgeInsets.all(16), // Ajusta el relleno interno del TextFormField
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              if (_selectedFilePath == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Por favor, selecciona un archivo')),
                );
                return;
              }
              

              final createPostUseCase =
                  Provider.of<UploadPostUseCase>(context, listen: false);
              try {
                // ignore: unused_local_variable
                final post = await createPostUseCase.call(
                  _descriptionController.text,
                  _selectedFilePath!,
                );
                _selectedFilePath = null;
                _descriptionController.clear();
                Navigator.of(context).pushNamed('/post_home');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al crear post: $e')),
                );
              }
            },
            style: ElevatedButton.styleFrom(

            ),
            
            child: Text('Subir'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(255, 229, 0, 1),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home_sharp),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostsHome()), // Reemplaza 'NewView' con el nombre de tu vista de destino
                  );
                },
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostsScreen()), // Reemplaza 'NewView' con el nombre de tu vista de destino
                  );
                },
                color: const Color.fromARGB(255, 0, 0, 0),
              ),

              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPosts()), // Reemplaza 'NewView' con el nombre de tu vista de destino
                  );
                },
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
