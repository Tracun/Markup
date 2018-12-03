package com.wb.tracun.markup;

import android.app.Activity;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Tracun on 07/01/2017.
 */

public class GerenciaBD {

    private SQLiteDatabase bd;

    public GerenciaBD(Context context) {
        BDCore auxBD = new BDCore(context);
        bd = auxBD.getWritableDatabase();

    }

    void teste() {

        Cursor cursor = bd.rawQuery("SELECT COUNT(*) FROM produtos", null);

        if (cursor != null) {
            cursor.moveToFirst();
            if (cursor.getInt(0) == 0) {
                System.out.println("Tabela zerada");
            } else {

                while (cursor.moveToNext()) {
                    int i = 0;
                    System.out.println("Possui dados: " + cursor.getInt(i));
                    i++;
                }

                System.out.println("Possui dados: " + cursor.getCount());
            }
        }

//        cursor.close();
    }


    public String inserir(Produto produto) {

        String msg;

        ContentValues valores = new ContentValues();

        valores.put("nome", produto.getNome());
        valores.put("custo", produto.getCusto());
        valores.put("encargo", produto.getEncargo());
        valores.put("comissao", produto.getComissao());
        valores.put("lucro", produto.getLucro());
        valores.put("outro", produto.getOutros());
        valores.put("imp1", produto.getImp1());
        valores.put("imp2", produto.getImp2());
        valores.put("custoIndireto", produto.getCustoIndireto());
        valores.put("precoFora", produto.getPrecoFora());
        valores.put("precoDentro", produto.getPrecoDentro());
        valores.put("uriImg", produto.getUriImg());

        long resultado = bd.insert("produtos", null, valores);

        if (resultado == -1)
            msg = "Erro ao inserir registro";
        else
            msg = "Adicionado com sucesso !";

        bd.close();


        return msg;

    }

    public Cursor buscaDadoById(int id) {
        Cursor cursor;
        String[] campos = {"_id", "nome", "custo", "encargo", "comissao", "lucro", "outro", "imp1", "imp2", "custoIndireto", "precoFora", "precoDentro", "uriImg"};
        String where = "_id" + "=" + id;
        cursor = bd.query("produtos", campos, where, null, null, null, null, null);

        if (cursor != null) {
            cursor.moveToFirst();
        }

        bd.close();

        Produto produto = new Produto();
        produto.setId(cursor.getInt(1));
        produto.setNome(cursor.getString(2));
        produto.setCusto(cursor.getDouble(3));
        produto.setEncargo(cursor.getFloat(4));
        produto.setComissao(cursor.getFloat(5));
        produto.setLucro(cursor.getFloat(6));
        produto.setOutros(cursor.getFloat(7));
        produto.setImp1(cursor.getFloat(8));
        produto.setImp2(cursor.getFloat(9));
        produto.setCustoIndireto(cursor.getFloat(10));
        produto.setPrecoFora(cursor.getDouble(11));
        produto.setPrecoDentro(cursor.getDouble(12));
        produto.setUriImg(cursor.getString(13));

//        cursor.close();

        return cursor;
    }

    public ArrayList buscarTodos() {
        String[] colunas = {"_id", "nome", "custo", "encargo", "comissao", "lucro", "outro", "imp1", "imp2", "custoIndireto", "precoFora", "precoDentro", "uriImg"};

        String nome = "";
        String id = "";
        ArrayList arrayProdutos = null;
        Produto produto;

        Cursor cursor = bd.query("produtos", colunas, null, null, null, null, null);

        if (!(cursor.getCount() <= 0)) {
            cursor.moveToFirst();
            arrayProdutos = new ArrayList();
            do {
                produto = new Produto();
                produto.setId(cursor.getInt(0));
                produto.setNome(cursor.getString(1));
                produto.setCusto(Double.parseDouble(cursor.getString(2)));
                produto.setEncargo(Float.parseFloat(cursor.getString(3)));
                produto.setComissao(Float.parseFloat(cursor.getString(4)));
                produto.setLucro(Float.parseFloat(cursor.getString(5)));
                produto.setOutros(Float.parseFloat(cursor.getString(6)));
                produto.setImp1(Float.parseFloat(cursor.getString(7)));
                produto.setImp2(Float.parseFloat(cursor.getString(8)));
                produto.setCustoIndireto(Float.parseFloat(cursor.getString(9)));
                produto.setPrecoFora(Double.parseDouble(cursor.getString(10)));
                produto.setPrecoDentro(Double.parseDouble(cursor.getString(11)));
                produto.setUriImg(cursor.getString(12));

                arrayProdutos.add(produto);

            } while (cursor.moveToNext());
        }
//        bd.close();
//        cursor.close();

        return arrayProdutos;
    }

    public ArrayList buscaString() {

        String[] colunas = {"_id", "nome"};

        String nome = "";
        String id = "";
        ArrayList array = null;

        Cursor cursor = bd.query("produtos", colunas, null, null, null, null, null);

        if (!(cursor.getCount() <= 0)) {
            cursor.moveToFirst();
            array = new ArrayList();
            do {
                id = String.valueOf(cursor.getLong(0));
                nome = cursor.getString(1);

                array.add(id + " - " + nome);

            } while (cursor.moveToNext());
        }

//        bd.close();
//        cursor.close();

        return array;
    }

    public void atualiazar(Produto produto) {

        ContentValues valores = new ContentValues();
        valores.put("nome", produto.getNome());
        valores.put("custo", produto.getCusto());
        valores.put("encargo", produto.getEncargo());
        valores.put("comissao", produto.getComissao());
        valores.put("lucro", produto.getLucro());
        valores.put("outro", produto.getOutros());
        valores.put("imp1", produto.getImp1());
        valores.put("imp2", produto.getImp2());
        valores.put("custoIndireto", produto.getCustoIndireto());
        valores.put("precoFora", produto.getPrecoFora());
        valores.put("precoDentro", produto.getPrecoDentro());
        valores.put("uriImg", produto.getUriImg());

        bd.update("usuario", valores, "_id = ?", new String[]{"" + produto.getId()});
        bd.close();

    }

    public int deletar(Produto produto) {

        try {
            bd.delete("produtos", "_id = ?", new String[]{"" + produto.getId()});
            bd.close();
        } catch (Exception e) {
            bd.close();
            e.printStackTrace();
            return -1;
        }

        return 0;
    }


}
