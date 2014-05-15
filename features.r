load('data/modeldata.rdata')

setkey(trans, id)
names(offers) <- c('offer', paste('offers',names(offers)[-1], sep='.'))
trainHistory <- merge(trainHistory, offers, by='offer')

trans <- merge(trans, trainHistory, by=c('id','chain'))
trans[,beforeoffer:=date<offerdate]
trans[, ndaybeforeoffer:=offerdate-date,by=id]
gc()
save(trans, file='data/trans.rdata')

n.bought.category <- function(n){
    trans[ndaybeforeoffer>0, sum(ndaybeforeoffer<n & category == offers.category), by=id]
}

n.has.bought.category <- function(n){
    trans[ndaybeforeoffer>0, sum(ndaybeforeoffer<n & category == offers.category)>0, by=id]
}

n.bought.company <- function(n){
    trans[ndaybeforeoffer>0, sum(ndaybeforeoffer<n & company == offers.company), by=id]
}

n.has.bought.company <- function(n){
    trans[ndaybeforeoffer>0, sum(ndaybeforeoffer<n & company == offers.company)>0, by=id]
}

merging <- function(a,b){
    return(merge(a,b,by='id'))
}

result <- Reduce(f=merging, lapply(c(30,60,90), FUN=n.bought.category), trainHistory)
