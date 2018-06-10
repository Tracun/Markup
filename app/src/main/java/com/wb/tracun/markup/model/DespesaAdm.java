package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IDespesa;

/**
 * Created by Tracun on 28/11/2017.
 */

public class DespesaAdm implements IDespesa {

    private String descricao;
    private int id;
    private float valor;

    public DespesaAdm(){

    }

    public DespesaAdm(String descricao, float valor){
        this.descricao = descricao;
        this.valor = valor;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    @Override
    public String imprimir() {
        return "Descricao: " + this.descricao +
                "\nValor: " + this.valor;
    }
}
