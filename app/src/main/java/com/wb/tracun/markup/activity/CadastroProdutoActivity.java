package com.wb.tracun.markup.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.MotionEvent;
import android.widget.Toast;

import com.wb.tracun.markup.Helper.SlidingTabLayout;
import com.wb.tracun.markup.R;
import com.wb.tracun.markup.Adapter.TabAdapterProduto;
import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoCustoFragment;
import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoInsumoFragment;

public class CadastroProdutoActivity extends AppCompatActivity {

    private SlidingTabLayout slidingTabLayout;
    private ViewPager viewPager;
    public float valor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cadastro_produto);

        slidingTabLayout = (SlidingTabLayout) findViewById(R.id.slidingTabLayout);
        viewPager = (ViewPager) findViewById(R.id.viewPager);

        //Configurar SlidingTab
        slidingTabLayout.setSelectedIndicatorColors(ContextCompat.getColor(this, R.color.colorAccent));

        //Configurar Adapter
        viewPager.setAdapter(new TabAdapterProduto(getSupportFragmentManager()));

        slidingTabLayout.setViewPager(viewPager);

    }

    @Override
    public void onBackPressed() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("Deseja voltar ao menu? As informações não salvas serão perdidas!");
        builder.setCancelable(true);

        builder.setPositiveButton("Sim", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                finish();
            }
        });

        builder.setNegativeButton("Não", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();
            }
        });

        AlertDialog alertDialog = builder.create();
        alertDialog.show();
    }
}
