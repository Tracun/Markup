package com.wb.tracun.paidmarkup;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by Tracun on 07/01/2017.
 */

public class BDCore extends SQLiteOpenHelper{

    private static final String NOME_BD = "BDProduto";
    private static final int VERSAO_BD = 4;


    public BDCore(Context context) {
        super(context, NOME_BD, null, VERSAO_BD);
    }

    @Override
    public void onCreate(SQLiteDatabase bd) {

        bd.execSQL("create table produtos(_id integer primary key autoincrement, nome text not null, custo text not null, encargo text not null, comissao text not null, lucro text not null, outro text not null, imp1 text not null, imp2 text not null, custoIndireto text not null, precoFora text not null, precoDentro text not null);");

    }

    @Override
    public void onUpgrade(SQLiteDatabase bd, int i, int i1) {

        bd.execSQL("drop table produtos;");
        onCreate(bd);

    }
}
