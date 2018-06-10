package com.wb.tracun.markup.model;

import java.io.Serializable;

import com.wb.tracun.markup.Interfaces.IInsumo;

/**
 * Created by Tracun on 27/11/2017.
 */

public class Insumo implements Serializable{

    private int id;
    private String nome;
    private String unid;
    private int posicaoUnid;
    private float quantidade; //Coloquei na tabela(relacionamento) 'utiliza'
    private float valorUnitario;
    private float valorTotal;

    public Insumo(){

    }

    public Insumo(String nome, String unid, int posicaoUnid, float quantidade, float valorUnitario){
        this.nome = nome;
        this.unid = unid;
        this.quantidade = quantidade;
        this.valorUnitario = valorUnitario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
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

    public float getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(float quantidade) {
        this.quantidade = quantidade;
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

    public void calcularValorTotal(){
        this.valorTotal = this.valorUnitario * this.quantidade;
    }

//    @Override
    public String imprimir() {
        return "Nome: " + this.nome +
                "\nQuantidade: " + this.quantidade +
                "\nUnidade: " + this.unid +
                "\nValor Unitario: " + this.valorUnitario +
                "\nValor Total" + this.valorTotal;
    }
}
