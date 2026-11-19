package br.com.dpimentas7.administrativo;

import br.com.dpimentas7.pessoa.Funcionario;
import br.com.dpimentas7.util.Formatador;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class FolhaPagamentoContrato {
    public static final String STATUS_ATIVO = "ATIVO";
    public static final String STATUS_ENCERRADO = "ENCERRADO";

    private int codigo;
    private Funcionario funcionario;
    private TipoContrato tipoContrato;
    private String numeroContrato;
    private LocalDate dataInicio;
    private LocalDate dataFim;
    private double salarioBase;
    private double adicional;
    private String statusContrato;
    private boolean ativo;
    private LocalDateTime atualizadoEm;
    private Funcionario funcionarioAtualizacao;
    private String observacao;

    public FolhaPagamentoContrato() {
        this.ativo = true;
        this.statusContrato = STATUS_ATIVO;
        this.atualizadoEm = LocalDateTime.now();
        this.salarioBase = 0.0;
        this.adicional = 0.0;
    }

    private void atualizar() { this.atualizadoEm = LocalDateTime.now(); }

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; atualizar(); }

    public Funcionario getFuncionario() { return funcionario; }
    public void setFuncionario(Funcionario funcionario) { this.funcionario = funcionario; atualizar(); }

    public TipoContrato getTipoContrato() { return tipoContrato; }
    public void setTipoContrato(TipoContrato tipoContrato) { this.tipoContrato = tipoContrato; atualizar(); }

    public String getNumeroContrato() { return numeroContrato; }
    public void setNumeroContrato(String numeroContrato) {
        this.numeroContrato = Formatador.exigirTexto(numeroContrato, "Número do contrato");
        atualizar();
    }

    public LocalDate getDataInicio() { return dataInicio; }
    public void setDataInicio(LocalDate dataInicio) {
        if (dataInicio != null && dataFim != null && dataFim.isBefore(dataInicio)) {
            throw new IllegalArgumentException("A data de início não pode ser posterior à data de fim.");
        }
        this.dataInicio = dataInicio;
        atualizar();
    }

    public LocalDate getDataFim() { return dataFim; }
    public void setDataFim(LocalDate dataFim) {
        if (dataFim != null && dataInicio != null && dataFim.isBefore(dataInicio)) {
            throw new IllegalArgumentException("A data de fim não pode ser anterior à data de início.");
        }
        this.dataFim = dataFim;
        atualizar();
    }

    public double getSalarioBase() { return salarioBase; }
    public void setSalarioBase(double salarioBase) {
        this.salarioBase = Formatador.exigirNaoNegativo(salarioBase, "Salário base");
        atualizar();
    }

    public double getAdicional() { return adicional; }
    public void setAdicional(double adicional) {
        this.adicional = Formatador.exigirNaoNegativo(adicional, "Adicional");
        atualizar();
    }

    public double getValorTotal() {
        return Formatador.arredondar(salarioBase + adicional);
    }

    public String getStatusContrato() { return statusContrato; }
    public void setStatusContrato(String statusContrato) {
        this.statusContrato = Formatador.exigirTexto(statusContrato, "Status do contrato").toUpperCase();
        atualizar();
    }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; atualizar(); }

    public LocalDateTime getAtualizadoEm() { return atualizadoEm; }
    public void setAtualizadoEm(LocalDateTime atualizadoEm) { this.atualizadoEm = atualizadoEm; }

    public Funcionario getFuncionarioAtualizacao() { return funcionarioAtualizacao; }
    public void setFuncionarioAtualizacao(Funcionario funcionarioAtualizacao) {
        this.funcionarioAtualizacao = funcionarioAtualizacao;
    }

    public String getObservacao() { return observacao; }
    public void setObservacao(String observacao) { this.observacao = observacao; atualizar(); }

    public boolean isContratoVigente() {
        LocalDate hoje = LocalDate.now();
        return ativo
                && STATUS_ATIVO.equalsIgnoreCase(statusContrato)
                && (dataInicio == null || !dataInicio.isAfter(hoje))
                && (dataFim == null || !dataFim.isBefore(hoje));
    }

    /** Encerra o contrato registrando quem fez a alteração. */
    public void encerrar(Funcionario responsavel, String motivo) {
        this.statusContrato = STATUS_ENCERRADO;
        this.ativo = false;
        if (dataFim == null || dataFim.isAfter(LocalDate.now())) {
            this.dataFim = LocalDate.now().isBefore(dataInicio != null ? dataInicio : LocalDate.MIN)
                    ? dataInicio : LocalDate.now();
        }
        this.funcionarioAtualizacao = responsavel;
        this.observacao = motivo;
        atualizar();
    }

    @Override
    public String toString() {
        return "Contrato: " + numeroContrato
                + " | Funcionário: " + (funcionario != null ? funcionario.getNome() : "-")
                + " | Tipo: " + (tipoContrato != null ? tipoContrato.getDescricao() : "-")
                + " | Status: " + statusContrato
                + " | Valor Total: R$ " + Formatador.moeda(getValorTotal());
    }
}
