package br.com.dpimentas7.pedido;

import br.com.dpimentas7.cardapio.Marmitex;
import br.com.dpimentas7.cardapio.TamanhoMarmitex;
import br.com.dpimentas7.util.Formatador;

public class PedidoMarmitex {
    private Pedido pedido;
    private TamanhoMarmitex tamanho;
    private Marmitex marmitex;
    private int qtd;
    private String obsTroca;

    public PedidoMarmitex() {
        this.qtd = 1;
    }

    public PedidoMarmitex(Pedido pedido, TamanhoMarmitex tamanho, Marmitex marmitex, int qtd) {
        this.pedido = pedido;
        this.tamanho = tamanho;
        this.marmitex = marmitex;
        setQtd(qtd);
    }

    public Pedido getPedido() { return pedido; }
    public void setPedido(Pedido pedido) { this.pedido = pedido; }

    public TamanhoMarmitex getTamanho() { return tamanho; }
    public void setTamanho(TamanhoMarmitex tamanho) { this.tamanho = tamanho; }

    public Marmitex getMarmitex() { return marmitex; }
    public void setMarmitex(Marmitex marmitex) { this.marmitex = marmitex; }

    public int getQtd() { return qtd; }
    public void setQtd(int qtd) { this.qtd = Formatador.exigirPositivo(qtd, "Quantidade"); }

    public String getObsTroca() { return obsTroca; }
    public void setObsTroca(String obsTroca) { this.obsTroca = obsTroca; }

    public double getSubtotal() {
        double precoBase = (tamanho != null) ? tamanho.getPrecoBase() : 0.0;
        double adicional = (marmitex != null) ? marmitex.getPrecoAdicional() : 0.0;
        return Formatador.arredondar((precoBase + adicional) * qtd);
    }

    @Override
    public String toString() {
        return qtd + "x "
                + (tamanho != null ? tamanho.getNome() : "")
                + " - "
                + (marmitex != null ? marmitex.getNome() : "")
                + (obsTroca != null && !obsTroca.isEmpty() ? " (" + obsTroca + ")" : "")
                + " = R$ " + Formatador.moeda(getSubtotal());
    }
}
