package com.wb.tracun.markup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.widget.EditText;
import android.widget.Toast;

public class produtosSalvos extends AppCompatActivity {
    // Remove the below line after defining your own ad unit ID.
    private static final String TOAST_TEXT = "Test ads are being shown. "
            + "To show live ads, replace the ad unit ID in res/values/strings.xml with your own ad unit ID.";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_produtos_salvos);

        // Load an ad into the AdMob banner view.
        AdView adView = (AdView) findViewById(R.id.adView);
        AdRequest adRequest = new AdRequest.Builder()
                .setRequestAgent("android_studio:ad_template").build();
        adView.loadAd(adRequest);

        // Toasts the test ad message on the screen. Remove this after defining your own ad unit ID.
        Toast.makeText(this, TOAST_TEXT, Toast.LENGTH_LONG).show();

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
        txtID = (EditText) findViewById(R.id.txtId);
        txtPrecoFora = (EditText) findViewById(R.id.txtPrecoFora);
        txtPrecoDentro = (EditText) findViewById(R.id.txtPrecoDentro);

    }

    public void buscaDados(){
        //Inicializo os EditText's
        iniciaEditText();

        // Primeira coisa que precisamos fazer e buscar a intenção da nossa activity, pois é dentro dela que temos nossos parametros.
        Intent it = getIntent();
        // No caso do int podemos passar uma valor default para assim caso não exista retorna alguma informação.
        int posicao = it.getIntExtra("posicao", -1);
        //Acrescento 1 pois o ID no Sqlite comeca do 1
        posicao = posicao + 1;

        GerenciaBD gerenciaBD = new GerenciaBD(this);
        Cursor cursor = gerenciaBD.buscaDadoById(posicao);

        if(cursor!=null){
            cursor.moveToFirst();
            do{

                txtID.setText(String.valueOf(cursor.getInt(0)));
                txtNome.setText(cursor.getString(1));
                txtCusto.setText("R$ " + ConversorMoeda.formataMoeda(cursor.getDouble(2)));
                txtEncargo.setText(String.valueOf(cursor.getLong(3)) + "%");
                txtComissao.setText(String.valueOf(cursor.getLong(4)) + "%");
                txtLucro.setText(String.valueOf(cursor.getLong(5)) + "%");
                txtOutro.setText(String.valueOf(cursor.getLong(6)) + "%");
                txtImp1.setText(String.valueOf(cursor.getLong(7)) + "%");
                txtImp2.setText(String.valueOf(cursor.getLong(8)) + "%");
                txtCustoIndireto.setText(String.valueOf(cursor.getLong(9)) + "%");
                txtPrecoFora.setText("R$ " + ConversorMoeda.formataMoeda(cursor.getDouble(10)));
                txtPrecoDentro.setText("R$ " + ConversorMoeda.formataMoeda(cursor.getDouble(11)));

            }while(cursor.moveToNext());
        }


    }

    public void carregaDados(){


    }

}
