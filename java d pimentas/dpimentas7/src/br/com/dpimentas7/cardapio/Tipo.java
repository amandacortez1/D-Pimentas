package br.com.dpimentas7.cardapio;

import br.com.dpimentas7.util.Formatador;

public class Tipo {
    private int codigo;
    private String descricao;

    public Tipo() {}

    public Tipo(int codigo, String descricao) {
        this.codigo = codigo;
        setDescricao(descricao);
    }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = Formatador.exigirTexto(descricao, "Descrição do tipo"); }

    @Override
    public String toString() {
        return codigo + " - " + descricao;
    }
}
