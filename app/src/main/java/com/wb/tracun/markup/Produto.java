package com.wb.tracun.markup;

/**
 * Created by Tracun on 10/01/2017.
 */

public class Produto {

    private int id;
    private String nome;
    private double custo;
    private float encargo;
    private float comissao;
    private float lucro;
    private float outros;
    private float imp1;
    private float imp2;
    private float custoIndireto;
    private double precoFora;
    private double precoDentro;
    private String uriImg;

    public Produto(int id, String nome, double custo, float encargo, float comissao, float lucro, float outros, float imp1, float imp2, float imp3, float custoIndireto, double precoFora, double precoDentro, String uriImg) {
        this.id = id;
        this.nome = nome;
        this.custo = custo;
        this.encargo = encargo;
        this.comissao = comissao;
        this.lucro = lucro;
        this.outros = outros;
        this.imp1 = imp1;
        this.imp2 = imp2;
        this.custoIndireto = custoIndireto;
        this.precoFora = precoFora;
        this.precoDentro = precoDentro;
        this.uriImg = uriImg;
    }

    public Produto() {
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

    public double getCusto() {
        return custo;
    }

    public void setCusto(double custo) {
        this.custo = custo;
    }

    public float getEncargo() {
        return encargo;
    }

    public void setEncargo(float encargo) {
        this.encargo = encargo;
    }

    public float getComissao() {
        return comissao;
    }

    public void setComissao(float comissao) {
        this.comissao = comissao;
    }

    public float getLucro() {
        return lucro;
    }

    public void setLucro(float lucro) {
        this.lucro = lucro;
    }

    public float getOutros() {
        return outros;
    }

    public void setOutros(float outros) {
        this.outros = outros;
    }

    public float getImp1() {
        return imp1;
    }

    public void setImp1(float imp1) {
        this.imp1 = imp1;
    }

    public float getImp2() {
        return imp2;
    }

    public void setImp2(float imp2) {
        this.imp2 = imp2;
    }

    public float getCustoIndireto() {
        return custoIndireto;
    }

    public void setCustoIndireto(float custoIndireto) {
        this.custoIndireto = custoIndireto;
    }

    public double getPrecoFora() {
        return precoFora;
    }

    public void setPrecoFora(double precoFora) {
        this.precoFora = precoFora;
    }

    public double getPrecoDentro() {
        return precoDentro;
    }

    public void setPrecoDentro(double precoDentro) {
        this.precoDentro = precoDentro;
    }

    public String getUriImg() {
        return uriImg;
    }

    public void setUriImg(String uriImg) {
        this.uriImg = uriImg;
    }

    public String imprimir(){
        return "Nome Produto: " + this.nome + "  Custo: " + this.custo + "\nLucro: " + this.lucro + "\nEncargo: " + this.encargo + "\nComissão: " + this.comissao + "\nOutros: " + this.outros + "\nImpostos: " + this.imp1 + ", " + this.imp2;
    }
    
}
