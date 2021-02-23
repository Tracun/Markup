import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/widgets/DespesasAdmWidget.dart';
import 'package:calcular_preco_venda/widgets/ImpostoWidget.dart';
import 'package:calcular_preco_venda/widgets/InsumoWidget.dart';
import 'package:calcular_preco_venda/widgets/RateioWidget.dart';
import 'package:calcular_preco_venda/widgets/TempFabWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  List<InsumoList> selectedInsumoList = [];
  List<DespesaAdmList> selectedDespesaAdmList = [];
  List<int> selectedImpostoList = [];
  List<TempoFabList> selectedTempoFabList = [];
  List<RateioList> selectedRateioList = [];

  TabWidget(this.selectedInsumoList, this.selectedDespesaAdmList, this.selectedImpostoList, this.selectedRateioList, this.selectedTempoFabList);

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: MyColors().appBarColorDark()),
          child: new TabBar(
            controller: _controller,
            tabs: [
              new Tab(
                icon: const Icon(Icons.monetization_on_outlined),
                text: 'Despesas Adm',
              ),
              new Tab(
                icon: const Icon(Icons.monetization_on_outlined),
                text: 'Impostos',
              ),
              new Tab(
                icon: const Icon(Icons.monetization_on_outlined),
                text: 'Insumos',
              ),
              new Tab(
                icon: const Icon(Icons.monetization_on_outlined),
                text: 'Rateio',
              ),
              new Tab(
                icon: const Icon(Icons.monetization_on_outlined),
                text: 'Temp Fabricação',
              ),
            ],
          ),
        ),
        Container(
          height: 310.0,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              SingleChildScrollView(
                child: Card(
                  child: DespesaAdmListWidget(
                      selectedDespesaAdmList: widget.selectedDespesaAdmList),
                ),
              ),
              SingleChildScrollView(
                child: Card(
                    child: ImpostoListWidget(
                  selectedImpostoList: widget.selectedImpostoList,
                )),
              ),
              SingleChildScrollView(
                child: Card(
                  child: InsumoListWidget(
                    selectedInsumoList: widget.selectedInsumoList,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Card(
                    child: RateioListWidget(
                  selectedRateioList: widget.selectedRateioList,
                )),
              ),
              SingleChildScrollView(
                child: Card(
                    child: TempoFabListWidget(
                  selectedTempoFabList: widget.selectedTempoFabList,
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
