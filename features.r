load('data/modeldata.rdata')

setkey(trans, id)

trans[, lastndays:=tail(date,1)-date, by=id]

#
