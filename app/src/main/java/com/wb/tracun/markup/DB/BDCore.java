package com.wb.tracun.markup.DB;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by Tracun on 30/11/2017.
 */

public class BDCore extends SQLiteOpenHelper{

    private static final String NOME_BD = "BDProduto.db";
    private static final int VERSAO_BD = 1;

    public BDCore(Context context) {
        super(context, NOME_BD, null, VERSAO_BD);
    }

    String createTableProduto = "CREATE TABLE Produtos (idProdutos INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT, nome VARCHAR(50)  NOT NULL, custo FLOAT NOT NULL, precoFora FLOAT NOT NULL, precoDentro FLOAT NOT NULL);\n";
    String createTableUnidade = "CREATE TABLE Unidades (idUnidades INTEGER NOT NULL  PRIMARY KEY  AUTOINCREMENT, descricao VARCHAR(10)  NOT NULL);\n";
    String createTableMaoDeObra = "CREATE TABLE MaoDeObra (idMaoDeObra INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT, descricao VARCHAR(50)  NOT NULL, valorHora DECIMAL NOT NULL);\n";
    String createTableDespesa = "CREATE TABLE Despesas (idDespesas INTEGER NOT NULL  PRIMARY KEY  AUTOINCREMENT, descricao VARCHAR(50)  NOT NULL, valor DECIMAL  NOT NULL);\n";
    String createTableRateio = "CREATE TABLE Rateio (idRateio INTEGER, unidades_idUnidades INTEGER, descricao TEXT NOT NULL, quant FLOAT  NOT NULL, valorUnit DECIMAL  NOT NULL, PRIMARY KEY(idRateio, Unidades_idUnidades), FOREIGN KEY(Unidades_idUnidades) REFERENCES Unidades(idUnidades));\n";
    String createTableInsumo = "CREATE TABLE Insumos (idInsumos INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT, unidades_idUnidades INTEGER NOT NULL, nome VARCHAR(50)  NOT NULL, valorUnit DECIMAL  NOT NULL, FOREIGN KEY(Unidades_idUnidades) REFERENCES Unidades(idUnidades));\n";

    String createTableProdutoHasRateio = "CREATE TABLE Produtos_has_Rateio (produtos_idProdutos INTEGER, rateio_unidades_idUnidades INTEGER, rateio_idRateio INTEGER, quantProduzida FLOAT  NOT NULL, PRIMARY KEY(Produtos_idProdutos, Rateio_Unidades_idUnidades, Rateio_idRateio), FOREIGN KEY(Produtos_idProdutos) REFERENCES Produtos(idProdutos), FOREIGN KEY(Rateio_idRateio, Rateio_Unidades_idUnidades)   REFERENCES Rateio(idRateio, Unidades_idUnidades));\n";
    String createTableProdutoHasDespesa = "CREATE TABLE Produtos_has_Despesas (produtos_idProdutos INTEGER, despesas_idDespesas INTEGER, PRIMARY KEY(Produtos_idProdutos, Despesas_idDespesas), FOREIGN KEY(Produtos_idProdutos) REFERENCES Produtos(idProdutos), FOREIGN KEY(Despesas_idDespesas) REFERENCES Despesas(idDespesas));\n";
    String createTableProdutoHasInsumo = "CREATE TABLE Produtos_has_Insumos (produtos_idProdutos INTEGER, insumos_idInsumos INTEGER, insumos_unidades_idUnidades INTEGER, quantInsumo FLOAT  NOT NULL, PRIMARY KEY(Produtos_idProdutos, Insumos_idInsumos, Insumos_Unidades_idUnidades), FOREIGN KEY(Produtos_idProdutos) REFERENCES Produtos(idProdutos), FOREIGN KEY(Insumos_idInsumos, Insumos_Unidades_idUnidades) REFERENCES Insumos(idInsumos, Unidades_idUnidades));\n";
    String createTableProdutoHasMaoDeObra = "CREATE TABLE Produtos_has_MaoDeObra (produtos_idProdutos INTEGER, maoDeObra_idMaoDeObra INTEGER, tempoNecessario FLOAT  NOT NULL, PRIMARY KEY(Produtos_idProdutos, maoDeObra_idmaoDeObra), FOREIGN KEY(Produtos_idProdutos) REFERENCES Produtos(idProdutos), FOREIGN KEY(maoDeObra_idmaoDeObra) REFERENCES maoDeObra(idmaoDeObra));\n";

    @Override
    public void onCreate(SQLiteDatabase db) {

        createTables(db);

        //integer primary key autoincrement, nome text not null, custo text not null, encargo text not null, comissao text not null, lucro text not null, outro text not null, imp1 text not null, imp2 text not null, custoIndireto text not null, precoFora text not null, precoDentro text not null, uriImg text
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int i, int i1) {

        deleteTables(db);
        createTables(db);

    }

    void createTables(SQLiteDatabase db){
        db.execSQL(createTableUnidade);
        db.execSQL(createTableInsumo);
        db.execSQL(createTableRateio);
        db.execSQL(createTableMaoDeObra);
        db.execSQL(createTableDespesa);
        db.execSQL(createTableProdutoHasInsumo);
        db.execSQL(createTableProdutoHasRateio);
        db.execSQL(createTableProdutoHasMaoDeObra);
        db.execSQL(createTableProdutoHasDespesa);
        db.execSQL(createTableProduto);
    }

    void deleteTables(SQLiteDatabase db){
        db.execSQL("Drop Table IF EXISTS " + "Unidades");
        db.execSQL("Drop Table IF EXISTS " + "Insumos");
        db.execSQL("Drop Table IF EXISTS " + "Rateio");
        db.execSQL("Drop Table IF EXISTS " + "MaoDeObra");
        db.execSQL("Drop Table IF EXISTS " + "Despesas");
        db.execSQL("Drop Table IF EXISTS " + "ProdutoHasInsumos");
        db.execSQL("Drop Table IF EXISTS " + "ProdutoHasDespesas");
        db.execSQL("Drop Table IF EXISTS " + "ProdutoHasRateio");
        db.execSQL("Drop Table IF EXISTS " + "ProdutoHasMaoDeObra");
        db.execSQL("Drop Table IF EXISTS " + "Produtos");

        createTables(db);
    }
}
