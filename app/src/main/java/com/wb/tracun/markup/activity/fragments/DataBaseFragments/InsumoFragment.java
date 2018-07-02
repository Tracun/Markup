package com.wb.tracun.markup.activity.fragments.DataBaseFragments;


import android.database.Cursor;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.wb.tracun.markup.DB.GerenciaBD;
import com.wb.tracun.markup.R;
import com.wb.tracun.markup.model.Insumo;

import java.util.ArrayList;

/**
 * A simple {@link Fragment} subclass.
 */
public class InsumoFragment extends Fragment {

    Button btnCadas;
    Button btnAtualizarUnidades;
    EditText txtDescricao;
    EditText txtValUnit;
    Spinner spinner;
    GerenciaBD gerenciaBD;
    ArrayList<Integer> listIdUnid;

    public InsumoFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_insumo, container, false);

        defineFragmentInsumos(view);
        catchUnidades();

        btnAtualizarUnidades.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                catchUnidades();
            }
        });

        btnCadas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if(txtDescricao.getText().toString().equals("")){
                    txtDescricao.setError("Campo vazio :(");
                }else if(txtValUnit.getText().toString().equals("")){
                    txtValUnit.setError("Campo vazio :(");
                }else if(spinner.getSelectedItem().toString().equals("")){
                    Toast.makeText(getActivity(), "Escolha a unidade do insumo", Toast.LENGTH_SHORT).show();
                }else{
                    saveInsumo(v);
                }
            }
        });

        return view;
    }

    //Define as unidades no spinner
    void catchUnidades(){
        try{
            gerenciaBD = new GerenciaBD(getActivity());
            Cursor cursor = gerenciaBD.buscaUnidades();

            if(cursor != null){
                ArrayList list = new ArrayList();
                listIdUnid = new ArrayList();
                cursor.moveToFirst();

                while(!cursor.isLast()){
                    listIdUnid.add(cursor.getInt(0));
                    list.add(cursor.getString(1));

                    cursor.moveToNext();

                    if(cursor.isLast()){
                        listIdUnid.add(cursor.getInt(0));
                        list.add(cursor.getString(1));
                    }
                }

                ArrayAdapter adapterUnid = new ArrayAdapter(getActivity(), android.R.layout.simple_spinner_dropdown_item, list);
                spinner.setAdapter(adapterUnid);
            }

        }catch(Exception e){
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }

    void saveInsumo(View v){

        gerenciaBD = new GerenciaBD(v.getContext());

        Insumo insumo = new Insumo();
        insumo.setNome(txtDescricao.getText().toString());
        insumo.setValorUnitario(Float.parseFloat(txtValUnit.getText().toString()));
        insumo.setPosicaoUnid(listIdUnid.get(spinner.getSelectedItemPosition()));

        if(gerenciaBD.saveInsumo(insumo) > 0){
            Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
            txtDescricao.setText("");
            txtValUnit.setText("");
        }else{
            Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
        }
    }

    void defineFragmentInsumos(View view){
        spinner = (Spinner) view.findViewById(R.id.spinner);
        btnCadas = (Button) view.findViewById(R.id.btnCadas);
        btnAtualizarUnidades = (Button) view.findViewById(R.id.btnAtualizarUnidades);
        txtDescricao = (EditText) view.findViewById(R.id.txtDescricao);
        txtValUnit = (EditText) view.findViewById(R.id.txtValUnit);
    }
}
