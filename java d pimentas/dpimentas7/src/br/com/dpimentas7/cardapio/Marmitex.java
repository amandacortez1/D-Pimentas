package br.com.dpimentas7.cardapio;

import br.com.dpimentas7.util.Formatador;
import java.time.LocalDateTime;

public class Marmitex {
    private int codigo;
    private String nome;
    private Tipo tipo;
    private double precoAdicional;
    private boolean ativo;
    private LocalDateTime atualizadoEm;

    public Marmitex() {
        this.ativo = true;
        this.precoAdicional = 0.0;
        this.atualizadoEm = LocalDateTime.now();
    }

    public Marmitex(int codigo, String nome, Tipo tipo, double precoAdicional) {
        this();
        this.codigo = codigo;
        setNome(nome);
        this.tipo = tipo;
        setPrecoAdicional(precoAdicional);
    }

    private void atualizar() { this.atualizadoEm = LocalDateTime.now(); }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; atualizar(); }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = Formatador.exigirTexto(nome, "Nome da marmitex"); atualizar(); }

    public Tipo getTipo() { return tipo; }
    public void setTipo(Tipo tipo) { this.tipo = tipo; atualizar(); }

    public double getPrecoAdicional() { return precoAdicional; }
    public void setPrecoAdicional(double precoAdicional) {
        this.precoAdicional = Formatador.exigirNaoNegativo(precoAdicional, "Preço adicional");
        atualizar();
    }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; atualizar(); }

    public LocalDateTime getAtualizadoEm() { return atualizadoEm; }
    public void setAtualizadoEm(LocalDateTime atualizadoEm) { this.atualizadoEm = atualizadoEm; }

    @Override
    public String toString() {
        return codigo + " - " + nome
                + " | Tipo: " + (tipo != null ? tipo.getDescricao() : "-")
                + " | Adicional: R$ " + Formatador.moeda(precoAdicional)
                + " | Ativo: " + (ativo ? "Sim" : "Não");
    }
}
