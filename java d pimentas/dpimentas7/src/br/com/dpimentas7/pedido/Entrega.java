package br.com.dpimentas7.pedido;

import br.com.dpimentas7.pessoa.Entregador;
import java.time.LocalDateTime;

public class Entrega {
    public static final int STATUS_PENDENTE = 1;
    public static final int STATUS_EM_ROTA = 2;
    public static final int STATUS_ENTREGUE = 3;

    private int codigo;
    private LocalDateTime dataHora;
    private int status;
    private Entregador entregador;

    public Entrega() {
        this.dataHora = LocalDateTime.now();
        this.status = STATUS_PENDENTE;
    }

    public Entrega(int codigo, Entregador entregador) {
        this();
        this.codigo = codigo;
        this.entregador = entregador;
    }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public LocalDateTime getDataHora() { return dataHora; }
    public void setDataHora(LocalDateTime dataHora) {
        if (dataHora == null) throw new IllegalArgumentException("Data/hora da entrega é obrigatória.");
        this.dataHora = dataHora;
    }

    public int getStatus() { return status; }
    public void setStatus(int status) {
        if (status < STATUS_PENDENTE || status > STATUS_ENTREGUE) {
            throw new IllegalArgumentException("Status de entrega inválido: " + status);
        }
        this.status = status;
    }

    public String getStatusDescricao() {
        switch (status) {
            case STATUS_PENDENTE: return "Pendente";
            case STATUS_EM_ROTA: return "Em rota";
            case STATUS_ENTREGUE: return "Entregue";
            default: return "Desconhecido";
        }
    }

    public Entregador getEntregador() { return entregador; }
    public void setEntregador(Entregador entregador) { this.entregador = entregador; }

    @Override
    public String toString() {
        return "Entrega #" + codigo
                + " | Status: " + getStatusDescricao()
                + " | Entregador: " + (entregador != null ? entregador.getNome() : "-");
    }
}
