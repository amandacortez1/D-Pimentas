package br.com.dpimentas7.localizacao;

import br.com.dpimentas7.util.Formatador;

public class Cep {
    private String nr;
    private Cidade cidade;

    public Cep() {}

    public Cep(String nr, Cidade cidade) {
        setNr(nr);
        this.cidade = cidade;
    }

    public String getNr() { return nr; }

    /** Aceita "15000-000" ou "15000000"; armazena somente os 8 dígitos. */
    public void setNr(String nr) {
        String d = Formatador.soDigitos(nr);
        if (d.length() != 8) {
            throw new IllegalArgumentException("CEP inválido: " + nr);
        }
        this.nr = d;
    }

    public String getNrFormatado() {
        return nr == null ? "-" : nr.substring(0, 5) + "-" + nr.substring(5);
    }

    public Cidade getCidade() { return cidade; }
    public void setCidade(Cidade cidade) { this.cidade = cidade; }

    @Override
    public String toString() {
        return getNrFormatado() + (cidade != null ? " - " + cidade.getNome() : "");
    }
}
