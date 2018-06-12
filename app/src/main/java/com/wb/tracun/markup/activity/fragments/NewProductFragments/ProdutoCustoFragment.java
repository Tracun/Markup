package com.wb.tracun.markup.activity.fragments.NewProductFragments;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.wb.tracun.markup.*;
import com.wb.tracun.markup.DB.GerenciaBD;
import com.wb.tracun.markup.model.*;
import com.wb.tracun.markup.model.Produto;

import org.eazegraph.lib.charts.BarChart;
import org.eazegraph.lib.charts.PieChart;
import org.eazegraph.lib.charts.ValueLineChart;
import org.eazegraph.lib.models.BarModel;
import org.eazegraph.lib.models.LegendModel;
import org.eazegraph.lib.models.PieModel;
import org.eazegraph.lib.models.ValueLinePoint;
import org.eazegraph.lib.models.ValueLineSeries;

public class ProdutoCustoFragment extends Fragment {

    EditText txtCusto;
    Button btnCalcularCusto;
    BarChart mBarChart;
    PieChart mPieChart;

    GerenciaBD gerenciaBD = new GerenciaBD(this.getContext());

    static float mValorInsumos = 0;
    static float mValorTempoFab = 0;
    static float mValorDespesa = 0;
    static float mValorRateio = 0;

    public ProdutoCustoFragment() {
        // Required empty public constructor
    }

    @Override
    public void onResume() {
        super.onResume();

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        final View view = inflater.inflate(R.layout.fragment_produto_custo, container, false);
        txtCusto = (EditText) view.findViewById(R.id.txtCusto);
        btnCalcularCusto = (Button) view.findViewById(R.id.btnCalcularCusto);

        txtCusto.setText("R$ " + calcularCustoProduto(view));

        plotPieChart(view);

        btnCalcularCusto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                txtCusto.setText("R$ " + calcularCustoProduto(view));
                mPieChart.clearChart();
                plotPieChart(view);
            }
        });

        return view;
    }

    public static float calcularCustoProduto(View view){

        mValorInsumos = ProdutoInsumoFragment.calcularCustosInsumos();
        mValorRateio = ProdutoRateioFragment.calcularCustosRateio();
        mValorDespesa = ProdutoDespesaFragment.calcularCustosDespesa();
        mValorTempoFab = ProdutoTempoFabFragment.calcularCustosTempoFab();

        //Testando se há objeto no array
        Toast.makeText(view.getContext(), "INSUMO OBJECT size: " + ProdutoInsumoFragment.listaInsumosProduto.size(), Toast.LENGTH_LONG).show();

//        Toast.makeText(view.getContext(), "SOMA INSUMO; " + mValorInsumos, Toast.LENGTH_LONG).show();
//        Toast.makeText(view.getContext(), "SOMA RATEIO; " + mValorRateio, Toast.LENGTH_LONG).show();
//        Toast.makeText(view.getContext(), "SOMA DESPESA; " + mValorDespesa, Toast.LENGTH_LONG).show();
//        Toast.makeText(view.getContext(), "SOMA TEMPO FAB; " + mValorTempoFab, Toast.LENGTH_LONG).show();

        return  (mValorInsumos + mValorRateio + mValorTempoFab);
    }

    public static void salvarProduto(View v){

        com.wb.tracun.markup.model.Produto produto = new Produto();

        //Criar os campos na tela de cadastro para completar os campos abaixo
//        produto.setNome();
//        produto.setCusto();

        //Implementar metodo que realize o calculo do preco por fora e por dentro
        calcularCustoProduto(v);
        calcularPrecoVendaFora(v);
        calcularPrecoVendaDentro(v);

    }

    private static float calcularPrecoVendaDentro(View v) {
        return -1;
    }

    private static float calcularPrecoVendaFora(View v) {
        return -1;
    }

    public void salvarInsumo(){

        //PEGAR ID DO PRODUTO EM QUESTAO
        int idProduto = 1;
        Produtos_has_Insumos insumo = new Produtos_has_Insumos();

        for (Insumo i : ProdutoInsumoFragment.listaInsumosProduto) {

            insumo.setProdutos_idProdutos(idProduto);
            insumo.setInsumos_idInsumos(i.getId());
            insumo.setQuantInsumo(i.getQuantidade());
        }

        if(insumo != null){
            gerenciaBD.saveProdutos_has_Insumos(insumo);
        }
    }

    public void salvarProdutos_has_Despesas(){

        //PEGAR ID DO PRODUTO EM QUESTAO
        int idProduto = 1;
        Produtos_has_Despesas despesa = new Produtos_has_Despesas();

        for (DespesaAdm d : ProdutoDespesaFragment.listaDespesasProduto) {

            despesa.setProdutos_idProdutos(idProduto);
            despesa.setDespesas_idDespesas(d.getId());
        }

        if(despesa != null){
            gerenciaBD.saveProdutos_has_Despesas(despesa);
        }
    }

    public void salvarProdutos_has_Rateio(){

        //PEGAR ID DO PRODUTO EM QUESTAO
        int idProduto = 1;
        Produtos_has_Rateio rateio = new Produtos_has_Rateio();

        for (Rateio r : ProdutoRateioFragment.listaRateiosProduto) {

            rateio.setProdutos_idProdutos(idProduto);
            rateio.setRateio_idRateio(r.getId());
            rateio.setQuantProduzida(r.getQuantidade());
        }

        if(rateio != null){
            gerenciaBD.saveProdutos_has_Rateio(rateio);
        }
    }

    public void salvarProdutos_has_MaoDeObra(){

        //PEGAR ID DO PRODUTO EM QUESTAO
        int idProduto = 1;
        Produtos_has_MaoDeObra mo = new Produtos_has_MaoDeObra();

        for (TempoFab t : ProdutoTempoFabFragment.listaTempoFabProduto) {

            mo.setProdutos_idProdutos(idProduto);
            mo.setMaoDeObra_idMaoDeObra(t.getId());
            mo.setTempoNecessario(t.getTempo());
        }

        if(mo != null){
            gerenciaBD.saveProdutos_has_MaoDeObra(mo);
        }
    }

    void plotPieChart(View view){

        mPieChart = (PieChart) view.findViewById(R.id.costPieGraph);

        mPieChart.addPieSlice(new PieModel("Insumos", mValorInsumos, Color.parseColor("#FE6DA8")));
        mPieChart.addPieSlice(new PieModel("Rateio", mValorRateio, Color.parseColor("#56B7F1")));
        mPieChart.addPieSlice(new PieModel("Temp Fab", mValorTempoFab, Color.parseColor("#CDA67F")));

        mPieChart.setLegendHeight(2f);

        mPieChart.startAnimation();

    }
}
