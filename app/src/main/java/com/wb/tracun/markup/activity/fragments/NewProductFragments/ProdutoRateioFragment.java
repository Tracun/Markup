package com.wb.tracun.markup.activity.fragments.NewProductFragments;


import android.app.AlertDialog;
import android.content.DialogInterface;
import android.database.Cursor;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import com.wb.tracun.markup.DB.GerenciaBD;
import com.wb.tracun.markup.R;
import com.wb.tracun.markup.model.Rateio;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class ProdutoRateioFragment extends Fragment {

    static ArrayList<Rateio> listaRateiosProduto = new ArrayList();

    Spinner spinner;
    Button btnAdd;
    EditText txtQuant;
    EditText txtQuantProd;

    ListView listView;
    GerenciaBD gerenciaBD;

    Rateio rateio;

    ArrayList<Rateio> listaRateioBD = new ArrayList();
    ArrayList listaRateioListView;
    ArrayAdapter adapter;

    public ProdutoRateioFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_produto_rateio, container, false);

        defineFragmentRateio(view);
        catchRateio();
        carregarListaRateioProduto();

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, final long id) {
                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                builder.setMessage("Deseja excluir este rateio?");

                builder.setPositiveButton("Sim", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                        listaRateiosProduto.remove(position);
                        carregarListaRateioProduto();
                    }
                });

                builder.setNegativeButton("Não", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });

                AlertDialog alertDialog = builder.create();
                alertDialog.show();
            }
        });

        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if(txtQuant.getText().toString().equals("") || Float.parseFloat(txtQuant.getText().toString()) <= 0){
                    txtQuant.setError("Campo vazio ou inválido:(");
                }else if(txtQuantProd.getText().toString().equals("")  || Float.parseFloat(txtQuantProd.getText().toString()) <= 0) {
                    txtQuantProd.setError("Campo vazio ou inválido:(");
                }else if(spinner.getSelectedItem().toString().equals("")){
                    Toast.makeText(getActivity(), "Escolha a unidade do insumo", Toast.LENGTH_SHORT).show();
                    System.out.println("Erro spinner vazio");
                }else{

                    int index = rateioAlreadyExist(listaRateioBD.get((int)spinner.getSelectedItemId()));

                    if(index >=0) {
                        //Atualiaza a quantidade do insumo
                        float quantAux = listaRateiosProduto.get(index).getQuantidade();
                        listaRateiosProduto.get(index).setQuantidade(quantAux + Float.parseFloat(txtQuant.getText().toString()));

                        //Atualiza ValorTotal
                        listaRateiosProduto.get(index).calcularValorTotal();

                        //Popula o listView
                        carregarListaRateioProduto();
                    }else{
                        listaRateioBD.get((int)spinner.getSelectedItemId()).setQuantidade(Float.parseFloat(txtQuant.getText().toString()));
                        listaRateioBD.get((int)spinner.getSelectedItemId()).setQuantProduzida(Float.parseFloat(txtQuantProd.getText().toString()));
                        //Adiciona os insumos do produto em uma lista
                        addRateio(spinner.getSelectedItemId());

                        carregarListaRateioProduto();
                        clearEditText();
                    }
                }
            }
        });

        return view;
    }

    private void clearEditText() {
        txtQuant.setText("");
        txtQuantProd.setText("");
    }

    private void carregarListaRateioProduto() {

        ArrayList aux = new ArrayList();

        if(listaRateiosProduto.size() > 0){

            for (Rateio r: listaRateiosProduto) {
                aux.add(r.getDescricao() + " - R$ " + r.getValorUnitario() + " - Quant: " + r.getQuantidade() + " - Quant.Produzida: " + r.getQuantProduzida());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }else{
            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }
    }

    void defineFragmentRateio(View view){

        spinner = (Spinner) view.findViewById(R.id.spinnerRateio);
        btnAdd = (Button) view.findViewById(R.id.btnAddRateio);
        txtQuant = (EditText) view.findViewById(R.id.txtQuant);
        txtQuantProd = (EditText) view.findViewById(R.id.txtQuantProd);
        listView = (ListView) view.findViewById(R.id.listRateios);
    }

    void addRateio(long posicao){
        listaRateiosProduto.add(listaRateioBD.get((int)posicao));

        float valorTotal = (listaRateiosProduto.get(listaRateiosProduto.size()-1).getValorUnitario() * listaRateiosProduto.get(listaRateiosProduto.size()-1).getQuantidade()) /listaRateiosProduto.get(listaRateiosProduto.size()-1).getQuantProduzida();
        listaRateiosProduto.get(listaRateiosProduto.size()-1).setValorTotal(valorTotal);
    }

    void catchRateio(){
        try{
            gerenciaBD = new GerenciaBD(getActivity());
            Cursor cursor = gerenciaBD.buscaRateio();
            listaRateioListView = new ArrayList();
            cursor.moveToFirst();

            while(!cursor.isLast()){
//                System.out.println("catchRateio: Id: " + cursor.getString(0));
//                System.out.println("catchRateio: Descricao: " + cursor.getString(1));
//                System.out.println("catchRateio: Valor unit: R$ " + cursor.getString(2));
                System.out.println("catchRateio: idUnidade: " + cursor.getString(1));

                rateio = new Rateio();
                rateio.setId(cursor.getInt(0));
                rateio.setPosicaoUnid(cursor.getInt(1));
                rateio.setDescricao(cursor.getString(2));
                rateio.setValorUnitario(cursor.getFloat(3));


                //Adiciona os rateios para recuperar depois
                listaRateioBD.add(rateio);

                cursor.moveToNext();

            }

            if(cursor.isLast()){
                rateio = new Rateio();
                rateio.setId(cursor.getInt(0));
                rateio.setDescricao(cursor.getString(1));
                rateio.setValorUnitario(cursor.getFloat(2));
                rateio.setPosicaoUnid(cursor.getInt(3));

                //Adiciona os rateios para recuperar depois
                listaRateioBD.add(rateio);
            }

            //Adiciona os itens para o listView
            for (int i = 0; i < listaRateioBD.size(); i++) {
                listaRateioListView.add(listaRateioBD.get(i).getId() + " - " + listaRateioBD.get(i).getDescricao() + " - " + listaRateioBD.get(i).getValorUnitario());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, listaRateioListView);
            spinner.setAdapter(adapter);

        }catch(Exception e){
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }

    static float calcularCustosRateio(){
        float valorTotalRateio = 0;

        for(Rateio r: listaRateiosProduto){
            valorTotalRateio += r.getValorTotal();
        }

        System.out.println("VALOR TOTAL RATEIO: " + valorTotalRateio);
        return valorTotalRateio;
    }

    int rateioAlreadyExist(Rateio r){
        int index = 0;
        for (Rateio obj:listaRateiosProduto) {
            if(obj.getId() == r.getId()) return index;
            index++;
        }
        return -1;
    }
}
