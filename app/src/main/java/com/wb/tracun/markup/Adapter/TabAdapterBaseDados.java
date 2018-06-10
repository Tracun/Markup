package com.wb.tracun.markup.Adapter;


import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

import com.wb.tracun.markup.activity.fragments.DataBaseFragments.DespesasFragment;
import com.wb.tracun.markup.activity.fragments.DataBaseFragments.InsumoFragment;
import com.wb.tracun.markup.activity.fragments.DataBaseFragments.RateioFragment;
import com.wb.tracun.markup.activity.fragments.DataBaseFragments.TemposFabFragment;
import com.wb.tracun.markup.activity.fragments.DataBaseFragments.UnidadesFragment;

public class TabAdapterBaseDados extends FragmentStatePagerAdapter {

    private String[] tituloAbas = {"UNIDADES", "DESPESAS", "TEMPOS DE FABRICAÇÃO", "INSUMOS", "RATEIO"};

    public TabAdapterBaseDados(FragmentManager fm) {
        super(fm);
    }

    @Override
    public Fragment getItem(int position) {

        Fragment fragment = null;

        switch (position){
            case 0:
                fragment = new UnidadesFragment();
                break;
            case 1:
                fragment = new DespesasFragment();
                break;
            case 2:
                fragment = new TemposFabFragment();
                break;
            case 3:
                fragment = new InsumoFragment();
                break;
            case 4:
                fragment = new RateioFragment();
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
