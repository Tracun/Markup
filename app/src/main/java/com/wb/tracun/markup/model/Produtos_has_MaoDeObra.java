package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IProdutos_has_MaoDeObra;

public class Produtos_has_MaoDeObra implements IProdutos_has_MaoDeObra {

    private int produtos_idProdutos;
    private int maoDeObra_idMaoDeObra;
    private int tempoNecessario;

    public int getProdutos_idProdutos() {
        return produtos_idProdutos;
    }

    public void setProdutos_idProdutos(int produtos_idProdutos) {
        this.produtos_idProdutos = produtos_idProdutos;
    }

    public int getMaoDeObra_idMaoDeObra() {
        return maoDeObra_idMaoDeObra;
    }

    public void setMaoDeObra_idMaoDeObra(int maoDeObra_idMaoDeObra) {
        this.maoDeObra_idMaoDeObra = maoDeObra_idMaoDeObra;
    }

    public int getTempoNecessario() {
        return tempoNecessario;
    }

    public void setTempoNecessario(int tempoNecessario) {
        this.tempoNecessario = tempoNecessario;
    }

    @Override
    public String imprimir() {
        return null;
    }
}
