package com.wb.tracun.markup;

/**
 * Created by Tracun on 10/01/2017.
 */

public class Calculos {

    //Verifica se a soma dos impostos/lucro não excede 100%
    public static boolean isMoreThanOneHundred(Produto produto){

        return (produto.getImp1() + produto.getImp2()+ produto.getEncargo() + produto.getComissao() + produto.getOutros() + produto.getLucro()) > 100;

    }
    
    public static float calcularMarkupFora(Produto produto){
        
        float MarkFora;
        
        float impostos = produto.getImp1() + produto.getImp2();
        
        // Soma dos impostos, encargos, neste caso, não somamos a porcentagem do lucro
        MarkFora = 100 - (impostos + produto.getEncargo() + produto.getComissao() + produto.getOutros());
        
        return MarkFora;
    }
    
    public static float calcularMarkupDentro(Produto produto){
        
        float MarkDentro;
        
        float impostos = produto.getImp1() + produto.getImp2();
        
        // Soma dos impostos, encargos, *neste caso, somamos a porcentagem do lucro.
        MarkDentro = 100 - (impostos + produto.getEncargo() + produto.getComissao() + produto.getOutros() + produto.getLucro());
        
        return MarkDentro;
    }
    
    public static double calcularPrecoFora(Produto produto){

        //Se a soma dos impostos mais que 100, retorna erro -333, preço não pode ser calculado
        if(isMoreThanOneHundred(produto)) return -333;

        double preco;
        
        preco = ((produto.getCusto() + (produto.getCusto() * produto.getCustoIndireto()/100)) + (produto.getCusto() + (produto.getCusto() * produto.getCustoIndireto()/100)) * produto.getLucro()/100)/calcularMarkupFora(produto)*100;
        
        return preco;
        
    }
    
    public static double calcularPrecoDentro(Produto produto){

        //Se a soma dos impostos mais que 100, retorna erro -333, preço não pode ser calculado
        if(isMoreThanOneHundred(produto)) return -333;

        double preco;
        
        preco = (produto.getCusto() + (produto.getCusto() * produto.getCustoIndireto()/100))/ calcularMarkupDentro(produto) * 100;
        
        return preco;
        
    }

}
