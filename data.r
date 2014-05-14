require(data.table);require(dplyr);require(RPostgreSQL);

drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv, host='192.168.1.7', port=5432, user='postgres', password='zaqxsw', dbname='kaggle_valued_shoppers')

trans <- fetch(dbSendQuery(con, 'select * from model.trans'), n=-1)

testHistory <- fread('data/testHistory.csv', colClasses=c('factor',rep('numeric',4)))
testHistory[,offerdate:=as.Date(offerdate)]
trainHistory <- fread('data/trainHistory.csv', colClasses=c('factor',rep('numeric',6)))
trainHistory[,offerdate:=as.Date(offerdate)]
offers <- fread('data/offers.csv', colClasses=rep('numeric',6))
sampleSubmission <- fread('data/sampleSubmission.csv', colClasses=c('factor',rep('numeric',1)))
trans <- fread('data/trans.csv', colClasses=c('factor',rep('numeric',10)))
trans[,date:=as.Date(date)][,productmeasure:=factor(productmeasure)]

save(testHistory, trainHistory, offers, sampleSubmission, trans, file='modeldata.rdata')
