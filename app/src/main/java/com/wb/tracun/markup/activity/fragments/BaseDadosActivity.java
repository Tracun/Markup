package com.wb.tracun.markup.activity.fragments;

import android.content.Intent;
import android.database.Cursor;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;

import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.wb.tracun.markup.DB.GerenciaBD;
import com.wb.tracun.markup.Main;
import com.wb.tracun.markup.R;
//import com.wb.tracun.markup.activity.MainActivity;
import com.wb.tracun.markup.model.DespesaAdm;
import com.wb.tracun.markup.model.Insumo;
import com.wb.tracun.markup.model.Rateio;
import com.wb.tracun.markup.model.TempoFab;
import com.wb.tracun.markup.model.Unidade;

import java.util.ArrayList;

public class BaseDadosActivity extends AppCompatActivity {

    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v4.app.FragmentStatePagerAdapter}.
     */
    private SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    private ViewPager mViewPager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_base_dados_blank);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = (ViewPager) findViewById(R.id.container);
        mViewPager.setAdapter(mSectionsPagerAdapter);

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_unidades, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        Button btnCadas;
        Button btnMenu;
        Button btnAtualizarUnidades;
        EditText txtDescricao;
        EditText txtValUnit;
        EditText txtValHora;
        Spinner spinner;
        View rootView;
        GerenciaBD gerenciaBD;
        ArrayList<Integer> listIdUnid;

        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";

        public PlaceholderFragment() {
        }

        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(int sectionNumber) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

            //Here we will handle tab transaction
            if(getArguments().getInt(ARG_SECTION_NUMBER) == 1){ //Unidades
                this.rootView = inflater.inflate(R.layout.fragment_unidades, container, false);
                defineFragmentUnidade();
                return this.rootView;

            }else if(getArguments().getInt(ARG_SECTION_NUMBER) == 2){ //Insumos

                this.rootView = inflater.inflate(R.layout.fragment_insumo, container, false);
                defineFragmentInsumos();
                catchUnidades();
                return this.rootView;

            }else if(getArguments().getInt(ARG_SECTION_NUMBER) == 3){ //Rateio
                this.rootView = inflater.inflate(R.layout.fragment_rateio, container, false);
                catchUnidades();
                defineFragmentRateio();

                return this.rootView;
            }else if(getArguments().getInt(ARG_SECTION_NUMBER) == 4){ //Tempo de fabricacao
                this.rootView = inflater.inflate(R.layout.fragment_tempos_fab, container, false);
                defineFragmentTempFab();
                return this.rootView;

            }else if(getArguments().getInt(ARG_SECTION_NUMBER) == 5){ //Despesas
                this.rootView = inflater.inflate(R.layout.fragment_despesas, container, false);
                defineFragmentDespesa();
                return this.rootView;

            }else{
                this.rootView = inflater.inflate(R.layout.fragment_unidades, container, false);
                defineFragmentUnidade();
                return this.rootView;
            }
        }

        //define os botoes e texts
        void defineFragmentUnidade(){
            btnCadas = (Button) this.rootView.findViewById(R.id.btnCadas);
            btnMenu = (Button) this.rootView.findViewById(R.id.btnMenu);
            txtDescricao = (EditText) this.rootView.findViewById(R.id.txtDescricao);

            btnCadas.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    if(txtDescricao.getText().toString().equals("")){
                        txtDescricao.setError("Campo vazio :(");
                    }else{
                        saveUnidades(v);
                    }
                }
            });

            btnMenu.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intencao = new Intent(getContext(), Main.class);
                    startActivity(intencao);
                }
            });
        }

        void defineFragmentInsumos(){
            spinner = (Spinner) this.rootView.findViewById(R.id.spinner);
            btnCadas = (Button) this.rootView.findViewById(R.id.btnCadas);
            btnAtualizarUnidades = (Button) this.rootView.findViewById(R.id.btnAtualizarUnidades);
            txtDescricao = (EditText) this.rootView.findViewById(R.id.txtDescricao);
            txtValUnit = (EditText) this.rootView.findViewById(R.id.txtValUnit);

            btnAtualizarUnidades.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    catchUnidades();
                }
            });

            btnCadas.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    if(txtDescricao.getText().toString().equals("")){
                        txtDescricao.setError("Campo vazio :(");
                    }else if(txtValUnit.getText().toString().equals("")){
                        txtValUnit.setError("Campo vazio :(");
                    }else if(spinner.getSelectedItem().toString().equals("")){
                        Toast.makeText(getActivity(), "Escolha a unidade do insumo", Toast.LENGTH_SHORT).show();
                        System.out.println("Erro spinner vazio");
                    }else{
                        saveInsumo(v);
                    }
                }
            });
        }

        void defineFragmentRateio(){
            btnCadas = (Button) this.rootView.findViewById(R.id.btnCadas);
            txtDescricao = (EditText) this.rootView.findViewById(R.id.txtDescricao);
            txtValUnit = (EditText) this.rootView.findViewById(R.id.txtValUnit);
            btnAtualizarUnidades = (Button) this.rootView.findViewById(R.id.btnAtualizarUnidades);
            spinner = (Spinner) this.rootView.findViewById(R.id.spinner);

            catchUnidades();
            btnAtualizarUnidades.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    catchUnidades();
                }
            });

            btnCadas.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    if(txtDescricao.getText().toString().equals("")){
                        txtDescricao.setError("Campo vazio :(");
                    }else if(txtValUnit.getText().toString().equals("")){
                        txtValUnit.setError("Campo vazio :(");
                    }else if(spinner.getSelectedItem().toString().equals("")){
                        Toast.makeText(getActivity(), "Escolha a unidade do Rateio", Toast.LENGTH_SHORT).show();
                        System.out.println("Erro spinner vazio");
                    }else{
                        saveRateio(v);
                    }
                }
            });
        }

        void defineFragmentTempFab(){
            btnCadas = (Button) this.rootView.findViewById(R.id.btnCadas);
            txtDescricao = (EditText) this.rootView.findViewById(R.id.txtDescricao);
            txtValHora = (EditText) this.rootView.findViewById(R.id.txtValHora);

            btnCadas.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    if(txtDescricao.getText().toString().equals("")){
                        txtDescricao.setError("Campo vazio :(");
                    }else if(txtValHora.getText().toString().equals("")){
                        txtValHora.setError("Campo vazio :(");
                    }else{
                        saveTempoFab(v);
                    }
                }
            });
        }

        void defineFragmentDespesa(){
            btnCadas = (Button) this.rootView.findViewById(R.id.btnCadas);
            txtDescricao = (EditText) this.rootView.findViewById(R.id.txtDescricao);
            txtValHora = (EditText) this.rootView.findViewById(R.id.txtValHora);

            btnCadas.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    if(txtDescricao.getText().toString().equals("")){
                        txtDescricao.setError("Campo vazio :(");
                    }else if(txtValHora.getText().toString().equals("")){
                        txtValHora.setError("Campo vazio :(");
                    }else{
                        saveDespesa(v);
                    }
                }
            });
        }

        void saveUnidades(View v){

            gerenciaBD = new GerenciaBD(v.getContext());

            Unidade unid = new Unidade();
            unid.setDescricao(txtDescricao.getText().toString());

            if(gerenciaBD.saveUnidade(unid) > 0){
                Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
                txtDescricao.setText("");
            }else{
                Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
            }
        }

        void saveInsumo(View v){

            gerenciaBD = new GerenciaBD(v.getContext());

            Insumo insumo = new Insumo();
            insumo.setNome(txtDescricao.getText().toString());
            insumo.setValorUnitario(Float.parseFloat(txtValUnit.getText().toString()));
            insumo.setPosicaoUnid(listIdUnid.get(spinner.getSelectedItemPosition()));

            if(gerenciaBD.saveInsumo(insumo) > 0){
                Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
                txtDescricao.setText("");
                txtValUnit.setText("");
                catchInsumo();
            }else{
                Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
            }
        }

        void saveRateio(View v){

            gerenciaBD = new GerenciaBD(v.getContext());

            Rateio rateio = new Rateio();
            rateio.setDescricao(txtDescricao.getText().toString());
            rateio.setValorUnitario(Float.parseFloat(txtValUnit.getText().toString()));
            rateio.setPosicaoUnid(listIdUnid.get(spinner.getSelectedItemPosition()));

            if(gerenciaBD.saveRateio(rateio) > 0){
                Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
                txtDescricao.setText("");
                txtValUnit.setText("");
                catchRateio();
            }else{
                Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
            }
        }

        void saveDespesa(View v){

            gerenciaBD = new GerenciaBD(v.getContext());

            DespesaAdm despesaAdm = new DespesaAdm();
            despesaAdm.setDescricao(txtDescricao.getText().toString());
            despesaAdm.setValor(Float.parseFloat(txtValHora.getText().toString()));

            if(gerenciaBD.saveDespesa(despesaAdm) > 0){
                Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
                txtDescricao.setText("");
                txtValHora.setText("");
                catchDespesa();
            }else{
                Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
            }
        }

        void saveTempoFab(View v){

            gerenciaBD = new GerenciaBD(v.getContext());

            TempoFab tempoFab = new TempoFab();
            tempoFab.setNome(txtDescricao.getText().toString());
            tempoFab.setValorHora(Float.parseFloat(txtValHora.getText().toString()));

            if(gerenciaBD.saveTempoFab(tempoFab) > 0){
                Toast.makeText(v.getContext(), "Cadastro realizado :)", Toast.LENGTH_SHORT).show();
                txtDescricao.setText("");
                txtValHora.setText("");
                catchTempoFab();
            }else{
                Toast.makeText(v.getContext(), "Falha ao realizar cadastro :(", Toast.LENGTH_SHORT).show();
            }
        }

        //Define as unidades no spinner
        void catchUnidades(){
            try{
                gerenciaBD = new GerenciaBD(rootView.getContext());
                Cursor cursor = gerenciaBD.buscaUnidades();

                if(cursor != null){
                    ArrayList list = new ArrayList();
                    listIdUnid = new ArrayList();

                    while(cursor.moveToNext()){
                        listIdUnid.add(cursor.getInt(0));//ERRO AO ADICIONAR OS 02 PRIMEIROS INDICES
                        System.out.println("id: " + cursor.getInt(0));//APAGAR
                        list.add(cursor.getString(1));
                        System.out.println("Value: " + cursor.getString(1));//APAGAR
                    }

                    imprimir();//APAGAR

                    ArrayAdapter adapterUnid = new ArrayAdapter(this.rootView.getContext(), android.R.layout.simple_spinner_dropdown_item, list);
                    spinner.setAdapter(adapterUnid);
                }

            }catch(Exception e){
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }

        void catchInsumo() {
            try{
                gerenciaBD = new GerenciaBD(rootView.getContext());
                Cursor cursor = gerenciaBD.buscaInsumos();

                ArrayList list = new ArrayList();

                while(cursor.moveToNext()){
                    System.out.println("catchInsumo: Id: " + cursor.getString(0));
                    System.out.println("catchInsumo: nome: " + cursor.getString(1));
                    System.out.println("catchInsumo: Valor unit: " + cursor.getString(2));
                    System.out.println("catchInsumo: idUnidade: " + cursor.getString(3));
                }

            }catch(Exception e){
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }

        void catchRateio(){
            try{
                gerenciaBD = new GerenciaBD(rootView.getContext());
                Cursor cursor = gerenciaBD.buscaRateio();

                ArrayList list = new ArrayList();

                while(cursor.moveToNext()){
                    System.out.println("catchRateio: Id: " + cursor.getString(0));
                    System.out.println("catchRateio: Descricao: " + cursor.getString(1));
                    System.out.println("catchRateio: Valor unit: " + cursor.getString(2));
                    System.out.println("catchRateio: idUnidade: " + cursor.getString(3));
                }


            }catch(Exception e){
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }

        void catchDespesa(){
            try{
                gerenciaBD = new GerenciaBD(rootView.getContext());
                Cursor cursor = gerenciaBD.buscaDespesas();

                ArrayList list = new ArrayList();

                while(cursor.moveToNext()){
                    System.out.println("catchDespesa: Id: " + cursor.getString(0));
                    System.out.println("catchDespesa: Descricao: " + cursor.getString(1));
                    System.out.println("catchDespesa: Valor hora: " + cursor.getString(2));
                }


            }catch(Exception e){
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }

        void catchTempoFab(){
            try{
                gerenciaBD = new GerenciaBD(rootView.getContext());
                Cursor cursor = gerenciaBD.buscaTempoFab();

                ArrayList list = new ArrayList();

                while(cursor.moveToNext()){
                    System.out.println("catchDespesa: Id: " + cursor.getString(0));
                    System.out.println("catchDespesa: Descricao: " + cursor.getString(1));
                    System.out.println("catchDespesa: Valor hora: " + cursor.getString(2));
                }


            }catch(Exception e){
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }

        void imprimir(){
            for (int i = 0; i < listIdUnid.size(); i++) {
                System.out.println("Itens da listaId: " + listIdUnid.get(i));
            }
        }
    }

    void telaMenu(View view){
        Intent intencao = new Intent(this, Main.class);
        startActivity(intencao);
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            // getItem is called to instantiate the fragment for the given page.
            // Return a PlaceholderFragment (defined as a static inner class below).
            return PlaceholderFragment.newInstance(position + 1);
        }

        @Override
        public int getCount() {
            // Show 5 total pages.
            return 5;
        }
    }
}
