package br.com.dpimentas7.pessoa;

import br.com.dpimentas7.util.Formatador;

public class Telefone {
    private Pessoa pessoa;
    private String nr;

    public Telefone() {}

    public Telefone(Pessoa pessoa, String nr) {
        this.pessoa = pessoa;
        setNr(nr);
    }

    public Pessoa getPessoa() { return pessoa; }
    public void setPessoa(Pessoa pessoa) { this.pessoa = pessoa; }

    public String getNr() { return nr; }

   
    public void setNr(String nr) {
        String d = Formatador.soDigitos(nr);
        if (d.length() < 10 || d.length() > 11) {
            throw new IllegalArgumentException("Telefone inválido: " + nr);
        }
        this.nr = d;
    }

    public String getNrFormatado() {
        if (nr == null) return "-";
        int corte = nr.length() - 4;
        return "(" + nr.substring(0, 2) + ") " + nr.substring(2, corte) + "-" + nr.substring(corte);
    }

    @Override
    public String toString() {
        return getNrFormatado() + (pessoa != null ? " (" + pessoa.getNome() + ")" : "");
    }
}
