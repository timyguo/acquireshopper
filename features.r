load('data/modeldata.rdata')

setkey(trans, id)
names(offers) <- c('offer', paste('offers',names(offers)[-1], sep='.'))
trainHistory <- merge(trainHistory, offers, by='offer')

trans <- merge(trans, trainHistory, by=c('id','chain'))
trans[,beforeoffer:=date<offerdate]
trans[, ndaybeforeoffer:=offerdate-date,by=id]

save(trans, file='data/trans.rdata')

generaten <- function(days, category, offer.category,n){
    return(sum(days<=n&category==offer.category))
}

features.trans <- trans[ndaybeforeoffer>0, paste('category_bought',c(30,60,90)),apply(c(30,60,90),generaten(ndaybeforeoffer, category, offer.category),by=id]
