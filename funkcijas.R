# Aprēķina piepr. cenu elastību.
elastiba <- function(cena1, daudzums1, cena2, daudzums2){
  # cena1 - Pirmā zināmā produkta cena
  # daudzums1 - Pieprasījums pie pirmās cenas
  # cena2 - Otrā zināmā produkta cena
  # daudzums2 - Pieprasījums pie otrās cenas
  if(cena1<=0 || cena2 <= 0 || daudzums1 <= 0 || daudzums2 <= 0 || cena1 == cena2){
    stop("Nepareizi ievadīti dati")
  }
  e <- log(daudzums2/daudzums1)/ log(cena2 / cena1)
  return(e)
}

# Aprēķina pieprasījumu pie izvēlētās cenas
pieprasijums <- function(cena,cena1,daudzums1, e){
  # cena - Cena, pie kuras prognozējam pieprasījumu
  # cena1 - Pirmā zināmā produkta cena
  # daudzums1 - Pieprasījums pie pirmās cenas
  # e - Pieprasījuma cenu elastība
  
  daudzums <- daudzums1*(cena/cena1)^e
  
  return(daudzums)
}

# Aprēķina dienas peļņu pie dotās cenas
dienas_pelna <- function(cena, pasizmaksa, cena1, daudzums1, e, jauda){
  # cena - Produkta pārdošanas cena
  # pasizmaksa - Viena produkta mainīgās izmaksas
  # cena1 - Sākotnējā zināmā cena
  # daudzums1 - Pieprasījums pie sākotnējās cenas
  # e - Pieprasījuma cenu elastība
  # jauda - Maksimālais pārdodamais daudzums dienā
  
  daudzums <- pieprasijums(cena,cena1,daudzums1,e)
  pardots <- pmin(daudzums, jauda)
  
  pelna <- (cena - pasizmaksa) * pardots
  
  return(pelna)
}

# Atrod cenu pie kuras dienas peļņa ir vislielākā
optimala_cena <- function(min_cena, max_cena, pasizmaksa, cena1, daudzums1, e, jauda){
  # min_cena - Minimalā pārbaudāmā cena
  # max_cena - Maksimalā pārbaudāmā cena
  # pasizmaksa - Viena produkta mainīgās izmaksas
  # cena1 - Sākotnējā zināmā cena
  # daudzums1 - Pieprasījums pie sākotnējās cenas
  # e - Pieprasījuma cenu elastība
  # jauda - Maksimālais pārdodamais daudzums dienā
  
  f <- function(cena){
    return(dienas_pelna(cena,pasizmaksa,cena1,daudzums1,e,jauda))
  }
  rezultats <- optimize(f, interval = c(min_cena,max_cena), maximum = TRUE)
  
  return(rezultats)
}

# Aprēķina cik dienās produkts atpelnīs sākotnējo ieguldījumu izstrādē
atmaksa <- function(izstrades_izmaksas, cena, pasizmaksa, cena1, daudzums1, e, jauda){
  # izstrades_izmaksas - Sākotnējais ieguldījums produkta izstrādē
  # cena - Produkta pārdošanas cena
  # pasizmaksa - Viena produkta mainīgās izmaksas
  # cena1 - Sākotnējā zināmā cena
  # daudzums1 - Pieprasījums pie sākotnējās cenas
  # e - Pieprasījuma cenu elastība
  # jauda - Maksimālais pārdodamais daudzums diena
  
  pelna <- dienas_pelna(cena,pasizmaksa,cena1,daudzums1,e,jauda)
  if(pelna <= 0){
    return(Inf)
  }
  dienas <- ceiling(izstrades_izmaksas / pelna)
  
  return(dienas)
}
