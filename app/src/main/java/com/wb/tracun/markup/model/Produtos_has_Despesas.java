package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IProdutos_has_Despesas;

public class Produtos_has_Despesas implements IProdutos_has_Despesas {

    private int produtos_idProdutos;
    private int despesas_idDespesas;

    public int getProdutos_idProdutos() {
        return produtos_idProdutos;
    }

    public void setProdutos_idProdutos(int produtos_idProdutos) {
        this.produtos_idProdutos = produtos_idProdutos;
    }

    public int getDespesas_idDespesas() {
        return despesas_idDespesas;
    }

    public void setDespesas_idDespesas(int despesas_idDespesas) {
        this.despesas_idDespesas = despesas_idDespesas;
    }

    @Override
    public String imprimir() {
        return null;
    }
}
