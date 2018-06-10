package com.wb.tracun.markup;

import com.wb.tracun.markup.model.*;

import java.util.ArrayList;

/**
 * Created by Tracun on 05/12/2017.
 */

public class Calculations {

    private float valorInsumos = 0;
    private float valorFab = 0;
    private float valorDespesa = 0;
    private float valorRateio = 0;

    float calcularCusto(){
        return valorInsumos + valorFab + valorRateio;
    }

    float somaTotalInsumos(ArrayList<Insumo> arrayInsumos){
        float valorTotalInsumos = 0;
        for(Insumo insumo: arrayInsumos){
            valorTotalInsumos += insumo.getValorTotal();
        }
        valorInsumos = valorTotalInsumos;
        return valorTotalInsumos;
    }

    float somaTotalDespesa(ArrayList<DespesaAdm> arrayDespesas){
        float valorTotalDespesas = 0;
        for(DespesaAdm despesaAdm: arrayDespesas){
            valorTotalDespesas += despesaAdm.getValor();
        }
        valorDespesa = valorTotalDespesas;
        return valorTotalDespesas;
    }

    float somaTotalFabricacao(ArrayList<TempoFab> arrayTemposFabricacao){
        float valorTotalFab = 0;
        for(TempoFab tempoFab: arrayTemposFabricacao){
            valorTotalFab += tempoFab.getValorTotal();
        }
        valorFab = valorTotalFab;
        return valorTotalFab;
    }

    float somaValorRateio(ArrayList<Rateio> arrayRateio){
        float valorTotal = 0;
        for (Rateio rateio: arrayRateio) {
            valorTotal += rateio.getValorTotal();
        }
        valorRateio = valorTotal;
        return valorTotal;
    }
}
