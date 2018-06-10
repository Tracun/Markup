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
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import com.wb.tracun.markup.DB.GerenciaBD;
import com.wb.tracun.markup.R;
import com.wb.tracun.markup.model.DespesaAdm;
import com.wb.tracun.markup.model.Produto;

import java.util.ArrayList;

/**
 * A simple {@link Fragment} subclass.
 */
public class ProdutoDespesaFragment extends Fragment {

    static ArrayList<DespesaAdm> listaDespesasProduto = new ArrayList();

    Spinner spinner;
    Button btnAdd;

    ListView listView;
    GerenciaBD gerenciaBD;

    DespesaAdm despesaAdm;

    ArrayList<DespesaAdm> listaDespesasBD = new ArrayList();
    ArrayList listaDespesaListView;
    ArrayAdapter adapter;

    Produto produto = new Produto();

    public ProdutoDespesaFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_produto_despesa, container, false);

        defineFragmentDespesa(view);
        catchDespesa();
        carregarListaDespesaProduto();

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, final long id) {
                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                builder.setMessage("Deseja excluir esta despesa?");

                builder.setPositiveButton("Sim", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                        listaDespesasProduto.remove(position);
                        carregarListaDespesaProduto();
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

                if(spinner.getSelectedItem().toString().equals("")){
                    Toast.makeText(getActivity(), "Escolha a despesa", Toast.LENGTH_SHORT).show();
                    System.out.println("Erro spinner vazio");
                }else{

                    int index = despesaAlreadyExist(listaDespesasBD.get((int)spinner.getSelectedItemId()));

                    if(index >=0) {
                        Toast.makeText(getActivity(), "Despesa já inserida para este produto", Toast.LENGTH_SHORT).show();
                    }else{
                        //Adiciona as despesas do produto em uma lista
                        addDespesa(spinner.getSelectedItemId());

                        //Popula o listView
                        carregarListaDespesaProduto();
                    }
                }
            }
        });
        return view;
    }

    private void carregarListaDespesaProduto() {

        ArrayList aux = new ArrayList();

        if(listaDespesasProduto.size() > 0){

            for (DespesaAdm d: listaDespesasProduto) {
                aux.add(d.getDescricao() + " - R$ " + d.getValor());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }else{
            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }
    }

    void defineFragmentDespesa(View view){
        spinner = (Spinner) view.findViewById(R.id.spinnerDespesa);
        btnAdd = (Button) view.findViewById(R.id.btnAddDespesa);
        listView = (ListView) view.findViewById(R.id.listDespesas);
    }

    void catchDespesa(){
        try{
            gerenciaBD = new GerenciaBD(getActivity());
            Cursor cursor = gerenciaBD.buscaDespesas();
            listaDespesaListView = new ArrayList();

            while(cursor.moveToNext()){
                System.out.println("catchDespesa: Id: " + cursor.getString(0));
                System.out.println("catchDespesa: Descricao: " + cursor.getString(1));
                System.out.println("catchDespesa: Valor hora: R$ " + cursor.getString(2));

                despesaAdm = new DespesaAdm();
                despesaAdm.setId(cursor.getInt(0));
                despesaAdm.setDescricao(cursor.getString(1));
                despesaAdm.setValor(cursor.getFloat(2));

                //Adiciona as despesas na lista para somar os custos
                listaDespesasBD.add(despesaAdm);
            }

            //Adiciona os itens para o listView
            for (int i = 0; i < listaDespesasBD.size(); i++) {
                listaDespesaListView.add(listaDespesasBD.get(i).getId() + " - " + listaDespesasBD.get(i).getDescricao() + " - " + listaDespesasBD.get(i).getValor());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, listaDespesaListView);
            spinner.setAdapter(adapter);

        }catch(Exception e){
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }

    void addDespesa(long posicao){
        listaDespesasProduto.add(listaDespesasBD.get((int)posicao));
    }

    static float calcularCustosDespesa(){

        float valorTotalDespesa = 0;

        for(DespesaAdm d: listaDespesasProduto){
            valorTotalDespesa += d.getValor();
        }
        return valorTotalDespesa;
    }

    int despesaAlreadyExist(DespesaAdm d){
        int index = 0;
        for (DespesaAdm obj:listaDespesasProduto) {
            if(obj.getId() == d.getId()) return index;
            index++;
        }
        return -1;
    }

}
