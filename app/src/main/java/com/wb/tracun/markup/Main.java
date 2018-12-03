package com.wb.tracun.markup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.wb.tracun.markup.Adapter.TabAdapterProduto;
import com.wb.tracun.markup.activity.CadastroBaseDadosActivity;
import com.wb.tracun.markup.activity.CadastroProdutoActivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.helper.ItemTouchHelper;
import android.util.Log;
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
    public Context mContext = this;

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

                new AlertDialog.Builder(v.getContext())
                        .setTitle("Deletando produto")
                        .setMessage("Tem certeza que deseja deletar esse produto?")
                        .setPositiveButton("sim",
                                new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {

                                        // ListView Clicked item value
                                        Produto produto = (Produto) list.getItemAtPosition(index);

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
            Produto produto = (Produto) list.getItemAtPosition(position);

            exibeTelaProdutoDetalhado(view,produto);

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

    public void onBackPressed() {
        android.os.Process.killProcess(android.os.Process.myPid());
    }

    //Carrega os itens salvos na lista da tela Principal
    void carregaLista(View view){

        ListView list;

        list = (ListView) findViewById(R.id.list);

        GerenciaBD gerenciaBD = new GerenciaBD(this);

        ArrayList lista;

//        Toast.makeText(this,"Nenhum produto cadastrado !",Toast.LENGTH_LONG).show();

        if(gerenciaBD.buscaString() != null){

            AdapterProdutosPersonalizado adapter = new AdapterProdutosPersonalizado(gerenciaBD.buscarTodos(), this);
            list.setAdapter(adapter);
        }else{
            Toast.makeText(this,"Nenhum produto cadastrado !",Toast.LENGTH_LONG).show();
        }

    }

    public void exibeTelaCadastro(){

        Intent intencao = new Intent(this,Cadastro.class);
        startActivity(intencao);
    }

    //Chama a outra tela e passa como parametro a posicao
    public void exibeTelaProdutoDetalhado(View view, Produto produto){

        Intent intencao = new Intent(this,produtosSalvos.class);
        intencao.putExtra("produto", produto);
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
}
