package com.wb.tracun.markup.activity.fragments.DataBaseFragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.wb.tracun.markup.DB.GerenciaBD;
import com.wb.tracun.markup.R;
import com.wb.tracun.markup.model.TempoFab;

/**
 * A simple {@link Fragment} subclass.
 */
public class TemposFabFragment extends Fragment {

    EditText txtDescricao;
    EditText txtValHora;
    Button btnCadas;

    public TemposFabFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_tempos_fab, container, false);

        defineFragmentTempFab(view);

        btnCadas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if(txtDescricao.getText().toString().equals("")){
                    txtDescricao.setError("Campo vazio :(");
                }else if(txtValHora.getText().toString().equals("")){
                    txtValHora.setError("Campo vazio :(");
                }else{
                    saveTempoFab(v);
                }
            }
        });

        return view;
    }

    void defineFragmentTempFab(View view){
        btnCadas = (Button) view.findViewById(R.id.btnCadas);
        txtDescricao = (EditText) view.findViewById(R.id.txtDescricao);
        txtValHora = (EditText) view.findViewById(R.id.txtValHora);
    }

    void saveTempoFab(View v){

        GerenciaBD gerenciaBD = new GerenciaBD(v.getContext());

        TempoFab tempoFab = new TempoFab();
        tempoFab.setNome(txtDescricao.getText().toString());
        tempoFab.setValorHora(Float.parseFloat(txtValHora.getText().toString()));

        if(gerenciaBD.saveTempoFab(tempoFab) > 0){
            Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
            txtDescricao.setText("");
            txtValHora.setText("");
        }else{
            Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
        }
    }
}
