package br.com.dpimentas7.pedido;

import br.com.dpimentas7.cardapio.Bebida;
import br.com.dpimentas7.cardapio.Marmitex;
import br.com.dpimentas7.cardapio.TamanhoMarmitex;
import br.com.dpimentas7.pessoa.Cliente;
import br.com.dpimentas7.pessoa.Funcionario;
import br.com.dpimentas7.util.Formatador;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

public class Pedido {
    public static final int STATUS_ABERTO = 1;
    public static final int STATUS_EM_PREPARO = 2;
    public static final int STATUS_PRONTO = 3;
    public static final int STATUS_FINALIZADO = 4;
    public static final int STATUS_CANCELADO = 5;

    public static final String TIPO_RETIRADA = "retirada";
    public static final String TIPO_ENTREGA = "entrega";

    private int nr;
    private LocalDateTime data;
    private double preco;
    private int status;
    private String tipoPedido;
    private String observacaoGeral;
    private Cliente cliente;
    private Funcionario funcionario;
    private Entrega entrega;
    private final List<PedidoMarmitex> marmitexes = new ArrayList<>();
    private final List<PedidoBebida> bebidas = new ArrayList<>();

    public Pedido() {
        this.data = LocalDateTime.now();
        this.status = STATUS_ABERTO;
        this.tipoPedido = TIPO_RETIRADA;
        this.preco = 0.0;
    }

    public Pedido(int nr, Cliente cliente) {
        this();
        this.nr = nr;
        this.cliente = cliente;
    }

    public int getNr() { return nr; }
    public void setNr(int nr) { this.nr = nr; }

    public LocalDateTime getData() { return data; }
    public void setData(LocalDateTime data) {
        if (data == null) throw new IllegalArgumentException("Data do pedido é obrigatória.");
        this.data = data;
    }

    public double getPreco() { return preco; }
    public void setPreco(double preco) { this.preco = Formatador.exigirNaoNegativo(preco, "Preço"); }

    public int getStatus() { return status; }
    public void setStatus(int status) {
        if (status < STATUS_ABERTO || status > STATUS_CANCELADO) {
            throw new IllegalArgumentException("Status de pedido inválido: " + status);
        }
        this.status = status;
    }

    public String getStatusDescricao() {
        switch (status) {
            case STATUS_ABERTO: return "Aberto";
            case STATUS_EM_PREPARO: return "Em preparo";
            case STATUS_PRONTO: return "Pronto";
            case STATUS_FINALIZADO: return "Finalizado";
            case STATUS_CANCELADO: return "Cancelado";
            default: return "Desconhecido";
        }
    }

    public String getTipoPedido() { return tipoPedido; }
    public void setTipoPedido(String tipoPedido) {
        String t = Formatador.exigirTexto(tipoPedido, "Tipo do pedido").toLowerCase();
        if (!t.equals(TIPO_RETIRADA) && !t.equals(TIPO_ENTREGA)) {
            throw new IllegalArgumentException("Tipo de pedido deve ser 'retirada' ou 'entrega'.");
        }
        this.tipoPedido = t;
    }

