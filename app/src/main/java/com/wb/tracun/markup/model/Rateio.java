package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IRateio;

/**
 * Created by u4239 on 28/11/2017.
 */

public class Rateio implements IRateio {

    private String Descricao;
    private int id;
    private float quantidade;
    private String unid;
    private int posicaoUnid;
    private float quantProduzida;//Coloquei na tabela(relacionamento) 'Tem'
    private float valorUnitario;
    private float valorTotal;

    public Rateio(String descricao, float quantidade, String unid, int posicaoUnid, float quantProduzida, float valorUnitario) {
        Descricao = descricao;
        this.quantidade = quantidade;
        this.unid = unid;
        this.posicaoUnid = posicaoUnid;
        this.quantProduzida = quantProduzida;
        this.valorUnitario = valorUnitario;
    }

    public Rateio(){

    }

    public String getDescricao() {
        return Descricao;
    }

    public void setDescricao(String descricao) {
        Descricao = descricao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(float quantidade) {
        this.quantidade = quantidade;
    }

    public String getUnid() {
        return unid;
    }

    public void setUnid(String unid) {
        this.unid = unid;
    }

    public int getPosicaoUnid() {
        return posicaoUnid;
    }

    public void setPosicaoUnid(int posicaoUnid) {
        this.posicaoUnid = posicaoUnid;
    }

    public float getQuantProduzida() {
        return quantProduzida;
    }

    public void setQuantProduzida(float quantProduzida) {
        this.quantProduzida = quantProduzida;
    }

    public float getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(float valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public float getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(float valorTotal) {
        this.valorTotal = valorTotal;
    }

    @Override
    public float calcularValorTotal() {
        return ((this.getValorUnitario() * this.getQuantidade()) / this.getQuantProduzida());
    }

    @Override
    public String imprimir() {
        return null;
    }
}
