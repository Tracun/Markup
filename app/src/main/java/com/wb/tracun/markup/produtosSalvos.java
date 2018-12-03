package com.wb.tracun.markup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

public class produtosSalvos extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_produtos_salvos);

        try {
            // Load an ad into the AdMob banner view.
            AdView adView = (AdView) findViewById(R.id.adView);
            AdRequest adRequest = new AdRequest.Builder()
                    .setRequestAgent("android_studio:ad_template").build();
            adView.loadAd(adRequest);

        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }

        buscaDados();

        ActionBar ab = getSupportActionBar();
        ab.setDisplayHomeAsUpEnabled(true);

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
    EditText txtID;
    EditText txtPrecoFora;
    EditText txtPrecoDentro;
    ImageView imgProduct;

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            // Respond to the action bar's Up/Home button
            case android.R.id.home:
                NavUtils.navigateUpFromSameTask(this);
                return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void iniciaEditText() {

        txtNome = (EditText) findViewById(R.id.txtNome);
        txtCusto = (EditText) findViewById(R.id.txtCusto);
        txtEncargo = (EditText) findViewById(R.id.txtEncargo);
        txtComissao = (EditText) findViewById(R.id.txtComissao);
        txtOutro = (EditText) findViewById(R.id.txtOutro);
        txtLucro = (EditText) findViewById(R.id.txtLucro);
        txtImp1 = (EditText) findViewById(R.id.txtImp1);
        txtImp2 = (EditText) findViewById(R.id.txtImp2);
        txtCustoIndireto = (EditText) findViewById(R.id.txtCustoIndireto);
        txtID = (EditText) findViewById(R.id.txtId);
        txtPrecoFora = (EditText) findViewById(R.id.txtPrecoFora);
        txtPrecoDentro = (EditText) findViewById(R.id.txtPrecoDentro);
        imgProduct = (ImageView) findViewById(R.id.imgProduct);

    }

    public void buscaDados() {
        //Inicializo os EditText's
        iniciaEditText();

        // Primeira coisa que precisamos fazer e buscar a intenção da nossa activity, pois é dentro dela que temos nossos parametros.
        Intent it = getIntent();
        Produto produto = (Produto) it.getSerializableExtra("produto");
        //Acrescento 1 pois o ID no Sqlite comeca do 1

        if (produto != null) {

            txtID.setText(String.valueOf(produto.getId()));
            txtNome.setText(produto.getNome());
            txtCusto.setText("R$ " + ConversorMoeda.formataMoeda(produto.getCusto()));
            txtEncargo.setText(String.valueOf(produto.getEncargo()) + "%");
            txtComissao.setText(String.valueOf(produto.getComissao()) + "%");
            txtLucro.setText(String.valueOf(produto.getLucro()) + "%");
            txtOutro.setText(String.valueOf(produto.getOutros()) + "%");
            txtImp1.setText(String.valueOf(produto.getImp1()) + "%");
            txtImp2.setText(String.valueOf(produto.getImp2()) + "%");
            txtCustoIndireto.setText(String.valueOf(produto.getCustoIndireto()) + "%");
            txtPrecoFora.setText("R$ " + ConversorMoeda.formataMoeda(produto.getPrecoFora()));
            txtPrecoDentro.setText("R$ " + ConversorMoeda.formataMoeda(produto.getPrecoDentro()));

            Bitmap bitmap = BitmapFactory.decodeFile(String.valueOf(produto.getUriImg()));

            if (bitmap != null) {
                imgProduct.setImageBitmap(bitmap);
            } else {

            }
        }

    }

}
