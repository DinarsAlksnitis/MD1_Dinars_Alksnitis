source("funkcijas.R")
options(scipen = 999)

# Produkta dati ----
pasizmaksa <- 2.50
izstrades_izmaksas <- 8000
jauda <- 100

# Cenas un pieprasijuma info ----
cena1 <- 10
daudzums1 <- 52

cena2 <- 16
daudzums2 <- 30

# cenu intervals opt ----
min_cena <- 7
max_cena <- 50

e <- elastiba(cena1, daudzums1, cena2, daudzums2);e
rezultats <- optimala_cena(min_cena, max_cena, pasizmaksa, cena1, daudzums1, e, jauda);rezultats
cena <- rezultats$maximum;cena
pelna <- rezultats$objective;pelna

# Pieprasijums pie opt cenas ----
daudzums <- pieprasijums(cena, cena1, daudzums1, e);daudzums

# When do we turn a profit ? ----
dienas <- atmaksa(izstrades_izmaksas, cena, pasizmaksa, cena1, daudzums1, e, jauda);dienas

# rezultatu izvade
cat("Cenu elastiba:", round(e, 3), "\n",
    "Optimala cena:", round(cena, 2), "EUR\n",
    "Pieprasijums:", round(daudzums, 2), "gab./diena\n",
    "Dienas pelna:", round(pelna, 2), "EUR\n",
    "Atmaksasanas periods:", dienas, "dienas\n")

# Cenu vertibas ----
cenas <- seq(min_cena, max_cena, by = 0.5)
pelnas <- dienas_pelna(cenas, pasizmaksa, cena1, daudzums1,e,jauda)

plot(cenas,pelnas,type = 'l',
     main = "Dienas pelna atkariba no cenas",
     xlab = 'Cena (EUR)',
     ylab = 'Dienas pelna (EUR)')

points(cena,pelna,col='red',pch = 19)
abline(v = cena,col='red',lty = 2)
text(cena,pelna,labels = round(cena,2),pos=4,col='red')

dienu_skaits<- 0:100
kopeja_pelna <- dienu_skaits * pelna - izstrades_izmaksas

# kopeja_pelna

plot(dienu_skaits, kopeja_pelna, type = 'l',
     main = 'Produkta atmaksasanas',
     xlab = 'Dienas',
     ylab = 'Kopeja pelna (EUR)')

abline(h = 0, col = 'red', lty = 2)
abline(v = dienas, col = 'green', lty = 2)
points(dienas, dienas * pelna - izstrades_izmaksas,
       col = 'black', pch = 19)

text(dienas, dienas * pelna - izstrades_izmaksas,labels = dienas, pos = 3, col = 'black')

