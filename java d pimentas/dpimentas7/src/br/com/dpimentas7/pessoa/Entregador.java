package br.com.dpimentas7.pessoa;

import br.com.dpimentas7.localizacao.Cep;
import br.com.dpimentas7.util.Formatador;

public class Entregador extends Pessoa {
    private double valorDiaria;

    public Entregador() {}

    public Entregador(int codigo, String nome, String cpf, Cep cep, String logradouro, int numero, double valorDiaria) {
        super(codigo, nome, cpf, cep, logradouro, numero);
        setValorDiaria(valorDiaria);
    }

    public double getValorDiaria() { return valorDiaria; }
    public void setValorDiaria(double valorDiaria) {
        this.valorDiaria = Formatador.exigirNaoNegativo(valorDiaria, "Valor da diária");
    }

    @Override
    public String toString() {
        return super.toString() + " | Diária: R$ " + Formatador.moeda(valorDiaria);
    }
}
