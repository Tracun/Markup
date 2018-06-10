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
import com.wb.tracun.markup.model.Unidade;

/**
 * A simple {@link Fragment} subclass.
 */
public class UnidadesFragment extends Fragment {

    Button btnCadas;
    Button btnMenu;
    EditText txtDescricao;

    public UnidadesFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_unidades, container, false);
        defineFragmentUnidade(view);

        btnCadas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if(txtDescricao.getText().toString().equals("")){
                    txtDescricao.setError("Campo vazio :(");
                }else{
                    saveUnidades(v);
                }
            }
        });

//        btnMenu.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                Intent intencao = new Intent(getContext(), MainActivity.class);
//                startActivity(intencao);
//            }
//        });

        return view;
    }

    void defineFragmentUnidade(View view){
        btnCadas = (Button) view.findViewById(R.id.btnCadas);
        btnMenu = (Button) view.findViewById(R.id.btnMenu);
        txtDescricao = (EditText) view.findViewById(R.id.txtDescricao);
    }

    void saveUnidades(View v){

        GerenciaBD gerenciaBD = new GerenciaBD(v.getContext());

        Unidade unid = new Unidade();
        unid.setDescricao(txtDescricao.getText().toString());

        if(gerenciaBD.saveUnidade(unid) > 0){
            Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
            txtDescricao.setText("");
        }else{
            Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
        }
    }
}
