package com.wb.tracun.markup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.wb.tracun.markup.activity.CadastroBaseDadosActivity;
import com.wb.tracun.markup.activity.CadastroProdutoActivity;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class Main extends AppCompatActivity {

    Button btnBaseDados;

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            switch (item.getItemId()) {
                case R.id.cadastro_produto:
                    exibeTelaCadastro();
                    return true;

                case R.id.cadastro_base_dados:
//                    telaCadastroBaseDados();
                    Toast.makeText(getApplicationContext(), "Em breve XD", Toast.LENGTH_SHORT).show();
//                    telaCadastroBaseDados();
                    return true;

                case R.id.navigation_notifications:
                    Toast.makeText(getApplicationContext(), "Em breve XD", Toast.LENGTH_SHORT).show();
//                    telaCadastroProduto();
                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        try {
            // Load an ad into the AdMob banner view.
            AdView adView = (AdView) findViewById(R.id.adView);
            AdRequest adRequest = new AdRequest.Builder()
                    .setRequestAgent("android_studio:ad_template").build();
            adView.loadAd(adRequest);

        }catch (Exception e){
            System.out.println("Erro: " + e.getMessage());
        }

        final ListView list;
        list = (ListView) findViewById(R.id.list);
        final GerenciaBD db = new GerenciaBD(this);

        //Carrega os itens salvos no ListView
        View view;
        carregaLista(findViewById(R.id.activity_main));

        BottomNavigationView navigation = (BottomNavigationView) findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);

        list.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {

            public boolean onItemLongClick(AdapterView<?> arg0, final View v,
                                           final int index, long arg3) {


//                Toast.makeText(v.getContext(), "Posicao: " + list.getItemAtPosition(index), Toast.LENGTH_LONG).show();


                new AlertDialog.Builder(v.getContext())
                        .setTitle("Deletando produto")
                        .setMessage("Tem certeza que deseja deletar esse produto?")
                        .setPositiveButton("sim",
                                new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        Produto produto = new Produto();

                                        // ListView Clicked item value
                                        String itemValue = (String) list.getItemAtPosition(index);

                                        produto.setId(splitId(itemValue));

                                        Toast.makeText(getBaseContext(), "Posicao: " + itemValue, Toast.LENGTH_LONG).show();

                                        GerenciaBD gerenciaBD = new GerenciaBD(getBaseContext());

                                        if(gerenciaBD.deletar(produto) == -1){
                                            Toast.makeText(getBaseContext(), "Não consegui deletar o produto, tente novamente :( ", Toast.LENGTH_LONG).show();
                                        }else{
                                            list.setAdapter(null);
                                        }
                                        carregaLista(v);
                                    }
                                })
                        .setNegativeButton("não", null)
                        .show();
                return true;
            }
        });

        //Capta qual a posição do item selecionado
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            //Quando a selecionarem um item da lista, o mesmo será direcionado para outra tela
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

            // ListView Clicked item value
            String itemValue = (String) list.getItemAtPosition(position);

            //retira o ID da String da lista
            int idProduto = splitId(itemValue);
            exibeTelaProdutoDetalhado(view,idProduto);

            //Show Alert
            Toast.makeText(getApplicationContext(), "Position :" + position + "  ListItem : " + itemValue, Toast.LENGTH_LONG).show();

            }
        });

        //Botao esta oculto
//        botaoCarregaProdutosSalvos = (Button) findViewById(R.id.btnAtualizaLista);
//
//        botaoCarregaProdutosSalvos.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//            carregaLista(view);
//            }
//        });

    }

    Button botaoMsg;
    Button botaoCarregaProdutosSalvos;

//    public void onBackPressed() {
//        android.os.Process.killProcess(android.os.Process.myPid());
//    }

    //Carrega os itens salvos na lista da tela Principal
    void carregaLista(View view){

        ListView list;

        list = (ListView) findViewById(R.id.list);

        GerenciaBD gerenciaBD = new GerenciaBD(this);

        ArrayList lista;

//        Toast.makeText(this,"Nenhum produto cadastrado !",Toast.LENGTH_LONG).show();

        if(gerenciaBD.buscaString() != null){

            lista = gerenciaBD.buscaString();

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item,lista);
            list.setAdapter(adapter);
        }else{
//            Toast.makeText(this,"Nenhum produto cadastrado !",Toast.LENGTH_LONG).show();
        }

    }

    public void exibeTelaCadastro(){

        Intent intencao = new Intent(this,Cadastro.class);
        startActivity(intencao);
    }

    //Chama a outra tela e passa como parametro a posicao
    public void exibeTelaProdutoDetalhado(View view, int idProduto){

        Intent intencao = new Intent(this,produtosSalvos.class);
        intencao.putExtra("id", idProduto);
        startActivity(intencao);
    }

    void telaCadastroBaseDados(){

        Intent intencao  = new Intent(this, CadastroBaseDadosActivity.class);
        startActivity(intencao);
    }

    void telaCadastroProduto(){
        Intent intencao  = new Intent(this, CadastroProdutoActivity.class);
        startActivity(intencao);
    }

    int splitId(String text){
        return Integer.parseInt(text.split(" -")[0]);
    }
}
