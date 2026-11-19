package br.com.dpimentas7.pessoa;

import br.com.dpimentas7.localizacao.Cep;
import br.com.dpimentas7.util.Formatador;

public class Pessoa {
    private int codigo;
    private String nome;
    private String cpf;
    private Cep cep;
    private String logradouro;
    private int numero;
    private String email;
    private String senha;
    private String nivelAcesso;

    public Pessoa() {}

    public Pessoa(int codigo, String nome, String cpf, Cep cep, String logradouro, int numero) {
        this.codigo = codigo;
        setNome(nome);
        setCpf(cpf);
        this.cep = cep;
        this.logradouro = logradouro;
        setNumero(numero);
    }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = Formatador.exigirTexto(nome, "Nome"); }

    /** Retorna somente os 11 dígitos do CPF. */
    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = Formatador.validarCpf(cpf); }
    public String getCpfFormatado() { return Formatador.formatarCpf(cpf); }

    public Cep getCep() { return cep; }
    public void setCep(Cep cep) { this.cep = cep; }

    public String getLogradouro() { return logradouro; }
    public void setLogradouro(String logradouro) { this.logradouro = logradouro; }

    public int getNumero() { return numero; }
    public void setNumero(int numero) {
        if (numero < 0) throw new IllegalArgumentException("Número do endereço inválido.");
        this.numero = numero;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) {
        if (email != null && !email.trim().isEmpty() && !email.trim().matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            throw new IllegalArgumentException("E-mail inválido: " + email);
        }
        this.email = (email == null || email.trim().isEmpty()) ? null : email.trim();
    }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }

    public String getNivelAcesso() { return nivelAcesso; }
    public void setNivelAcesso(String nivelAcesso) { this.nivelAcesso = nivelAcesso; }

    public String getEnderecoCompleto() {
        return (logradouro != null ? logradouro : "-") + ", " + numero
                + (cep != null ? " - " + cep : "");
    }

    @Override
    public String toString() {
        return codigo + " - " + nome + " (" + getCpfFormatado() + ")";
    }
}
