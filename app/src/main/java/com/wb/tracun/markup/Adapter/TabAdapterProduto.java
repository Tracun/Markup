package com.wb.tracun.markup.Adapter;


import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoCustoFragment;
import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoDespesaFragment;
import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoInsumoFragment;
import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoRateioFragment;
import com.wb.tracun.markup.activity.fragments.NewProductFragments.ProdutoTempoFabFragment;

public class TabAdapterProduto extends FragmentStatePagerAdapter {

    private String[] tituloAbas = {"INSUMOS", "RATEIO", "DESPESAS", "TEMPOS DE FABRICAÇÃO", "CUSTO"};

    public TabAdapterProduto(FragmentManager fm) {
        super(fm);
    }

    @Override
    public Fragment getItem(int position) {

        Fragment fragment = null;

        switch (position){
            case 0:
                fragment = new ProdutoInsumoFragment();
                break;
            case 1:
                fragment = new ProdutoRateioFragment();
                break;
            case 2:
                fragment = new ProdutoDespesaFragment();
                break;
            case 3:
                fragment = new ProdutoTempoFabFragment();
                break;
            case 4:
                fragment = new ProdutoCustoFragment();
                break;
        }
        return fragment;
    }

    @Override
    public int getCount() {
        return tituloAbas.length;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return tituloAbas[position];
    }
}
