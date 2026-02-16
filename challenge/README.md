# Poker Hand Evaluator

## Objetivo

Implementar um avaliador de maos de poker em Ruby. O programa deve receber uma string representando 5 cartas de baralho e retornar a classificacao da mao.

---

## Como funciona

### Entrada

Uma string com exatamente **5 cartas** separadas por espacos:

```
"AH KH QH JH TH"
```

Cada carta possui 2 caracteres: o **valor** seguido do **naipe**.

### Saida

A classificacao da mao, retornada como um **Symbol** Ruby:

```ruby
hand = PokerHand.new("AH KH QH JH TH")
hand.evaluate  # => :royal_flush
```

---

## Formato das Cartas

### Valores

| Caractere | Significado |
|-----------|-------------|
| `2`-`9`   | Numeros     |
| `T`       | 10 (Ten)    |
| `J`       | Valete (Jack)   |
| `Q`       | Dama (Queen)    |
| `K`       | Rei (King)      |
| `A`       | As (Ace) - pode ser alto (14) ou baixo (1) |

### Naipes

| Caractere | Naipe             |
|-----------|-------------------|
| `H`       | Copas (Hearts)    |
| `S`       | Espadas (Spades)  |
| `D`       | Ouros (Diamonds)  |
| `C`       | Paus (Clubs)      |

---

## Classificacoes (da maior para a menor)

| # | Mao                 | Descricao                                    | Exemplo             |
|---|---------------------|----------------------------------------------|---------------------|
| 1 | **Royal Flush**     | A, K, Q, J, T do mesmo naipe                | `"AH KH QH JH TH"` |
| 2 | **Straight Flush**  | Sequencia consecutiva do mesmo naipe         | `"5H 6H 7H 8H 9H"` |
| 3 | **Four of a Kind**  | Quatro cartas do mesmo valor                 | `"AH AD AC AS 2C"`  |
| 4 | **Full House**      | Tres de um valor + par de outro              | `"AH AD AC KH KS"`  |
| 5 | **Flush**           | Cinco cartas do mesmo naipe (nao consecutivas) | `"2H 7H 9H JH AH"` |
| 6 | **Straight**        | Sequencia consecutiva com naipes diferentes  | `"5H 6S 7D 8C 9H"`  |
| 7 | **Three of a Kind** | Tres cartas do mesmo valor                   | `"QH QD QC 2C 3H"`  |
| 8 | **Two Pair**        | Dois pares diferentes                        | `"AH AD KH KS 2C"`  |
| 9 | **Pair**            | Um par                                       | `"JH JD 2C 3H 4S"`  |
| 10| **High Card**       | Nenhuma combinacao                           | `"2S 4H 6D 8C JS"`  |

---

## Caso Especial: As Dual

O **As (A)** pode funcionar como carta alta (valor 14) ou carta baixa (valor 1):

- **Carta alta**: nas maos normais e na sequencia `T-J-Q-K-A`
- **Carta baixa**: na sequencia especial `A-2-3-4-5`

Exemplos:
```ruby
PokerHand.new("TH JS QD KC AH").evaluate  # => :straight  (A alto)
PokerHand.new("AH 2S 3D 4C 5H").evaluate  # => :straight  (A baixo)
PokerHand.new("QH KS AD 2C 3H").evaluate  # => :high_card (NAO e sequencia)
```

---

## Estrutura do Projeto

```
challenge/
├── README.md           # Este arquivo
├── Gemfile             # Dependencias
├── .rspec              # Configuracao do RSpec
├── lib/
│   ├── card.rb         # Classe Card (esqueleto para implementar)
│   └── poker_hand.rb   # Classe PokerHand (esqueleto para implementar)
└── spec/
    ├── spec_helper.rb
    ├── card_spec.rb    # Testes da classe Card
    └── poker_hand_spec.rb  # Testes da classe PokerHand
```

---

## O Que Implementar

Voce deve implementar duas classes: `Card` e `PokerHand`. Os esqueletos estao em `lib/` e os testes em `spec/`.

Leia os testes com atencao — eles sao a especificacao completa do comportamento esperado, incluindo validacoes, atributos expostos e formatos de retorno.

---

## Como Executar

### Instalar dependencias

```bash
bundle install
```

### Rodar os testes

```bash
bundle exec rspec
```

Os testes vao falhar inicialmente. Seu objetivo e fazer todos passarem.

---

## Dicas

1. Comece pela classe `Card` — ela e mais simples e sera usada pela `PokerHand`
2. Leia os testes antes de comecar a implementar
3. A ordem em que voce verifica as classificacoes no `evaluate` importa
