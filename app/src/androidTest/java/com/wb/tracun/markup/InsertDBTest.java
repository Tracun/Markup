package com.wb.tracun.markup;

import android.view.View;

import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoCustoFragment;
import com.wb.tracun.markup.model.Produto;

import junit.framework.TestCase;

public class InsertDBTest extends TestCase{

    ProdutoCustoFragment p = new ProdutoCustoFragment();

    public void testInsertProduto(){

        com.wb.tracun.markup.model.Produto produto = new Produto();

        produto.setNome("Batata");
        produto.setCusto(5);
        produto.setPrecoVendaFora(10);
        produto.setPrecoVendaDentro(15);

        com.wb.tracun.markup.DB.GerenciaBD gerenciaBD = new com.wb.tracun.markup.DB.GerenciaBD(p.getContext());
        assertEquals(1, gerenciaBD.saveProduto(produto));
    }



}
