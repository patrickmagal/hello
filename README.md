# Poker Hand Evaluator - Desafio de Live Code em Ruby

## Introdução

Este exercício de live code em Ruby avalia competências em **algoritmos** (manipulação de arrays/hashes, ordenação, contagem de frequências), **POO** (modelagem de classes, encapsulamento, composição) e **recursos idiomáticos de Ruby** (Enumerable, blocos, metaprogramação).

O candidato deve implementar um avaliador de mãos de poker que classifica cinco cartas em uma de dez categorias hierárquicas, tratando casos especiais como o **Ás dual** (alto/baixo) e priorizando sempre a classificação mais alta.

## Referências e Origens

Este desafio é baseado em problemas recorrentes de entrevistas técnicas e exercícios clássicos de programação:

- [Codecademy - 10 Advanced Ruby Code Challenges](https://www.codecademy.com/resources/blog/advanced-ruby-code-challenges)
- [Kata Poker Hands (fredwu)](https://github.com/fredwu/kata-poker-hands-ruby)
- [Poker Hand Kata (ancorcruz)](https://github.com/ancorcruz/poker-hand)
- [Code Review - Weekend Challenge: Ruby Poker Hand Evaluation](https://codereview.stackexchange.com/questions/37165/weekend-challenge-ruby-poker-hand-evaluation)
- [Gist com implementação e testes (Flambino)](https://gist.github.com/Flambino/2c67651035f59c9820fd)

---

## Enunciado do Problema

### Entrada

String contendo exatamente **cinco cartas** de baralho padrão, separadas por espaços.

```
"AH KH QH JH TH"
```

Cada carta: 2 caracteres (`valor` + `naipe`)

### Saída

Classificação da mão de poker (da maior para menor hierarquia), retornada como **Symbol**.

```ruby
:royal_flush  # Sempre a classificação mais alta aplicável
```

---

## Formato das Cartas

### Valores Válidos

| Caractere | Significado       |
|-----------|-------------------|
| `2`-`9`   | Números           |
| `T`       | 10                |
| `J`       | Valete (Jack)     |
| `Q`       | Dama (Queen)      |
| `K`       | Rei (King)        |
| `A`       | Ás (dual: alto/baixo) |

### Naipes Válidos

| Símbolo | Caractere | Nome              |
|---------|-----------|-------------------|
| ♥       | `H`       | Hearts (Copas)    |
| ♠       | `S`       | Spades (Espadas)  |
| ♦       | `D`       | Diamonds (Ouros)  |
| ♣       | `C`       | Clubs (Paus)      |

---

## Hierarquia de Mãos de Poker

| # | Mão               | Descrição                                              | Exemplo             |
|---|-------------------|--------------------------------------------------------|---------------------|
| 1 | **Royal Flush**   | A, K, Q, J, 10 do mesmo naipe                         | `"AH KH QH JH TH"` |
| 2 | **Straight Flush**| Sequência numérica do mesmo naipe                      | `"9S TS JS QS KS"`  |
| 3 | **Four of a Kind**| Quatro cartas do mesmo valor                           | `"AH AD AC AS 2C"`  |
| 4 | **Full House**    | Três de um valor + par de outro                        | `"AH AD AC KH KS"`  |
| 5 | **Flush**         | Cinco cartas do mesmo naipe                            | `"2H 7H 9H JH AH"`  |
| 6 | **Straight**      | Sequência numérica com naipes mistos                   | `"5H 6S 7D 8C 9H"`  |
| 7 | **Three of a Kind** | Três cartas do mesmo valor                           | `"QH QD QC 2C 3H"`  |
| 8 | **Two Pair**      | Dois pares de valores diferentes                       | `"AH AD KH KS 2C"`  |
| 9 | **Pair**          | Um par de mesmo valor                                  | `"JH JD 2C 3H 4S"`  |
| 10| **High Card**     | Nenhuma combinação especial                            | `"2S 4H 6D 8C JS"`  |

---

## Caso Especial: Ás Dual

O **Ás (A)** possui comportamento dual:
- Em geral vale **14** (maior carta)
- Pode valer **1** na sequência especial **A-2-3-4-5**

Esta é uma das complexidades mais importantes do exercício.

---

## Estrutura do Projeto

```
poker-hand-evaluator/
├── README.md                    # Este arquivo (enunciado)
├── Gemfile                      # Dependências
├── challenge/                   # DESAFIO (esqueleto para implementar)
│   ├── lib/
│   │   ├── card.rb              # Classe Card (esqueleto)
│   │   └── poker_hand.rb        # Classe PokerHand (esqueleto)
│   └── spec/
│       ├── spec_helper.rb
│       ├── card_spec.rb         # Testes para Card
│       └── poker_hand_spec.rb   # Testes para PokerHand
└── solution/                    # SOLUÇÃO DE REFERÊNCIA
    ├── lib/
    │   ├── card.rb              # Card implementada
    │   └── poker_hand.rb        # PokerHand implementada
    └── spec/
        ├── spec_helper.rb
        ├── card_spec.rb         # Mesmos testes
        └── poker_hand_spec.rb   # Mesmos testes
```

---

## Como Executar

### Instalar dependências

```bash
cd poker-hand-evaluator
bundle install
```

### Rodar testes do desafio (vão falhar até implementar)

```bash
cd challenge
bundle exec rspec
```

### Rodar testes da solução (devem passar)

```bash
cd solution
bundle exec rspec
```

---

## Requisitos Técnicos

### Classe `Card`
- Constantes de mapeamento de valores e naipes
- Validação rigorosa do input
- Atributos `rank`, `suit`, `value`
- Métodos `to_s` e `inspect`

### Classe `PokerHand`
- Recebe string com 5 cartas
- Valida entrada (formato, quantidade, duplicatas)
- Método `evaluate` que retorna a classificação como Symbol
- Métodos privados para cada verificação de mão
- Tratamento do Ás dual na verificação de straights

---

## Competências Avaliadas

| Área                    | O que se avalia                                           |
|-------------------------|-----------------------------------------------------------|
| **Algoritmos**          | Ordenação, contagem de frequências, verificação de sequências |
| **POO**                 | Modelagem de classes, encapsulamento, composição          |
| **Ruby Idiomático**     | Enumerable, blocos, símbolos, metaprogramação             |
| **Qualidade de Código** | Nomenclatura, DRY, separação de responsabilidades         |
| **Extensibilidade**     | Facilidade de adicionar novas regras                      |

---

## Dicas

1. Comece pela classe `Card` — ela é mais simples e será usada por `PokerHand`
2. Use `Hash` para mapear valores de cartas para inteiros
3. O método `tally` (Ruby 2.7+) é muito útil para contagem de frequências
4. `each_cons(2)` é elegante para verificar sequências consecutivas
5. Lembre-se: a ordem de verificação no `evaluate` importa (mais alta primeiro)

Boa sorte! 🃏
