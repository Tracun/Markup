package com.wb.tracun.paidmarkup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.wb.tracun.markup.Calculos;
import com.wb.tracun.markup.ConversorMoeda;
import com.wb.tracun.markup.GerenciaBD;
import com.wb.tracun.markup.Produto;
import com.wb.tracun.markup.R;

import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Toast;
import android.widget.ViewSwitcher;

public class Cadastro extends AppCompatActivity {
    // Remove the below line after defining your own ad unit ID.
    private static final String TOAST_TEXT = "Test ads are being shown. "
            + "To show live ads, replace the ad unit ID in res/values/strings.xml with your own ad unit ID.";

    private static final String TOAST_PERCENTAGE_EXCEEDED = "A soma das porcentagem não pode exceder 100%";
    public static final int IMAGEM_INTERNA = 3;
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
//        AdView adView = (AdView) findViewById(R.id.adView);
//        AdRequest adRequest = new AdRequest.Builder()
//                .setRequestAgent("android_studio:ad_template").build();
//        adView.loadAd(adRequest);

        // Toasts the test ad message on the screen. Remove this after defining your own ad unit ID.
//        Toast.makeText(this, TOAST_TEXT, Toast.LENGTH_LONG).show();


        VS = (ViewSwitcher) findViewById(R.id.VS);
        salvar = (Button) findViewById(R.id.btnSalvar);
        voltar = (Button) findViewById(R.id.btnVoltar);
        txtPrecoDentro = (EditText) findViewById(R.id.txtPrecoDentro);
        txtPrecoFora = (EditText) findViewById(R.id.txtPrecoFora);
//

//        txtCusto.setOnFocusChangeListener(new View.OnFocusChangeListener() {
//            @Override
//            public void onFocusChange(View view, boolean b) {
//                String texto = "R$ " + txtCusto.getText().toString();
//                if(!texto.contains("R$")) txtCusto.setText(texto);
//            }
//        });

        voltar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                VS.setVisibility(View.INVISIBLE);
                setEnable();
            }

        });

        salvar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                salvarProduto();
            }
        });

        imgProduct.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pegarImagem();
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
    ImageButton imgProduct;

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
        imgProduct = (ImageButton) findViewById(R.id.imgProduct);

    }

    public void calculaMarkUp(View view) {

        if (txtNome.getText().toString().equals("")) {

            txtNome.setError("Campo vazio !");

        } else if (txtCusto.getText().toString().equals("")) {

            txtCusto.setError("Campo vazio !");

        } else if (txtLucro.getText().toString().equals("")) {

            txtLucro.setError("Campo vazio !");

        } else {

            setZeroOnEmpty();

            if (txtEncargo.getText().toString().equals("")) {

//            txtEncargo.setError("Campo vazio !");
                txtEncargo.setText("0");

            } else if (txtComissao.getText().toString().equals("")) {

//            txtComissao.setError("Campo vazio !");
                txtComissao.setText("0");

            } else if (txtCustoIndireto.getText().toString().equals("")) {

//            txtCustoIndireto.setError("Campo vazio !");
                txtCustoIndireto.setText("0");

            } else if (txtImp2.getText().toString().equals("")) {

                //txtImp2.setError("Campo vazio !");
                txtImp2.setText("0");

            } else if (txtImp1.getText().toString().equals("")) {

                //txtImp1.setError("Campo vazio !");
                txtImp1.setText("0");

            } else if (txtOutro.getText().toString().equals("")) {

//            txtOutro.setError("Campo vazio !");
                txtOutro.setText("0");
            }

            criarProduto();

            txtPrecoDentro.setText("R$ " + ConversorMoeda.formataMoeda(produto.getPrecoDentro()));
            txtPrecoFora.setText("R$ " + ConversorMoeda.formataMoeda(produto.getPrecoFora()));
            //Chama um ViewSwitcher
            VS.setVisibility(View.VISIBLE);

            //Desativa os EditText
            setDisable();
            txtPrecoDentro.setEnabled(false);
            txtPrecoFora.setEnabled(false);

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

    public void setZeroOnEmpty(){

        if(txtEncargo.getText().toString().equals("")){

            txtEncargo.setText("0");
        }

        if(txtComissao.getText().toString().equals("")){

            txtComissao.setText("0");
        }

        if(txtCustoIndireto.getText().toString().equals("")){

            txtCustoIndireto.setText("0");
        }

        if(txtImp1.getText().toString().equals("")){

            txtImp1.setText("0");
        }

        if(txtImp2.getText().toString().equals("")){

            txtImp2.setText("0");
        }

        if(txtOutro.getText().equals("")){
            txtOutro.setText("0");
        }

    }

    public void setEnable(){

        txtNome.setEnabled(true);
        txtCusto.setEnabled(true);
        txtLucro.setEnabled(true);
        txtEncargo.setEnabled(true);
        txtComissao.setEnabled(true);
        txtCustoIndireto.setEnabled(true);
        txtImp1.setEnabled(true);
        txtImp2.setEnabled(true);
        txtOutro.setEnabled(true);
    }

    public void setDisable(){

        txtNome.setEnabled(false);
        txtCusto.setEnabled(false);
        txtLucro.setEnabled(false);
        txtEncargo.setEnabled(false);
        txtComissao.setEnabled(false);
        txtCustoIndireto.setEnabled(false);
        txtImp1.setEnabled(false);
        txtImp2.setEnabled(false);
        txtOutro.setEnabled(false);
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

    void pegarImagem(){

        try {

            Intent intencao = new Intent(Intent.ACTION_GET_CONTENT);
            intencao.setType("image/*");
            startActivityForResult(intencao, IMAGEM_INTERNA);

        }catch (Exception e){

            Toast.makeText(this, "Erro" + e.getMessage(), Toast.LENGTH_LONG).show();

        }

    }


    void salvarImagemBD(String path){
        produto.setUriImg(path);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent){

        if(requestCode == IMAGEM_INTERNA){
            if(resultCode == RESULT_OK){

                Uri imagemSelecionada = intent.getData();
                String[] colunas = {MediaStore.Images.Media.DATA};
                Cursor cursor = getContentResolver().query(imagemSelecionada, colunas, null, null, null);
                cursor.moveToFirst();

                int indexColuna = cursor.getColumnIndex(colunas[0]);
                String pathImg = cursor.getString(indexColuna);
                salvarImagemBD(pathImg);
                cursor.close();

                Bitmap bitmap = BitmapFactory.decodeFile(pathImg);
                imgProduct.setImageBitmap(bitmap);
            }else {
                Toast.makeText(this, "Erro", Toast.LENGTH_LONG);
            }
        }else{
            Toast.makeText(this, "Erro", Toast.LENGTH_LONG);
        }

    }

}
