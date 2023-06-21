import 'package:flutter/material.dart';
import '../models/refeicao_Model.dart';
import '../screens/refeicao_Detalhe_Screen.dart';

class MinhasReceitasScreen extends StatefulWidget {
  final List<Refeicao> receitasFavoritas;

  const MinhasReceitasScreen({Key? key, required this.receitasFavoritas}) : super(key: key);

  @override
  _MinhasReceitasScreenState createState() => _MinhasReceitasScreenState();
}

class _MinhasReceitasScreenState extends State<MinhasReceitasScreen> {
  void _removerReceita(Refeicao receita) {
    setState(() {
      widget.receitasFavoritas.remove(receita);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Receitas Favoritas'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: widget.receitasFavoritas.length,
        itemBuilder: (context, index) {
          final refeicao = widget.receitasFavoritas[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RefeicaoDetailsScreen(refeicaoId: refeicao.id),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            refeicao.thumbnailUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          right: 8.0,
                          child: IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () => _removerReceita(refeicao),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      refeicao.title,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
