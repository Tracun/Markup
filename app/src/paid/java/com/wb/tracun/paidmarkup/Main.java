package com.wb.tracun.paidmarkup;

import com.wb.tracun.markup.GerenciaBD;
import com.wb.tracun.markup.R;
import com.wb.tracun.paidmarkup.Main.*;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;
import java.lang.*;

import java.util.ArrayList;

public class Main extends AppCompatActivity {
    // Remove the below line after defining your own ad unit ID.
    private static final String TOAST_TEXT = "Test ads are being shown. "
            + "To show live ads, replace the ad unit ID in res/values/strings.xml with your own ad unit ID.";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Load an ad into the AdMob banner view.
//        AdView adView = (AdView) findViewById(R.id.adView);
//        AdRequest adRequest = new AdRequest.Builder()
//                .setRequestAgent("android_studio:ad_template").build();
//        adView.loadAd(adRequest);

        // Toasts the test ad message on the screen. Remove this after defining your own ad unit ID.
//        Toast.makeText(this, TOAST_TEXT, Toast.LENGTH_LONG).show();

        final ListView list;
        list = (ListView) findViewById(R.id.list);
        final GerenciaBD db = new GerenciaBD(this);

        //Carrega os itens salvos no ListView
        View view;
        carregaLista(findViewById(R.id.activity_main));

        //Capta qual a posição do item selecionado
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            //Quando a selecionarem um item da lista, o mesmo será direcionado para outra tela
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                // ListView Clicked item index
                int posicaoItem = position;

                // ListView Clicked item value
                String itemValue = (String) list.getItemAtPosition(position);

                exibeTelaProdutoDetalhado(view,posicaoItem);

                //Show Alert
                Toast.makeText(getApplicationContext(), "Position :" + posicaoItem + "  ListItem : " + itemValue, Toast.LENGTH_LONG).show();

            }
        });

        botaoCarregaProdutosSalvos = (Button) findViewById(R.id.btnAtualizaLista);

        botaoCarregaProdutosSalvos.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                carregaLista(view);

            }
        });

    }

    Button botaoMsg;
    Button botaoCarregaProdutosSalvos;

    public void onBackPressed() {
        android.os.Process.killProcess(android.os.Process.myPid());
    }

    //Carrega os itens salvos na lista da tela Principal
    void carregaLista(View view){

        ListView list;

        list = (ListView) findViewById(R.id.list);

        GerenciaBD gerenciaBD = new GerenciaBD(this);

        ArrayList lista;
        Toast.makeText(this,"Nenhum produto cadastrado !",Toast.LENGTH_LONG);

        if(gerenciaBD.buscaString() != null){

            lista = gerenciaBD.buscaString();

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item,lista);
            list.setAdapter(adapter);

        }else{
            Toast.makeText(this,"Nenhum produto cadastrado !",Toast.LENGTH_LONG);
        }

    }

    public void exibeTelaCadastro2(View view){

        botaoMsg = (Button) findViewById(R.id.btnExibeMsg);
//        Toast.makeText(this, "Funcionei XD", Toast.LENGTH_LONG).show();

        Intent intencao = new Intent(this,Cadastro.class);
        startActivity(intencao);

    }

    //Chama a outra tela e passa como parametro a posicao
    public void exibeTelaProdutoDetalhado(View view, int posicaoListView){

        Intent intencao = new Intent(this,produtosSalvos.class);
        intencao.putExtra("posicao", posicaoListView);
        startActivity(intencao);
    }

}
