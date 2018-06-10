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
import com.wb.tracun.markup.model.DespesaAdm;
import com.wb.tracun.markup.model.Insumo;
import com.wb.tracun.markup.model.Produtos_has_Insumos;
import com.wb.tracun.markup.model.Produtos_has_MaoDeObra;

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

        Toast.makeText(view.getContext(), "INSUMO OBJECT size: " + ProdutoInsumoFragment.listaInsumosProduto.size(), Toast.LENGTH_LONG).show();

//        Toast.makeText(view.getContext(), "SOMA INSUMO; " + mValorInsumos, Toast.LENGTH_LONG).show();
//        Toast.makeText(view.getContext(), "SOMA RATEIO; " + mValorRateio, Toast.LENGTH_LONG).show();
//        Toast.makeText(view.getContext(), "SOMA DESPESA; " + mValorDespesa, Toast.LENGTH_LONG).show();
//        Toast.makeText(view.getContext(), "SOMA TEMPO FAB; " + mValorTempoFab, Toast.LENGTH_LONG).show();

        return  (mValorInsumos + mValorRateio + mValorTempoFab);
    }

    public static void salvarProduto(View v){

//        DespesaAdm despesaAdm = new DespesaAdm();
//        despesaAdm.setDescricao(txtNome.getText().toString());
//        despesaAdm.setValor(Float.parseFloat(txtCusto.getText().toString()));
//
//        if(gerenciaBD.saveDespesa(despesaAdm) > 0){
//            Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
//            txtNome.setText("");
//            txtCusto.setText("");
//        }else{
//            Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
//        }
//    }
//
//        for (Insumo i:ProdutoInsumoFragment.listaInsumosProduto) {
//
//        }

    }

    public void salvarInsumo(){

        int idProduto = 1;

        for (Insumo i:ProdutoInsumoFragment.listaInsumosProduto) {
            Produtos_has_Insumos insumo = new Produtos_has_Insumos();

            insumo.setProdutos_idProdutos(idProduto);
            insumo.setInsumos_idInsumos(i.getId());
            insumo.setQuantInsumo(i.getQuantidade());

            i.setId(idProduto);
//            gerenciaBD.saveProdutos_has_Insumos();
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
