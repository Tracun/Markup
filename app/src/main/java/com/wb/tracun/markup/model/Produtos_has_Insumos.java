package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IProdutos_has_Insumos;

public class Produtos_has_Insumos implements IProdutos_has_Insumos {

    private int produtos_idProdutos;
    private int insumos_idInsumos;
    private int insumos_unidades_idUnidades;
    private float quantInsumo;

    public int getProdutos_idProdutos() {
        return produtos_idProdutos;
    }

    public void setProdutos_idProdutos(int produtos_idProdutos) {
        this.produtos_idProdutos = produtos_idProdutos;
    }

    public int getInsumos_idInsumos() {
        return insumos_idInsumos;
    }

    public void setInsumos_idInsumos(int insumos_idInsumos) {
        this.insumos_idInsumos = insumos_idInsumos;
    }

    public int getInsumos_unidades_idUnidades() {
        return insumos_unidades_idUnidades;
    }

    public void setInsumos_unidades_idUnidades(int insumos_unidades_idUnidades) {
        this.insumos_unidades_idUnidades = insumos_unidades_idUnidades;
    }

    public float getQuantInsumo() {
        return quantInsumo;
    }

    public void setQuantInsumo(float quantInsumo) {
        this.quantInsumo = quantInsumo;
    }

    @Override
    public String imprimir() {
        return null;
    }
}
