package br.com.dpimentas7.localizacao;

import br.com.dpimentas7.util.Formatador;

public class Cidade {
    private int codigo;
    private String nome;
    private Uf uf;

    public Cidade() {}

    public Cidade(int codigo, String nome, Uf uf) {
        this.codigo = codigo;
        setNome(nome);
        this.uf = uf;
    }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = Formatador.exigirTexto(nome, "Nome da cidade"); }

    public Uf getUf() { return uf; }
    public void setUf(Uf uf) { this.uf = uf; }

    @Override
    public String toString() {
        return nome + (uf != null ? " / " + uf.getSigla() : "");
    }
}
