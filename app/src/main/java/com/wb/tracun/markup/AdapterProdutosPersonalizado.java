package com.wb.tracun.markup;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

public class AdapterProdutosPersonalizado extends BaseAdapter {

    private final List<Produto> produtos;
    private final Activity act;

    public AdapterProdutosPersonalizado(List<Produto> produtos, Activity act) {
        this.produtos = produtos;
        this.act = act;
    }

    @Override
    public int getCount() {
        return this.produtos.size();
    }

    @Override
    public Object getItem(int position) {
        return this.produtos.get(position);
    }

    @Override
    public long getItemId(int position) {
        return produtos.get(position).getId();
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view = act.getLayoutInflater()
                .inflate(R.layout.layout_adapter_personalizado, parent, false);
        Produto produto = produtos.get(position);

        //pegando as referências das Views
        TextView nome = (TextView)
                view.findViewById(R.id.txtNomeProduto);
        TextView precoFora = (TextView)
                view.findViewById(R.id.txtPrecoFora);
        TextView precoDentro = (TextView)
                view.findViewById(R.id.txtPrecoDentro);
        ImageView imagem = (ImageView)
                view.findViewById(R.id.imgProdutoPersonalizado);

        //populando as Views
        nome.setText(produto.getNome());
        precoFora.setText("Fora - R$: " + String.valueOf(ConversorMoeda.formataMoeda(produto.getPrecoFora())));
        precoDentro.setText("Dentro - R$: " + String.valueOf(ConversorMoeda.formataMoeda(produto.getPrecoDentro())));

        Bitmap bitmap = BitmapFactory.decodeFile(String.valueOf(produto.getUriImg()));
        if(bitmap != null){
            imagem.setImageBitmap(bitmap);
        }else{

        }

        return view;
    }
}