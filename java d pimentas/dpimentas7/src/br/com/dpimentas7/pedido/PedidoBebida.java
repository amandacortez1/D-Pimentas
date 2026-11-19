package br.com.dpimentas7.pedido;

import br.com.dpimentas7.cardapio.Bebida;
import br.com.dpimentas7.util.Formatador;

public class PedidoBebida {
    private Pedido pedido;
    private Bebida bebida;
    private int qtd;

    public PedidoBebida() {
        this.qtd = 1;
    }

    public PedidoBebida(Pedido pedido, Bebida bebida, int qtd) {
        this.pedido = pedido;
        this.bebida = bebida;
        setQtd(qtd);
    }

    public Pedido getPedido() { return pedido; }
    public void setPedido(Pedido pedido) { this.pedido = pedido; }

    public Bebida getBebida() { return bebida; }
    public void setBebida(Bebida bebida) { this.bebida = bebida; }

    public int getQtd() { return qtd; }
    public void setQtd(int qtd) { this.qtd = Formatador.exigirPositivo(qtd, "Quantidade"); }

    public double getSubtotal() {
        return Formatador.arredondar((bebida != null ? bebida.getPreco() : 0.0) * qtd);
    }

    @Override
    public String toString() {
        return qtd + "x "
                + (bebida != null ? bebida.getNome() : "")
                + " = R$ " + Formatador.moeda(getSubtotal());
    }
}
