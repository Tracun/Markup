package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.ITempoFab;

/**
 * Created by Tracun on 27/11/2017.
 */

public class TempoFab implements ITempoFab {

    private String nome;
    private int id;
    private float tempo; //Coloquei na tabela(relacionamento) usa.
    private float valorHora;
    private float valorTotal;

    public TempoFab(){

    }

    public TempoFab(String nome, Float tempo, float valorHora){
        this.nome = nome;
        this.tempo = tempo;
        this.valorHora = valorHora;
        this.valorTotal = tempo * valorHora;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getTempo() {
        return tempo;
    }

    public void setTempo(float tempo) {
        this.tempo = tempo;
    }

    public float getValorHora() {
        return valorHora;
    }

    public void setValorHora(float valorHora) {
        this.valorHora = valorHora;
    }

    public float getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(float valorTotal) {
        this.valorTotal = valorTotal;
    }

    @Override
    public void calcularValorTotal() {
        this.valorTotal = this.valorHora * this.tempo;
    }

    @Override
    public String imprimir() {
        return "Nome: " + this.nome +
                "\nTempo: " + this.tempo +
                "\nValor Hora: " + this.valorHora +
                "\nValor Total: " + this.valorTotal;
    }
}
