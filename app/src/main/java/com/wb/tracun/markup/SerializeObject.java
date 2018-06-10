package com.wb.tracun.markup;

import com.wb.tracun.markup.Interfaces.ISerializeObject;
import com.wb.tracun.markup.model.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

/**
 * Created by Tracun on 29/11/2017.
 */
/**Serializa os objetos transformando em bytes e salvando-os
 *  no armazenamento, para posterior recuperacao em outra tela ou afins
 */
public class SerializeObject implements ISerializeObject{

    @Override
    public Insumo WriteSerializeObject(Insumo insumo, String name, File dir) {

        try {

            /**
             * FileOutputStream responsavel por criar o arquivo fisicamento
             * no disco, assim poderemos realizar a escrita nele.
             */
            FileOutputStream fout = new FileOutputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por escrever os objetos no arquivo criado anteriormente
             */

            ObjectOutputStream oos = new ObjectOutputStream(fout);


            /**
             * writeObject ja grava o nosso objeto de forma serializada(bytes)
             */
            oos.writeObject(insumo);
            oos.close();

            return insumo;

        } catch (Exception e) {
            System.out.println("Erro ao criar arquivo serializado : " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public DespesaAdm WriteSerializeObject(DespesaAdm despesaAdm, String name, File dir) {

        try {

            /**
             * FileOutputStream responsavel por criar o arquivo fisicamento
             * no disco, assim poderemos realizar a escrita nele.
             */
            FileOutputStream fout = new FileOutputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por escrever os objetos no arquivo criado anteriormente
             */

            ObjectOutputStream oos = new ObjectOutputStream(fout);


            /**
             * writeObject ja grava o nosso objeto de forma serializada(bytes)
             */
            oos.writeObject(despesaAdm);
            oos.close();

            return despesaAdm;

        } catch (Exception e) {
            System.out.println("Erro ao criar arquivo serializado : " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public TempoFab WriteSerializeObject(TempoFab tempoFab, String name, File dir) {

        try {

            /**
             * FileOutputStream responsavel por criar o arquivo fisicamento
             * no disco, assim poderemos realizar a escrita nele.
             */
            FileOutputStream fout = new FileOutputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por escrever os objetos no arquivo criado anteriormente
             */

            ObjectOutputStream oos = new ObjectOutputStream(fout);


            /**
             * writeObject ja grava o nosso objeto de forma serializada(bytes)
             */
            oos.writeObject(tempoFab);
            oos.close();

            return tempoFab;

        } catch (Exception e) {
            System.out.println("Erro ao criar arquivo serializado : " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Rateio WriteSerializeObject(Rateio rateio, String name, File dir) {

        try {

            /**
             * FileOutputStream responsavel por criar o arquivo fisicamento
             * no disco, assim poderemos realizar a escrita nele.
             */
            FileOutputStream fout = new FileOutputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por escrever os objetos no arquivo criado anteriormente
             */

            ObjectOutputStream oos = new ObjectOutputStream(fout);


            /**
             * writeObject ja grava o nosso objeto de forma serializada(bytes)
             */
            oos.writeObject(rateio);
            oos.close();

            return rateio;

        } catch (Exception e) {
            System.out.println("Erro ao criar arquivo serializado : " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

//    @Override
//    public com.wb.tracun.markup.model.Produto WriteSerializeObject(com.wb.tracun.markup.model.Produto produto, String name, File dir) {
//
//    }

    @Override
    public com.wb.tracun.markup.model.Produto WriteSerializeObject(com.wb.tracun.markup.model.Produto produto, String name, File dir) {

        try {

            /**
             * FileOutputStream responsavel por criar o arquivo fisicamento
             * no disco, assim poderemos realizar a escrita nele.
             */
            FileOutputStream fout = new FileOutputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por escrever os objetos no arquivo criado anteriormente
             */

            ObjectOutputStream oos = new ObjectOutputStream(fout);


            /**
             * writeObject ja grava o nosso objeto de forma serializada(bytes)
             */
            oos.writeObject(produto);
            oos.close();

            return produto;

        } catch (Exception e) {
            System.out.println("Erro ao criar arquivo serializado : " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Insumo readSerializeObject(Insumo insumo, String name, File dir) {

        try {

            /**
             * FileInputStream responsavel por carregar o arquivo
             */
            FileInputStream fin = new FileInputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por ler o objeto
             */
            ObjectInputStream ois = new ObjectInputStream(fin);

            /**
             * Converte nosso arquivo que contem o objeto serializado, em uma nova
             * instancia de objeto
             */
            insumo = (Insumo) ois.readObject();
            ois.close();
            return insumo;

        } catch (Exception e) {
            System.out.println("Erro ao converter o arquivo serializado: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public DespesaAdm readSerializeObject(DespesaAdm despesaAdm, String name, File dir) {

        try {

            /**
             * FileInputStream responsavel por carregar o arquivo
             */
            FileInputStream fin = new FileInputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por ler o objeto
             */
            ObjectInputStream ois = new ObjectInputStream(fin);

            /**
             * Converte nosso arquivo que contem o objeto serializado, em uma nova
             * instancia de objeto
             */
            despesaAdm = (DespesaAdm) ois.readObject();
            ois.close();
            return despesaAdm;

        } catch (Exception e) {
            System.out.println("Erro ao converter o arquivo serializado: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public TempoFab readSerializeObject(TempoFab tempoFab, String name, File dir) {

        try {

            /**
             * FileInputStream responsavel por carregar o arquivo
             */
            FileInputStream fin = new FileInputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por ler o objeto
             */
            ObjectInputStream ois = new ObjectInputStream(fin);

            /**
             * Converte nosso arquivo que contem o objeto serializado, em uma nova
             * instancia de objeto
             */
            tempoFab = (TempoFab) ois.readObject();
            ois.close();
            return tempoFab;

        } catch (Exception e) {
            System.out.println("Erro ao converter o arquivo serializado: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public Rateio readSerializeObject(Rateio rateio, String name, File dir) {

        try {

            /**
             * FileInputStream responsavel por carregar o arquivo
             */
            FileInputStream fin = new FileInputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por ler o objeto
             */
            ObjectInputStream ois = new ObjectInputStream(fin);

            /**
             * Converte nosso arquivo que contem o objeto serializado, em uma nova
             * instancia de objeto
             */
            rateio = (Rateio) ois.readObject();
            ois.close();
            return rateio;

        } catch (Exception e) {
            System.out.println("Erro ao converter o arquivo serializado: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

    }

//    @Override
//    public com.wb.tracun.markup.model.Produto readSerializeObject(com.wb.tracun.markup.model.Produto produto, String name, File dir) {
//        return null;
//    }


    public com.wb.tracun.markup.model.Produto readSerializeObject(com.wb.tracun.markup.model.Produto produto, String name, File dir) {

        try {

            /**
             * FileInputStream responsavel por carregar o arquivo
             */
            FileInputStream fin = new FileInputStream(dir + "\\" + name + ".ser");

            /**
             * Responsavel por ler o objeto
             */
            ObjectInputStream ois = new ObjectInputStream(fin);

            /**
             * Converte nosso arquivo que contem o objeto serializado, em uma nova
             * instancia de objeto
             */
            produto = (com.wb.tracun.markup.model.Produto) ois.readObject();
            ois.close();
            return produto;

        } catch (Exception e) {
            System.out.println("Erro ao converter o arquivo serializado: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

    }
}
