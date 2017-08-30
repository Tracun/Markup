package com.wb.tracun.markup;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.Format;
import java.util.Locale;

/**
 * Created by Tracun on 29/01/2017.
 */

public class ConversorMoeda {

    public static String formataMoeda(double preco){

        DecimalFormat df = new DecimalFormat("#.##",new DecimalFormatSymbols(new Locale("pt", "BR")));

        return df.format(preco);
    }



}
