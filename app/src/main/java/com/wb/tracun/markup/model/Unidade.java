package com.wb.tracun.markup.model;

import com.wb.tracun.markup.Interfaces.IUnidade;

/**
 * Created by u4239 on 07/12/2017.
 */

public class Unidade implements IUnidade {

    private String descricao;

    public Unidade(){

    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    @Override
    public String imprimir() {
        return this.descricao;
    }
}
