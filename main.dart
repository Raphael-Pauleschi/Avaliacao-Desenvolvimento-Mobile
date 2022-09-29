import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget{
  const Home({Key? key}): super(key:key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String _info = "Informe seus dados.";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  TextEditingController valorController = TextEditingController();
  TextEditingController contaController = TextEditingController();
  void _resetFields(){
    valorController.text = ''; contaController.text = '';
    setState((){
      _info = "Infome seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _desconto(){
    setState((){
     double valor = double.parse(valorController.text);
      int conta = int.parse(contaController.text);
     double descontoValor;

    switch (conta) {
      case 1:
        descontoValor = valor;
        _info = 'Cliente comum: Não há desconto, Valor: ($descontoValor)';
        break;
        case 2:
        descontoValor = valor - valor*10/100;
        _info = 'Funcionário: 10% de desconto, Valor: ($descontoValor)';
        break;
        case 3:
        descontoValor = valor - valor*5/100;
        _info = 'Cliente VIP: 5% de desconto, Valor: ($descontoValor)';
        break;
      default:
        descontoValor = valor;
        _info = 'Valor inválido, indo para default,  Valor: ($descontoValor)';
    }

    print(descontoValor);
  });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Efetuar desconto"),
        centerTitle : true,
        backgroundColor: Colors.pink,
        actions:<Widget>[
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10,0,10,0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person_outline, 
              size: 120.0, 
              color: Colors.pink),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor do produto:",
                labelStyle: TextStyle(color: Colors.pink)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.pink, fontSize: 25.0),
                controller: valorController,
                validator:(value){
                  if(value!.isEmpty){
                    return "Insira o valor do produto";
                  }
                  return null;
                },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tipo da conta:",
                labelStyle: TextStyle(color: Colors.pink)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.pink, fontSize: 25.0),
                controller: contaController,
                validator:(value){
                  if(value!.isEmpty){
                    return "Insira o tipo da conta";
                  }
                  return null;
                },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                height: 50,
                child: RaisedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()){
                      _desconto();
                    }
                  },
                  color:Colors.pink,
                  child: const Text(
                    'Calcular desconto',
                    style: TextStyle(color: Colors.white, fontSize:25.0),
                  ),
                ),
              ),
  
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.pink, fontSize: 25),
                )

            ],
          ),
        )
      )
    );
  }

}
