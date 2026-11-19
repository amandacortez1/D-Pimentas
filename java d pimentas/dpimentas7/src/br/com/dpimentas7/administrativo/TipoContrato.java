package br.com.dpimentas7.administrativo;

import br.com.dpimentas7.util.Formatador;

public class TipoContrato {
    private int codigo;
    private String descricao;

    public TipoContrato() {}

    public TipoContrato(int codigo, String descricao) {
        this.codigo = codigo;
        setDescricao(descricao);
    }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = Formatador.exigirTexto(descricao, "Descrição do tipo de contrato"); }

    @Override
    public String toString() {
        return codigo + " - " + descricao;
    }
}
