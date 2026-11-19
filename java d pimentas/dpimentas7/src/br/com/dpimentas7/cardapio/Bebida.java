package br.com.dpimentas7.cardapio;

import br.com.dpimentas7.util.Formatador;
import java.time.LocalDateTime;

public class Bebida {
    private int codigo;
    private String nome;
    private int estoque;
    private double preco;
    private boolean ativo;
    private LocalDateTime atualizadoEm;

    public Bebida() {
        this.ativo = true;
        this.atualizadoEm = LocalDateTime.now();
    }

    public Bebida(int codigo, String nome, int estoque, double preco) {
        this();
        this.codigo = codigo;
        setNome(nome);
        setEstoque(estoque);
        setPreco(preco);
    }

    private void atualizar() { this.atualizadoEm = LocalDateTime.now(); }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; atualizar(); }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = Formatador.exigirTexto(nome, "Nome da bebida"); atualizar(); }

    public int getEstoque() { return estoque; }
    public void setEstoque(int estoque) {
        if (estoque < 0) throw new IllegalArgumentException("Estoque não pode ser negativo.");
        this.estoque = estoque;
        atualizar();
    }

    public double getPreco() { return preco; }
    public void setPreco(double preco) { this.preco = Formatador.exigirNaoNegativo(preco, "Preço"); atualizar(); }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; atualizar(); }

    public LocalDateTime getAtualizadoEm() { return atualizadoEm; }
    public void setAtualizadoEm(LocalDateTime atualizadoEm) { this.atualizadoEm = atualizadoEm; }

    public void baixarEstoque(int qtd) {
        Formatador.exigirPositivo(qtd, "Quantidade");
        if (qtd > estoque) {
            throw new IllegalStateException("Estoque insuficiente de " + nome + " (disponível: " + estoque + ").");
        }
        setEstoque(estoque - qtd);
    }

    public void reporEstoque(int qtd) {
        Formatador.exigirPositivo(qtd, "Quantidade");
        setEstoque(estoque + qtd);
    } 

    @Override
    public String toString() {
        return codigo + " - " + nome
                + " | R$ " + Formatador.moeda(preco)
                + " | Estoque: " + estoque
                + " | Ativo: " + (ativo ? "Sim" : "Não");
    }
}
