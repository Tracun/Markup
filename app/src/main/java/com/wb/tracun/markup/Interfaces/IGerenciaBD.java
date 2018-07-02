package com.wb.tracun.markup.Interfaces;

import android.content.Context;
import android.database.Cursor;

import com.wb.tracun.markup.model.DespesaAdm;
import com.wb.tracun.markup.model.Insumo;
import com.wb.tracun.markup.model.Produto;
import com.wb.tracun.markup.model.Produtos_has_Despesas;
import com.wb.tracun.markup.model.Produtos_has_Insumos;
import com.wb.tracun.markup.model.Produtos_has_MaoDeObra;
import com.wb.tracun.markup.model.Produtos_has_Rateio;
import com.wb.tracun.markup.model.Rateio;
import com.wb.tracun.markup.model.TempoFab;
import com.wb.tracun.markup.model.Unidade;

/**
 * Created by Tracun on 07/12/2017.
 */

public interface IGerenciaBD {

    int saveUnidade(Unidade unidade);
    int saveInsumo(Insumo insumo);
    int saveRateio(Rateio rateio);
    int saveDespesa(DespesaAdm despesaAdm);
    int saveTempoFab(TempoFab tempoFab);
    int saveProduto(Produto produto);
    int saveProdutos_has_Rateio (Produtos_has_Rateio produtos_has_Rateio );
    int saveProdutos_has_Despesas  (Produtos_has_Despesas produtos_has_Despesas );
    int saveProdutos_has_Insumos  (Produtos_has_Insumos produtos_has_Insumos );
    int saveProdutos_has_MaoDeObra  (Produtos_has_MaoDeObra produtos_has_MaoDeObra );

    Cursor buscaUnidadeById(int id);
    Cursor buscaInsumoById(int id);
    int buscaUltimoProduto();
    Cursor buscaInsumos();
    Cursor buscaRateio();
    Cursor buscaDespesas();
    Cursor buscaTempoFab();
    Cursor buscaUnidades();

    void salvaUnidadesPadroes(Context context);


//    String uptadeUnidade(Unidade unidade);
//    String uptadeInsumo(Insumo insumo);
//    String uptadeRateio(Rateio rateio);
//    String uptadeDespesa(DespesaAdm despesaAdm);
//    String uptadeTempoFab(TempoFab tempoFab);
//    String uptadeProduto(Produto produto);


}
