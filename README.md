# Produkta cenas optimizācija

**Autors:** Dinārs Alksnītis

R funkciju kopums, ar kuru var aprēķināt produkta pieprasījumu, dienas peļņu, optimālo pārdošanas cenu un sākotnējā ieguldījuma atmaksāšanās periodu. Optimālā cena tiek noteikta ar nelineāro optimizāciju (`optimize()`). Funkcijas izmanto lietotāja ievadītus datus, tāpēc tās var pielietot dažādiem produktiem.

Pilna dokumentācija: [`dokumentacija.html`](dokumentacija.html)

## Faili

| Fails | Apraksts |
|---|---|
| `funkcijas.R` | Funkciju definīcijas |
| `demonstracija.R` | Lietošanas piemērs ar grafikiem |
| `dokumentacija.html` | Pilna dokumentācija |

## Funkcijas

| Funkcija | Apraksts | Formula |
|---|---|---|
| `elastiba(cena1, daudzums1, cena2, daudzums2)` | Pieprasījuma cenu elastība | $e = \ln(Q_2/Q_1) / \ln(P_2/P_1)$ |
| `pieprasijums(cena, cena1, daudzums1, e)` | Pieprasījums pie dotās cenas | $Q(p) = Q_1 (p/P_1)^e$ |
| `dienas_pelna(cena, pasizmaksa, cena1, daudzums1, e, jauda)` | Dienas peļņa | $P(p) = (p - c) \cdot \min(Q(p), J)$ |
| `optimala_cena(min_cena, max_cena, pasizmaksa, cena1, daudzums1, e, jauda)` | Cena ar lielāko dienas peļņu | $\max_{p \in [p_{\min}, p_{\max}]} P(p)$ |
| `atmaksa(izstrades_izmaksas, cena, pasizmaksa, cena1, daudzums1, e, jauda)` | Atmaksāšanās periods dienās | $D = \lceil I / P(p) \rceil$ |

Apzīmējumi: $c$ – pašizmaksa, $J$ – maksimālā dienas jauda, $I$ – sākotnējās izstrādes izmaksas.

## Lietošana

```r
source("funkcijas.R")

e <- elastiba(10, 52, 16, 30)
rezultats <- optimala_cena(7, 50, 2.50, 10, 52, e, 100)
atmaksa(8000, rezultats$maximum, 2.50, 10, 52, e, 100)
```

## Piemērs – 150 ml sejas attīrošās putas

Cenas balstītas uz konkurentu cenām Latvijā (Korres Greek Yoghurt – 10,90 EUR, MOSSA Glow Cocktail – 12,99 EUR, Banila Co. Clean It Zero – 16,00 EUR). Pieprasījums, pašizmaksa un izstrādes izmaksas ir pieņēmumi.

**Ievaddati:** 52 gab./dienā pie 10 EUR, 30 gab./dienā pie 16 EUR; pašizmaksa 2,50 EUR; jauda 100 gab./dienā; izstrādes izmaksas 8000 EUR; cenu intervāls 7–50 EUR.

**Rezultāti:**

| Rādītājs | Vērtība |
|---|---|
| Cenu elastība | -1,17 |
| Optimālā cena | 17,18 EUR |
| Pieprasījums | 27,6 gab./dienā |
| Dienas peļņa | 405,21 EUR |
| Atmaksāšanās periods | 20 dienas |

## Avoti

- [Notino.lv – Korres Greek Yoghurt](https://www.notino.lv/korres/greek-yoghurt-probiotic-foaming-cream-cleanser-attirosas-kremveida-putas-ar-probiotikiem/)
- [Drogas.lv – MOSSA Glow Cocktail](https://www.drogas.lv/lv/adai/sejai/sejas-tirisanai/mossa-glow-cocktail-attirosas-putas-150ml/p/BP_479771)
- [Notino.lv – Banila Co. Clean It Zero Original](https://www.notino.lv/banila-co/clean-it-zero-original-attrosas-krmveida-putas/)
