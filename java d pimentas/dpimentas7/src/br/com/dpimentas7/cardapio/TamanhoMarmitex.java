package br.com.dpimentas7.cardapio;

import br.com.dpimentas7.util.Formatador;

public class TamanhoMarmitex {
    private int codigo;
    private String nome;
    private double precoBase;
    private int limiteMisturas;

    public TamanhoMarmitex() {}

    public TamanhoMarmitex(int codigo, String nome, double precoBase, int limiteMisturas) {
        this.codigo = codigo;
        setNome(nome);
        setPrecoBase(precoBase);
        setLimiteMisturas(limiteMisturas);
    }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = Formatador.exigirTexto(nome, "Nome do tamanho"); }

    public double getPrecoBase() { return precoBase; }
    public void setPrecoBase(double precoBase) { this.precoBase = Formatador.exigirNaoNegativo(precoBase, "Preço base"); }

    public int getLimiteMisturas() { return limiteMisturas; }
    public void setLimiteMisturas(int limiteMisturas) { this.limiteMisturas = Formatador.exigirPositivo(limiteMisturas, "Limite de misturas"); }

    @Override
    public String toString() {
        return nome + " (R$ " + Formatador.moeda(precoBase) + " | Limite: " + limiteMisturas + ")";
    }
}
