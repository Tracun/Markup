package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IProdutos_has_Rateio;

public class Produtos_has_Rateio implements IProdutos_has_Rateio{

    private int  produtos_idProdutos;
    private int rateio_unidades_idUnidades;
    private int rateio_idRateio;
    private float quantProduzida;

    public int getProdutos_idProdutos() {
        return produtos_idProdutos;
    }

    public void setProdutos_idProdutos(int produtos_idProdutos) {
        this.produtos_idProdutos = produtos_idProdutos;
    }

    public int getRateio_unidades_idUnidades() {
        return rateio_unidades_idUnidades;
    }

    public void setRateio_unidades_idUnidades(int rateio_unidades_idUnidades) {
        this.rateio_unidades_idUnidades = rateio_unidades_idUnidades;
    }

    public int getRateio_idRateio() {
        return rateio_idRateio;
    }

    public void setRateio_idRateio(int rateio_idRateio) {
        this.rateio_idRateio = rateio_idRateio;
    }

    public float getQuantProduzida() {
        return quantProduzida;
    }

    public void setQuantProduzida(float quantProduzida) {
        this.quantProduzida = quantProduzida;
    }

    @Override
    public String imprimir() {
        return null;
    }
}
