library(data.table)
set.seed(45L)
DT  <- data.table(V1=c(1L,2L),
                  V2=LETTERS[1:3],
                  V3=round(rnorm(4),4),
                  V4=1:12) 

DT[]
DT[,.(V1, sd(V3))]
DT[, {print(V2)
  plot(V3) 
  NULL}]
DT[, sum(V4), by = V1]
DT[,sum(V4), by=.(V1,V2)]
DT[,sum(V4), by=sign(V1-1)]
DT[, print(.SD)]