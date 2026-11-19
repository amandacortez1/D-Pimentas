package br.com.dpimentas7.pessoa;

import br.com.dpimentas7.localizacao.Cep;
import br.com.dpimentas7.util.Formatador;

public class Funcionario extends Pessoa {
    private double salario;

    public Funcionario() {}

    public Funcionario(int codigo, String nome, String cpf, Cep cep, String logradouro, int numero, double salario) {
        super(codigo, nome, cpf, cep, logradouro, numero);
        setSalario(salario);
    }

    public double getSalario() { return salario; }
    public void setSalario(double salario) {
        this.salario = Formatador.exigirNaoNegativo(salario, "Salário");
    }

    @Override
    public String toString() {
        return super.toString() + " | Salário: R$ " + Formatador.moeda(salario);
    }
}
