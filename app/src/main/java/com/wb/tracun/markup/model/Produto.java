package com.wb.tracun.markup.model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by Tracun on 29/11/2017.
 */

public class Produto implements Serializable{

    private String nome;
    private float custo;
    private float precoVendaFora;
    private float precoVendaDentro;

    private ArrayList<Insumo> insumos;
    private ArrayList<TempoFab> TempoFab;
    private ArrayList<DespesaAdm> DespesaAdm;
    private ArrayList<Rateio> rateio;

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public float getCusto() {
        return custo;
    }

    public void setCusto(float custo) {
        this.custo = custo;
    }

    public float getPrecoVendaFora() {
        return precoVendaFora;
    }

    public void setPrecoVendaFora(float precoVendaFora) {
        this.precoVendaFora = precoVendaFora;
    }

    public float getPrecoVendaDentro() {
        return precoVendaDentro;
    }

    public void setPrecoVendaDentro(float precoVendaDentro) {
        this.precoVendaDentro = precoVendaDentro;
    }

    public ArrayList<Insumo> getInsumos() {
        return insumos;
    }

    public void setInsumos(ArrayList<Insumo> insumos) {
        this.insumos = insumos;
    }

    public ArrayList<com.wb.tracun.markup.model.TempoFab> getTempoFab() {
        return TempoFab;
    }

    public void setTempoFab(ArrayList<com.wb.tracun.markup.model.TempoFab> tempoFab) {
        TempoFab = tempoFab;
    }

    public ArrayList<com.wb.tracun.markup.model.DespesaAdm> getDespesaAdm() {
        return DespesaAdm;
    }

    public void setDespesaAdm(ArrayList<com.wb.tracun.markup.model.DespesaAdm> despesaAdm) {
        DespesaAdm = despesaAdm;
    }

    public ArrayList<Rateio> getRateio() {
        return rateio;
    }

    public void setRateio(ArrayList<Rateio> rateio) {
        this.rateio = rateio;
    }
}
