dd <- read.table(text="
   RACE        AGE.BELOW.21     CLASS
   HISPANIC          0          A
                 ASIAN             1          A
                 HISPANIC          1          D
                 CAUCASIAN         1          B",
                 header=TRUE)


with(dd,
     data.frame(model.matrix(~RACE-1,dd),
                AGE.BELOW.21,CLASS))
##   RACEASIAN RACECAUCASIAN RACEHISPANIC AGE.BELOW.21 CLASS
## 1         0             0            1            0     A
## 2         1             0            0            1     A
## 3         0             0            1            1     D
## 4         0             1            0            1     B