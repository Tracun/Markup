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
import com.wb.tracun.markup.model.TempoFab;

import java.util.ArrayList;

/**
 * A simple {@link Fragment} subclass.
 */
public class ProdutoTempoFabFragment extends Fragment {

    static ArrayList<TempoFab> listaTempoFabProduto = new ArrayList();

    Spinner spinner;
    Button btnAdd;
    EditText txtTempo;

    ListView listView;
    GerenciaBD gerenciaBD;

    TempoFab tempoFab;

    ArrayList<TempoFab> listaTempoFabBD = new ArrayList();
    ArrayList listaTempoFabListView;
    ArrayAdapter adapter;

    public ProdutoTempoFabFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_produto_tempo_fab, container, false);

        defineFragmentTempFab(view);
        catchTempoFab();
        carregarListaTempoFabProduto();

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, final long id) {
                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                builder.setMessage("Deseja excluir este insumo?");

                builder.setPositiveButton("Sim", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                        listaTempoFabProduto.remove(position);
                        carregarListaTempoFabProduto();
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

                if(txtTempo.getText().toString().equals("") || Float.parseFloat(txtTempo.getText().toString()) <= 0){
                    txtTempo.setError("Campo vazio ou inválido:(");
                }else if(spinner.getSelectedItem().toString().equals("")){
                    Toast.makeText(getActivity(), "Escolha a unidade do insumo", Toast.LENGTH_SHORT).show();
                    System.out.println("Erro spinner vazio");
                }else{

                    int index = TempoFabAlreadyExist(listaTempoFabBD.get((int)spinner.getSelectedItemId()));

                    if(index >=0){
                        //Atualiaza a quantidade do insumo
                        float quantAux = listaTempoFabProduto.get(index).getTempo();
                        listaTempoFabProduto.get(index).setTempo(quantAux + Float.parseFloat(txtTempo.getText().toString()));

                        //Atualiza ValorTotal
                        listaTempoFabProduto.get(index).calcularValorTotal();

                        //Popula o listView
                        carregarListaTempoFabProduto();
                    }else{
                        listaTempoFabBD.get((int)spinner.getSelectedItemId()).setTempo(Float.parseFloat(txtTempo.getText().toString()));
                        //Adiciona os Tempos de fabricacao do produto em uma lista
                        addFab(spinner.getSelectedItemId());

                        //Popula o listView
                        carregarListaTempoFabProduto();
                        clearEditText();
                    }
                }
            }
        });

        return view;
    }

    private void clearEditText() {
        txtTempo.setText("");
    }

    private void carregarListaTempoFabProduto() {

        ArrayList aux = new ArrayList();

        if(listaTempoFabProduto.size() > 0){

            for (TempoFab t: listaTempoFabProduto) {
                aux.add(t.getNome() + " - R$ " + t.getValorHora() + " - Tempo: " + t.getTempo() + "/hora");
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }else{
            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, aux);
            listView.setAdapter(adapter);
        }
    }

    void defineFragmentTempFab(View view){

        spinner = (Spinner) view.findViewById(R.id.spinnerTempos);
        btnAdd = (Button) view.findViewById(R.id.btnAddTempo);
        txtTempo = (EditText) view.findViewById(R.id.txtTemp);
        listView = (ListView) view.findViewById(R.id.listTempoFab);
    }

    void catchTempoFab(){
        try{
            gerenciaBD = new GerenciaBD(getActivity());
            Cursor cursor = gerenciaBD.buscaTempoFab();
            listaTempoFabListView = new ArrayList();

            while(cursor.moveToNext()){
//                System.out.println("catchDespesa: Id: " + cursor.getString(0));
//                System.out.println("catchDespesa: Descricao: " + cursor.getString(1));
//                System.out.println("catchDespesa: Valor hora: R$ " + cursor.getString(2));

                tempoFab = new TempoFab();
                tempoFab.setId(cursor.getInt(0));
                tempoFab.setNome(cursor.getString(1));
                tempoFab.setValorHora(cursor.getFloat(2));

                //Adiciona os tempos de fabricacao na lista para somar os custos
                listaTempoFabBD.add(tempoFab);
            }

            //Adiciona os itens para o listView
            for (int i = 0; i < listaTempoFabBD.size(); i++) {
                listaTempoFabListView.add(listaTempoFabBD.get(i).getId() + " - " + listaTempoFabBD.get(i).getNome() + " - " + listaTempoFabBD.get(i).getValorHora());
            }

            adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1, listaTempoFabListView);
            spinner.setAdapter(adapter);

        }catch(Exception e){
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }

    void addFab(long posicao){
        listaTempoFabProduto.add(listaTempoFabBD.get((int)posicao));

        float valorTotal = listaTempoFabProduto.get(listaTempoFabProduto.size()-1).getValorHora() * listaTempoFabProduto.get(listaTempoFabProduto.size()-1).getTempo();
        listaTempoFabProduto.get(listaTempoFabProduto.size()-1).setValorTotal(valorTotal);

    }

    static float calcularCustosTempoFab(){

        float valorTotalTempoFab = 0;

        for(TempoFab t: listaTempoFabProduto){
            valorTotalTempoFab += t.getValorTotal();
        }
        return valorTotalTempoFab;
    }

    int TempoFabAlreadyExist(TempoFab t){
        int index = 0;
        for (TempoFab obj:listaTempoFabProduto) {
            if(obj.getId() == t.getId()) return index;
            index++;
        }
        return -1;
    }
}