    public String getObservacaoGeral() { return observacaoGeral; }
    public void setObservacaoGeral(String observacaoGeral) { this.observacaoGeral = observacaoGeral; }

    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }

    public Funcionario getFuncionario() { return funcionario; }
    public void setFuncionario(Funcionario funcionario) { this.funcionario = funcionario; }

    public Entrega getEntrega() { return entrega; }

    /** Ao associar uma entrega o pedido passa a ser do tipo "entrega"; sem entrega volta a "retirada". */
    public void setEntrega(Entrega entrega) {
        this.entrega = entrega;
        this.tipoPedido = (entrega != null) ? TIPO_ENTREGA : TIPO_RETIRADA;
    }

    public List<PedidoMarmitex> getMarmitexes() { return Collections.unmodifiableList(marmitexes); }
    public List<PedidoBebida> getBebidas() { return Collections.unmodifiableList(bebidas); }

    private void exigirAberto() {
        if (status != STATUS_ABERTO) {
            throw new IllegalStateException("Só é possível alterar itens de pedidos abertos (status atual: " + getStatusDescricao() + ").");
        }
    }

    public PedidoMarmitex adicionarMarmitex(TamanhoMarmitex tamanho, Marmitex marmitex, int qtd, String obsTroca) {
        exigirAberto();
        if (tamanho == null || marmitex == null) {
            throw new IllegalArgumentException("Tamanho e marmitex são obrigatórios.");
        }
        if (!marmitex.isAtivo()) {
            throw new IllegalStateException("A marmitex '" + marmitex.getNome() + "' está inativa.");
        }
        Formatador.exigirPositivo(qtd, "Quantidade");
        for (PedidoMarmitex item : marmitexes) {
            if (item.getTamanho().getCodigo() == tamanho.getCodigo()
                    && item.getMarmitex().getCodigo() == marmitex.getCodigo()) {
                item.setQtd(item.getQtd() + qtd);
                if (obsTroca != null && !obsTroca.trim().isEmpty()) item.setObsTroca(obsTroca.trim());
                recalcular();
                return item;
            }
        }
        PedidoMarmitex novo = new PedidoMarmitex(this, tamanho, marmitex, qtd);
        novo.setObsTroca(obsTroca);
        marmitexes.add(novo);
        recalcular();
        return novo;
    }

    /** Adiciona a bebida ao pedido e baixa o estoque. */
    public PedidoBebida adicionarBebida(Bebida bebida, int qtd) {
        exigirAberto();
        if (bebida == null) throw new IllegalArgumentException("Bebida é obrigatória.");
        if (!bebida.isAtivo()) {
            throw new IllegalStateException("A bebida '" + bebida.getNome() + "' está inativa.");
        }
        Formatador.exigirPositivo(qtd, "Quantidade");
        bebida.baixarEstoque(qtd);
        for (PedidoBebida item : bebidas) {
            if (item.getBebida().getCodigo() == bebida.getCodigo()) {
                item.setQtd(item.getQtd() + qtd);
                recalcular();
                return item;
            }
        }
        PedidoBebida novo = new PedidoBebida(this, bebida, qtd);
        bebidas.add(novo);
        recalcular();
        return novo;
    }

    /** Remove a bebida do pedido devolvendo a quantidade ao estoque. */
    public boolean removerBebida(Bebida bebida) {
        exigirAberto();
        Iterator<PedidoBebida> it = bebidas.iterator();
        while (it.hasNext()) {
            PedidoBebida item = it.next();
            if (item.getBebida().getCodigo() == bebida.getCodigo()) {
                item.getBebida().reporEstoque(item.getQtd());
                it.remove();
                recalcular();
                return true;
            }
        }
        return false;
    }

    public boolean removerMarmitex(TamanhoMarmitex tamanho, Marmitex marmitex) {
        exigirAberto();
        boolean removido = marmitexes.removeIf(i -> i.getTamanho().getCodigo() == tamanho.getCodigo()
                && i.getMarmitex().getCodigo() == marmitex.getCodigo());
        if (removido) recalcular();
        return removido;
    }

    /** Cancela o pedido e devolve as bebidas ao estoque. */
    public void cancelar() {
        if (status == STATUS_FINALIZADO) {
            throw new IllegalStateException("Pedido finalizado não pode ser cancelado.");
        }
        if (status != STATUS_CANCELADO) {
            for (PedidoBebida item : bebidas) item.getBebida().reporEstoque(item.getQtd());
            status = STATUS_CANCELADO;
        }
    }

    /** Recalcula o preço total a partir dos itens. */
    public double recalcular() {
        double total = 0.0;
        for (PedidoMarmitex i : marmitexes) total += i.getSubtotal();
        for (PedidoBebida i : bebidas) total += i.getSubtotal();
        this.preco = Formatador.arredondar(total);
        return preco;
    }

    @Override
    public String toString() {
        return "Pedido #" + nr
                + " | Cliente: " + (cliente != null ? cliente.getNome() : "-")
                + " | Total: R$ " + Formatador.moeda(preco)
                + " | Tipo: " + tipoPedido
                + " | Status: " + getStatusDescricao();
    }
}
