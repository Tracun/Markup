import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/cover2.jpg'))),
          ),
          ListTile(
            leading: Image.asset('assets/icons/despesa.png', width: 32,height: 32,),
            title: Text('Despesas Adm'),
            onTap: () => {
              Navigator.of(context).pop(),
              ScreenNavigator().despesaAdmListScreen(context),
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/tax.png', width: 32,height: 32,),
            title: Text('Impostos'),
            onTap: () => {
              Navigator.of(context).pop(),
              ScreenNavigator().impostoListScreen(context),
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/Insumo.png', width: 32,height: 32,),
            title: Text('Insumos'),
            onTap: () => {
              Navigator.of(context).pop(),
              ScreenNavigator().insumoListScreen(context),
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/pie-chart.png', width: 32,height: 32,),
            title: Text('Rateio'),
            onTap: () => {
              Navigator.of(context).pop(),
              ScreenNavigator().rateioListScreen(context),
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/tempFab.png', width: 32,height: 32,),
            title: Text('Tempo fabricação'),
            onTap: () => {
              Navigator.of(context).pop(),
              ScreenNavigator().tempoFabListScreen(context),
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.list_alt),
          //   title: Text('Unidades'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
        ],
      ),
    );
  }
}
