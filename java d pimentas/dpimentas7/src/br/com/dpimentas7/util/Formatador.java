package br.com.dpimentas7.util;

import java.util.Locale;

public final class Formatador {
    private static final Locale BR = Locale.forLanguageTag("pt-BR");

    private Formatador() {}

    public static String moeda(double valor) {
        return String.format(BR, "%.2f", valor);
    }

    public static double arredondar(double valor) {
        return Math.round(valor * 100.0) / 100.0;
    }

    public static String soDigitos(String texto) {
        return texto == null ? "" : texto.replaceAll("\\D", "");
    }

    public static String exigirTexto(String valor, String campo) {
        if (valor == null || valor.trim().isEmpty()) {
            throw new IllegalArgumentException(campo + " é obrigatório.");
        }
        return valor.trim();
    }

    public static double exigirNaoNegativo(double valor, String campo) {
        if (Double.isNaN(valor) || Double.isInfinite(valor) || valor < 0) {
            throw new IllegalArgumentException(campo + " não pode ser negativo.");
        }
        return valor;
    }

    public static int exigirPositivo(int valor, String campo) {
        if (valor < 1) {
            throw new IllegalArgumentException(campo + " deve ser maior que zero.");
        }
        return valor;
    }

    /** Valida o CPF (dígitos verificadores) e devolve apenas os 11 dígitos. */
    public static String validarCpf(String cpf) {
        String d = soDigitos(cpf);
        if (d.length() != 11 || d.chars().distinct().count() == 1) {
            throw new IllegalArgumentException("CPF inválido: " + cpf);
        }
        for (int t = 9; t <= 10; t++) {
            int soma = 0;
            for (int i = 0; i < t; i++) {
                soma += (d.charAt(i) - '0') * (t + 1 - i);
            }
            int dv = (soma * 10) % 11;
            if (dv == 10) dv = 0;
            if (dv != d.charAt(t) - '0') {
                throw new IllegalArgumentException("CPF inválido: " + cpf);
            }
        }
        return d;
    }

    public static String formatarCpf(String cpf) {
        if (cpf == null || cpf.length() != 11) return cpf == null ? "-" : cpf;
        return cpf.substring(0, 3) + "." + cpf.substring(3, 6) + "." + cpf.substring(6, 9) + "-" + cpf.substring(9);
    }
}
