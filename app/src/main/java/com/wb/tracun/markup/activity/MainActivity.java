//package com.wb.tracun.markup.activity;
//
//import android.content.Intent;
//import android.support.annotation.NonNull;
//import android.support.design.widget.BottomNavigationView;
//import android.support.v7.app.AppCompatActivity;
//import android.os.Bundle;
//import android.view.MenuItem;
//import android.view.View;
//import android.widget.Button;
//import android.widget.EditText;
//
//import com.wb.tracun.markup.*;
//import com.wb.tracun.markup.model.*;
//
//public class MainActivity extends AppCompatActivity {
//
//    EditText txtCusto;
//    Button btnTest;
//
//    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
//            = new BottomNavigationView.OnNavigationItemSelectedListener() {
//
//        @Override
//        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
//            switch (item.getItemId()) {
//                case R.id.cadastro_produto:
//                    telaCadastroProduto();
//                    return true;
//
//                case R.id.cadastro_base_dados:
//                    telaCadastroBaseDados();
//                    return true;
//
//                case R.id.navigation_notifications:
//
//                    return true;
//            }
//            return false;
//        }
//    };
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
//        txtCusto = (EditText) findViewById(R.id.txtCusto);
//        btnTest = (Button) findViewById(R.id.btnTest);
//
//        BottomNavigationView navigation = (BottomNavigationView) findViewById(R.id.navigation);
//        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);
//
//    }
//
//    void recuperaObjetoSerializado(View view){
//
//        Insumo insumo = new Insumo();
//        SerializeObject so = new SerializeObject();
//
//        insumo = so.readSerializeObject(insumo, "insumos", getCacheDir());
//
//        System.out.println("Recuperei meu objeto, o nome é: " + insumo.getNome());
//
//    }
//
//    void telaCadastroBaseDados(){
//        Intent intencao  = new Intent(this, CadastroBaseDadosActivity.class);
//        startActivity(intencao);
//    }
//
//    void telaCadastroProduto(){
//        Intent intencao  = new Intent(this, CadastroProdutoActivity.class);
//        startActivity(intencao);
//    }
//}
