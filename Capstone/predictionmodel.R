## Preliminary predictive text model

## Given a string of text, this model will predict the next word.
## This model also learns, so the more it is used, the better it gets.

## packages
library(tm)
library(dplyr)
library(RWeka)
library(stringi)

## data
load("ngrams.Rdata")

predict.next.word <- function(inputstring){
  ## pre process input string
  inputstring <- inputstring %>%
    removeNumbers() %>%
    tolower() %>%
    # removeWords(stopwords("en")) %>%
    removePunctuation() %>%
    iconv("latin1", "ASCII", sub = "") %>%
    stripWhitespace()
  
  profanity <- read.csv("bad_words.csv", 
                        header = FALSE)
  profanity <- as.character(profanity[, 1])
  inputstring <- removeWords(inputstring, profanity)
  
  ## split into words
  inputwords <- strsplit(inputstring, " ")[[1]]
  nwords <- length(inputwords[inputwords != ""])
  max = ifelse(nwords >= 7, 8, nwords + 1)
  
  inputwords <- tail(inputwords, max-1)
  
  check_tokens <- paste(c(inputwords, ""), collapse = " ") %>%
    NGramTokenizer(Weka_control(min = 1, max = nwords))
  check_tokens <- check_tokens[endsWith(check_tokens, tail(inputwords, 1))]

    ngrams_n <- ngrams[ngrams$length <= max & ngrams$Freq > 1, ]
  
  possibles <- NULL
  for (i in 1:length(check_tokens)){
    possibles <- rbind(possibles, 
                   ngrams_n[startsWith(ngrams_n$gram, check_tokens[i]) & 
                            ngrams_n$length == 
                              stri_count_words(check_tokens[i]) + 1,])
  }

  if (nwords > 1){
  input_tokens <- inputstring %>%
    NGramTokenizer(Weka_control(min = 2, max = 8))
  
  for (i in 1:length(input_tokens)){
    if (input_tokens[i] %in% ngrams$gram){
      ind <- which(ngrams$gram == input_tokens[i])
      ngrams$Freq[ind] <- ngrams$Freq[ind] + 1
    } else{
      n <- data.frame(gram = input_tokens[i], 
                      Freq = 1, 
                      length = stri_count_words(input_tokens[i]))
      ngrams <- rbind(ngrams, n)
    }
  }
  
  ngrams <- arrange(ngrams, desc(length), desc(Freq))
  save(ngrams, file = "ngrams.Rdata")
  }
  
  possibles %>% 
    arrange(desc(length), desc(Freq)) %>%
    select(gram) %>%
    sapply(strsplit, " ") %>%
    sapply(tail, 1) %>%
    unique() %>%
    head(4)
    
}
