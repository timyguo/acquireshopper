require(data.table);require(dplyr);require(RPostgreSQL);

drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv, host='192.168.1.7', port=5432, user='postgres', password='zaqxsw', dbname='kaggle_valued_shoppers')

trans <- fetch(dbSendQuery(con, 'select * from model.trans'), n=-1)

testHistory <- fread('data/testHistory.csv', colClasses=rep('numeric',5))
testHistory[,offerdate:=as.Date(offerdate)]
trainHistory <- fread('data/testHistory.csv', colClasses=rep('numeric',5))
trainHistory[,offerdate:=as.Date(offerdate)]
offers <- fread('data/offers.csv', colClasses=rep('numeric',6))
sampleSubmission <- fread('data/sampleSubmission.csv', colClasses=rep('numeric',2))
trans <- fread('data/trans.csv', colClasses=rep('numeric',11))
trans[,date:=as.Date(date)][,productmeasure:=factor(productmeasure)]

save(testHistory, trainHistory, offers, sampleSubmission, trans, file='modeldata.rdata')
