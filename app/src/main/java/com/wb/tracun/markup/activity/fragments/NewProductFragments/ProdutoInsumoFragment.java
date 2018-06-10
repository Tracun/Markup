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
import com.wb.tracun.markup.model.Insumo;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class ProdutoInsumoFragment extends Fragment {
    static ArrayList<Insumo> listaInsumosProduto = new ArrayList<Insumo>();

    Spinner spinner;
    Button btnAdd;
    EditText txtQuant;

    ListView listView;
    GerenciaBD gerenciaBD;

    Insumo insumo = new Insumo();

    ArrayList<Insumo> listaInsumosBD = new ArrayList();
    ArrayList listaInsumoListView;
    ArrayAdapter adapter;

    public ProdutoInsumoFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        final View view = inflater.inflate(R.layout.fragment_produto_insumo, container, false);

        defineFragmentInsumos(view);
        catchInsumo();
        //Popula o listView
        carregarListaInsumoProduto();

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, final long id) {
                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                builder.setMessage("Deseja excluir este insumo?");

                builder.setPositiveButton("Sim", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                        listaInsumosProduto.remove(position);
                        carregarListaInsumoProduto();
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
                }else if(spinner.getSelectedItem().toString().equals("")){
                    Toast.makeText(getActivity(), "Escolha a unidade do insumo", Toast.LENGTH_SHORT).show();
                }else{

                    int index = insumoAlreadyExist(listaInsumosBD.get((int)spinner.getSelectedItemId()));

                    if(index >=0){
                        //Atualiaza a quantidade do insumo
                        float quantAux = listaInsumosProduto.get(index).getQuantidade();
                        listaInsumosProduto.get(index).setQuantidade(quantAux + Float.parseFloat(txtQuant.getText().toString()));

                        //Atualiza ValorTotal
                        listaInsumosProduto.get(index).calcularValorTotal();

                        //Popula o listView
                        carregarListaInsumoProduto();
                    }else{
                        insumo.setQuantidade(Float.parseFloat(txtQuant.getText().toString()));
                        insumo.setValorTotal(Float.parseFloat(txtQuant.getText().toString()) * insumo.getValorUnitario());

                        //Qualquer coisa, inverter essas duas linhas 81 e 83
                        listaInsumosBD.get((int)spinner.getSelectedItemId()).setQuantidade(Float.parseFloat(txtQuant.getText().toString()));
                        //Adiciona os insumos do produto em uma lista
                        addInsumo(spinner.getSelectedItemId());

                        //Popula o listView
                        carregarListaInsumoProduto();
                        clearEditText();
                    }
                }
            }
        });
        return view;
    }

    private void clearEditText() {
        txtQuant.setText("");
    }

    private void carregarListaInsumoProduto() {

        ArrayList aux = new ArrayList();

        if(listaInsumosProduto.size() > 0){

            for (Insumo i: listaInsumosProduto) {
                aux.add(i.getNome() + " - R$ " + i.getValorUnitario() + " - Quant: " + i.getQuantidade());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }else{
            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }
    }

    void defineFragmentInsumos(View view){
        spinner = (Spinner) view.findViewById(R.id.spinnerInsumo);
        btnAdd = (Button) view.findViewById(R.id.btnAddInsumo);
        txtQuant = (EditText) view.findViewById(R.id.txtQuant);
        listView = (ListView) view.findViewById(R.id.listInsumos);
    }

    void catchInsumo() {
        try{
            gerenciaBD = new GerenciaBD(getActivity());
            Cursor cursor = gerenciaBD.buscaInsumos();
            listaInsumoListView = new ArrayList();

            while(cursor.moveToNext()){
//                System.out.println("catchInsumo: Id: " + cursor.getString(0));
//                System.out.println("catchInsumo: nome: " + cursor.getString(1));
//                System.out.println("catchInsumo: Valor unit: R$ " + cursor.getString(2));
//                System.out.println("catchInsumo: idUnidade: " + cursor.getString(3));

                Insumo insumoAux = new Insumo();
                insumoAux.setId(cursor.getInt(0));
                insumoAux.setNome(cursor.getString(1));
                insumoAux.setValorUnitario(cursor.getFloat(2));
                insumoAux.setPosicaoUnid(cursor.getInt(3));

                //Adiciona os insumos para recuperar depois
                listaInsumosBD.add(insumoAux);
            }
            //Adiciona os itens para o listView
            for (int i = 0; i < listaInsumosBD.size(); i++) {
                listaInsumoListView.add(listaInsumosBD.get(i).getId() + " - " + listaInsumosBD.get(i).getNome() + " - " + listaInsumosBD.get(i).getValorUnitario());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, listaInsumoListView);
            spinner.setAdapter(adapter);

        }catch(Exception e){
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }

    void addInsumo(long posicao){

        listaInsumosProduto.add(listaInsumosBD.get((int)posicao));

        //Ultimo insumo cadastrado
        posicao = listaInsumosProduto.size()-1;
        listaInsumosProduto.get((int)posicao).calcularValorTotal();
    }

    static float calcularCustosInsumos(){

        float valorTotalInsumos = 0;

        for(Insumo i: listaInsumosProduto){
            valorTotalInsumos += i.getValorTotal();
        }

        System.out.println("VALOR TOTAL INSUMOS: " + valorTotalInsumos);
        return valorTotalInsumos;
    }

    public void clearListas(){
        listaInsumosProduto.clear();

        if(listaInsumoListView != null){
            listaInsumoListView.clear();
            listaInsumosBD.clear();
            listView.setAdapter(null);
        }
    }

    int insumoAlreadyExist(Insumo i){
        int index = 0;
        for (Insumo obj:listaInsumosProduto) {
            if(obj.getId() == i.getId()) return index;
            index++;
        }
        return -1;
    }
}