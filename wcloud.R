
rm(list=ls()) ## just clears everything down to start

setwd("d:/Data/github/Grant") ## sets working directory, not really necessary, but makes things easier

# Needed <- c("tm", "SnowballC", "stringr")            ## These lines make sure that the packages
# install.packages(Needed, dependencies=TRUE)   ## are installed

library(tm)
#library(SnowballC)
#library(stringr) 

tfile=read.csv(file.choose())  ## opens a file browser so can use other files than your fixed one
tfile=tfile[1] ## only want first column

tfile <- sapply(tfile, function(row) iconv(row, "latin1", "ASCII", sub=""))

tweet_corpus <- Corpus(VectorSource(tfile))
myCorpus <- tweet_corpus


removeURL <- function(x) gsub("http[[:alnum:][:punct:]]*", " ", x)
myCorpus <- tm_map(myCorpus, removeURL)
removeHandle <- function(x) gsub("@[[:alnum:][:punct:]]*"," ",x)
myCorpus <- tm_map(myCorpus, removeHandle)
removeHash <- function(x) gsub("#[[:alnum:][:punct:]]*"," ",x)
myCorpus <- tm_map(myCorpus, removeHash)
changeAmp <- function(x) gsub("&amp;"," ",x)
myCorpus <- tm_map(myCorpus, changeAmp)

myCorpus <- tm_map(myCorpus, tolower) 


# remove some  stop words
myStopwords <- c(stopwords('english'), 'the')
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)

myCorpus <- tm_map(myCorpus, removePunctuation, preserve_intra_word_dashes = TRUE) 



