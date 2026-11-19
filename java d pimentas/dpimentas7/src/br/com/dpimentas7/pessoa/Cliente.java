package br.com.dpimentas7.pessoa;

import br.com.dpimentas7.localizacao.Cep;

public class Cliente extends Pessoa {
    private double estrelas;

    public Cliente() {
        this.estrelas = 5.0;
    }

    public Cliente(int codigo, String nome, String cpf, Cep cep, String logradouro, int numero, double estrelas) {
        super(codigo, nome, cpf, cep, logradouro, numero);
        setEstrelas(estrelas);
    }

    public double getEstrelas() { return estrelas; }
    public void setEstrelas(double estrelas) {
        if (Double.isNaN(estrelas) || estrelas < 0 || estrelas > 5) {
            throw new IllegalArgumentException("Estrelas deve estar entre 0 e 5.");
        }
        this.estrelas = estrelas;
    }

    @Override
    public String toString() {
        return super.toString() + " | Estrelas: " + estrelas;
    }
}
