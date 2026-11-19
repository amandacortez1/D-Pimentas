package br.com.dpimentas7.localizacao;

import br.com.dpimentas7.util.Formatador;

public class Uf {
    private String sigla;
    private String nome;

    public Uf() {}

    public Uf(String sigla, String nome) {
        setSigla(sigla);
        setNome(nome);
    }

    public String getSigla() { return sigla; }
    public void setSigla(String sigla) {
        String s = Formatador.exigirTexto(sigla, "Sigla da UF").toUpperCase();
        if (s.length() != 2) {
            throw new IllegalArgumentException("A sigla da UF deve ter 2 letras.");
        }
        this.sigla = s;
    }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = Formatador.exigirTexto(nome, "Nome da UF"); }

    @Override
    public String toString() {
        return sigla + " - " + nome;
    }
}
