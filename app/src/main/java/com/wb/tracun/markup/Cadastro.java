package com.wb.tracun.markup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import android.widget.ViewSwitcher;

public class Cadastro extends AppCompatActivity {
    // Remove the below line after defining your own ad unit ID.
    private static final String TOAST_TEXT = "Test ads are being shown. "
            + "To show live ads, replace the ad unit ID in res/values/strings.xml with your own ad unit ID.";

    private static final String TOAST_PERCENTAGE_EXCEEDED = "A soma das porcentagem não pode exceder 100%";
    private ViewSwitcher VS;
    Button salvar;
    Button voltar;
    EditText txtPrecoDentro;
    EditText txtPrecoFora;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cadastro);

        //Inicializa os edit's text
        iniciaEditText();

        // Load an ad into the AdMob banner view.
        AdView adView = (AdView) findViewById(R.id.adView);
        AdRequest adRequest = new AdRequest.Builder()
                .setRequestAgent("android_studio:ad_template").build();
        adView.loadAd(adRequest);

        // Toasts the test ad message on the screen. Remove this after defining your own ad unit ID.
//        Toast.makeText(this, TOAST_TEXT, Toast.LENGTH_LONG).show();


        VS = (ViewSwitcher) findViewById(R.id.VS);
        salvar = (Button) findViewById(R.id.btnSalvar);
        voltar = (Button) findViewById(R.id.btnVoltar);
        txtPrecoDentro = (EditText) findViewById(R.id.txtPrecoDentro);
        txtPrecoFora = (EditText) findViewById(R.id.txtPrecoFora);

        voltar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                VS.setVisibility(View.INVISIBLE);
            }

        });

        salvar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                salvarProduto();
            }
        });

    }


    EditText txtNome;
    EditText txtCusto;
    EditText txtEncargo;
    EditText txtComissao;
    EditText txtOutro;
    EditText txtLucro;
    EditText txtImp1;
    EditText txtImp2;
    EditText txtCustoIndireto;
    Button btnCadastrar;
    Produto produto;

    @Override
    public void onBackPressed() {

        if(VS.getVisibility() == View.VISIBLE){
            VS.setVisibility(View.INVISIBLE);
        }else{
            Intent intencao = new Intent(this, Main.class);
            startActivity(intencao);
        }

    }

    public void iniciaEditText(){

        txtNome = (EditText) findViewById(R.id.txtNome);
        txtCusto = (EditText) findViewById(R.id.txtCusto);
        txtEncargo = (EditText) findViewById(R.id.txtEncargo);
        txtComissao = (EditText) findViewById(R.id.txtComissao);
        txtOutro = (EditText) findViewById(R.id.txtOutro);
        txtLucro = (EditText) findViewById(R.id.txtLucro);
        txtImp1 = (EditText) findViewById(R.id.txtImp1);
        txtImp2 = (EditText) findViewById(R.id.txtImp2);
        txtCustoIndireto = (EditText) findViewById(R.id.txtCustoIndireto);
        btnCadastrar = (Button) findViewById(R.id.btnCadastrar);


    }

    public void calculaMarkUp(View view) {

        if(txtEncargo.getText().toString().equals("") || txtComissao.getText().toString().equals("") || txtCustoIndireto.getText().toString().equals("") || txtImp2.getText().toString().equals("") || txtImp1.getText().toString().equals("") || txtOutro.getText().toString().equals("")){

            txtEncargo.setText("0");
            txtComissao.setText("0");
            txtCustoIndireto.setText("0");
            txtImp1.setText("0");
            txtImp2.setText("0");
            txtOutro.setText("0");

        }

        if(txtNome.getText().toString().equals("")){

            txtNome.setError("Campo vazio !");

        }else if(txtCusto.getText().toString().equals("")){

            txtCusto.setError("Campo vazio !");

        }else if(txtLucro.getText().toString().equals("")){

            txtLucro.setError("Campo vazio !");

        }else if(txtEncargo.getText().toString().equals("")){

//            txtEncargo.setError("Campo vazio !");
            txtEncargo.setText("0");

        }else if(txtComissao.getText().toString().equals("")){

//            txtComissao.setError("Campo vazio !");
            txtComissao.setText("0");

        }else if(txtCustoIndireto.getText().toString().equals("")){

//            txtCustoIndireto.setError("Campo vazio !");
            txtCustoIndireto.setText("0");

        }else if(txtImp2.getText().toString().equals("")){

            //txtImp2.setError("Campo vazio !");
            txtImp2.setText("0");

        }else if(txtImp1.getText().toString().equals("")){

            //txtImp1.setError("Campo vazio !");
            txtImp1.setText("0");

        }else if(txtOutro.getText().toString().equals("")){

//            txtOutro.setError("Campo vazio !");
            txtOutro.setText("0");
        }else{

            criarProduto();

            //Chama um ViewSwitcher
            txtPrecoDentro.setText("R$ " + ConversorMoeda.formataMoeda(produto.getPrecoDentro()));
            txtPrecoFora.setText("R$ " + ConversorMoeda.formataMoeda(produto.getPrecoFora()));
            VS.setVisibility(View.VISIBLE);

        }
    }

    public void criarProduto(){

        //instancia um novo produto;
        produto = new Produto();

        //Pega os valores inseridos pelo usuário
        produto.setNome(txtNome.getText().toString());
        produto.setCusto(Double.parseDouble(txtCusto.getText().toString()));
        produto.setComissao(Float.parseFloat(txtComissao.getText().toString()));
        produto.setEncargo(Float.parseFloat(txtEncargo.getText().toString()));
        produto.setCustoIndireto(Float.parseFloat(txtCustoIndireto.getText().toString()));
        produto.setLucro(Float.parseFloat(txtLucro.getText().toString()));
        produto.setImp1(Float.parseFloat(txtImp1.getText().toString()));
        produto.setImp2(Float.parseFloat(txtImp2.getText().toString()));
        produto.setOutros(Float.parseFloat(txtOutro.getText().toString()));

        //Chama os metodos para efetuar os calculos de preco
        double precoFora = Calculos.calcularPrecoFora(produto);
        double precoDentro = Calculos.calcularPrecoDentro(produto);

        if(precoFora == -333 || precoDentro == -333){
            Toast.makeText(this, TOAST_PERCENTAGE_EXCEEDED, Toast.LENGTH_LONG).show();
        }else{
            produto.setPrecoFora(precoFora);
            produto.setPrecoDentro(precoDentro);
        }

    }

    public void salvarProduto(){

        //Instancio o gerenciaBD para realizar a inserção dos dados no banco de dados
        GerenciaBD gerenciaBd = new GerenciaBD(getBaseContext());
        Toast.makeText(this, gerenciaBd.inserir(produto), Toast.LENGTH_LONG).show();

        txtNome.setText("");
        txtCusto.setText("");
        txtLucro.setText("");
        txtEncargo.setText("");
        txtComissao.setText("");
        txtCustoIndireto.setText("");
        txtImp1.setText("");
        txtImp2.setText("");
        txtOutro.setText("");

    }

}
