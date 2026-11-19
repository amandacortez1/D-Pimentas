package br.com.dpimentas7;

import br.com.dpimentas7.administrativo.FolhaPagamentoContrato;
import br.com.dpimentas7.administrativo.TipoContrato;
import br.com.dpimentas7.cardapio.Bebida;
import br.com.dpimentas7.cardapio.Marmitex;
import br.com.dpimentas7.cardapio.TamanhoMarmitex;
import br.com.dpimentas7.cardapio.Tipo;
import br.com.dpimentas7.localizacao.Cep;
import br.com.dpimentas7.localizacao.Cidade;
import br.com.dpimentas7.localizacao.Uf;
import br.com.dpimentas7.pedido.Entrega;
import br.com.dpimentas7.pedido.Pedido;
import br.com.dpimentas7.pedido.PedidoBebida;
import br.com.dpimentas7.pedido.PedidoMarmitex;
import br.com.dpimentas7.pessoa.Cliente;
import br.com.dpimentas7.pessoa.Entregador;
import br.com.dpimentas7.pessoa.Funcionario;
import br.com.dpimentas7.pessoa.Telefone;
import br.com.dpimentas7.util.Formatador;
import java.time.LocalDate;


public class Main {

    public static void main(String[] args) {
        titulo("1. Localização");
        Uf sp = new Uf("sp", "São Paulo");
        Cidade rioPreto = new Cidade(1, "São José do Rio Preto", sp);
        Cep cep = new Cep("15025-000", rioPreto);
        System.out.println(sp);
        System.out.println(rioPreto);
        System.out.println(cep);

        titulo("2. Pessoas");
        Funcionario atendente = new Funcionario(1, "Maria Souza", "529.982.247-25", cep, "Rua das Flores", 120, 2200.00);
        atendente.setEmail("maria@dpimentas7.com.br");
        atendente.setNivelAcesso("ADMIN");

        Cliente cliente = new Cliente(2, "João Lima", "111.444.777-35", cep, "Av. Brasil", 450, 4.5);
        Entregador entregador = new Entregador(3, "Carlos Pereira", "123.456.789-09", cep, "Rua A", 10, 80.00);

        System.out.println(atendente);
        System.out.println(cliente);
        System.out.println(entregador);
        System.out.println(new Telefone(cliente, "(17) 99123-4567"));
        System.out.println("Endereço do cliente: " + cliente.getEnderecoCompleto());

        titulo("3. Cardápio");
        Tipo carne = new Tipo(1, "Carne");
        Tipo frango = new Tipo(2, "Frango");
        Marmitex bife = new Marmitex(1, "Bife acebolado", carne, 0.00);
        Marmitex parmegiana = new Marmitex(2, "Frango à parmegiana", frango, 4.50);
        TamanhoMarmitex pequena = new TamanhoMarmitex(1, "Pequena", 16.00, 1);
        TamanhoMarmitex grande = new TamanhoMarmitex(2, "Grande", 22.00, 2);
        Bebida refri = new Bebida(1, "Guaraná 2L", 10, 9.50);
        Bebida suco = new Bebida(2, "Suco de laranja", 3, 6.00);

        System.out.println(bife);
        System.out.println(parmegiana);
        System.out.println(pequena);
        System.out.println(grande);
        System.out.println(refri);
        System.out.println(suco);

        titulo("4. Pedido com entrega");
        Pedido pedido = new Pedido(1, cliente);
        pedido.setFuncionario(atendente);
        pedido.adicionarMarmitex(grande, parmegiana, 2, "sem cebola");
        pedido.adicionarMarmitex(pequena, bife, 1, null);
        pedido.adicionarBebida(refri, 2);
        pedido.setEntrega(new Entrega(1, entregador));
        pedido.setObservacaoGeral("Tocar a campainha");

        for (PedidoMarmitex m : pedido.getMarmitexes()) System.out.println("  " + m);
        for (PedidoBebida b : pedido.getBebidas()) System.out.println("  " + b);
        System.out.println(pedido);
        System.out.println(pedido.getEntrega());
        System.out.println("Estoque do refri após o pedido: " + refri.getEstoque());

        pedido.setStatus(Pedido.STATUS_EM_PREPARO);
        pedido.setStatus(Pedido.STATUS_PRONTO);
        pedido.getEntrega().setStatus(Entrega.STATUS_EM_ROTA);
        System.out.println(pedido + " / " + pedido.getEntrega());
        pedido.getEntrega().setStatus(Entrega.STATUS_ENTREGUE);
        pedido.setStatus(Pedido.STATUS_FINALIZADO);
        System.out.println(pedido + " / " + pedido.getEntrega());

        titulo("5. Pedido cancelado (estoque devolvido)");
        Pedido retirada = new Pedido(2, cliente);
        retirada.adicionarBebida(suco, 3);
        System.out.println(retirada + " | Estoque do suco: " + suco.getEstoque());
        retirada.cancelar();
        System.out.println(retirada + " | Estoque do suco: " + suco.getEstoque());

        titulo("6. Contrato e folha de pagamento");
        TipoContrato clt = new TipoContrato(1, "CLT");
        FolhaPagamentoContrato contrato = new FolhaPagamentoContrato();
        contrato.setCodigo(1);
        contrato.setFuncionario(atendente);
        contrato.setTipoContrato(clt);
        contrato.setNumeroContrato("CT-2026-001");
        contrato.setDataInicio(LocalDate.of(2026, 1, 5));
        contrato.setSalarioBase(atendente.getSalario());
        contrato.setAdicional(150.00);
        System.out.println(contrato + " | Vigente: " + contrato.isContratoVigente());
        contrato.encerrar(atendente, "Fim do período de contrato");
        System.out.println(contrato + " | Vigente: " + contrato.isContratoVigente());

        titulo("7. Validações (erros esperados)");
        testar("CPF inválido", () -> new Cliente(9, "Teste", "111.111.111-11", cep, "Rua X", 1, 5));
        testar("Estrelas fora do intervalo", () -> cliente.setEstrelas(7));
        testar("Estoque insuficiente", () -> new Pedido(3, cliente).adicionarBebida(suco, 50));
        testar("Alterar pedido finalizado", () -> pedido.adicionarBebida(refri, 1));
        testar("CEP inválido", () -> new Cep("123", rioPreto));
        testar("Preço negativo", () -> refri.setPreco(-1));
        testar("Fim antes do início", () -> contrato.setDataFim(LocalDate.of(2025, 1, 1)));

        System.out.println();
        System.out.println("Faturamento do pedido #1: R$ " + Formatador.moeda(pedido.getPreco()));
    }

    private static void titulo(String texto) {
        System.out.println();
        System.out.println("=== " + texto + " ===");
    }

    private static void testar(String descricao, Runnable acao) {
        try {
            acao.run();
            System.out.println("  [FALHA] " + descricao + ": nenhuma exceção lançada");
        } catch (IllegalArgumentException | IllegalStateException e) {
            System.out.println("  [OK] " + descricao + " -> " + e.getMessage());
        }
    }
}
