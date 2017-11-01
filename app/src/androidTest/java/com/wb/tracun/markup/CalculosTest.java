package com.wb.tracun.markup;

/**
 * Created by tracun on 22/10/17.
 */

import android.support.test.runner.AndroidJUnit4;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

@RunWith(AndroidJUnit4.class)
public class CalculosTest {

    public Produto createProduct(){
        Produto produto = new Produto();
        produto.setNome("Batata");
        produto.setCusto(0.50);
        produto.setLucro(30);
        produto.setComissao(0);
        produto.setCustoIndireto(5);
        produto.setEncargo(2);
        produto.setImp1(18);
        produto.setImp2(9);
        produto.setOutros(0);

        return produto;
    }

    @Test
    public void somaImpostosMenorQueCem(){
        Calculos calculos = new Calculos();

        Assert.assertFalse(calculos.isMoreThanOneHundred(createProduct()));
    }

    @Test
    public void somaImpostosMaiorQueCem(){
        Calculos calculos = new Calculos();
        Produto produto = createProduct();
        produto.setLucro(75);

        Assert.assertTrue(calculos.isMoreThanOneHundred(produto));
    }

    @Test
    public void calcularMarkUpDentro(){
        Calculos calculos = new Calculos();

        Assert.assertEquals(41, calculos.calcularMarkupDentro(createProduct()), 0);

    }

    @Test
    public void calcularMarkUpFora(){
        Calculos calculos = new Calculos();

        Assert.assertEquals(71, calculos.calcularMarkupFora(createProduct()), 0);

    }

    @Test
    public void calcularPrecoDentro(){
        Calculos calculos = new Calculos();

        Assert.assertEquals(1.28, calculos.calcularPrecoDentro(createProduct()), 0.01);

    }

    @Test
    public void calcularPrecoFora(){
        Calculos calculos = new Calculos();

        Assert.assertEquals(0.96, calculos.calcularPrecoFora(createProduct()), 0.01);

    }


}


