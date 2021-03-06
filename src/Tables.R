############################
#### Equipo G
#### Replicacion 1
#### MPA
############################

####Tabla 3##############################
#Read db
DB <- read.dta13("data/basic.dta")
DB <- DB %>% mutate(
  age2 = age^2,
  srvlng2 = srvlng^2
)

####Tabla1: Inter ngirls:female
# 105 & nowtot
T3.R1 <- DB %>% split(.$congress) %>%
  map(~ lm(nowtot ~ ngirls + 
             as.factor(white) + 
             as.factor(party) +
             srvlng + srvlng2 +
             age + age2 +
             as.factor(rgroup) +
             as.factor(region) + 
             as.factor(totchi) + 
             demvote +
             (ngirls*female), 
           data=DB[DB$congress=="105",])) %>% map_dfr(tidy) %>% 
  filter(term=="ngirls" | term=="ngirls:female"| term=="female") %>%
  arrange(term) %>% mutate(congress= rep(x=c(105:108),times=3),
                           source="now") %>%
  arrange(congress) %>% select(congress, source, everything()) %>%
  filter(congress==105)

#  aauw
T3.R2 <- DB %>% split(.$congress) %>%
  map(~ lm(aauw ~ ngirls + 
             as.factor(white) + 
             as.factor(party) +
             srvlng + srvlng2 +
             age + age2 +
             as.factor(rgroup) +
             as.factor(region) + 
             as.factor(totchi) + 
             demvote +
             (ngirls*female), 
           data=.)) %>% map_dfr(tidy) %>% 
  filter(term=="ngirls" | term=="ngirls:female" |term=="female") %>%
  arrange(term) %>% mutate(congress= rep(x=c(105:108),times=3),
                           source="aauw") %>%
  arrange(congress) %>% select(congress, source, everything())

T3.1 <- rbind(T3.R1,T3.R2)
remove(T3.R1,T3.R2)

####Tabla2: Inter ngirls:party
DB <- DB %>% mutate(democratic=ifelse(party==1,1,0))

# 105 & nowtot
T3.R1 <- DB %>% split(.$congress) %>%
  map(~ lm(nowtot ~ ngirls + 
             as.factor(white) + 
             as.factor(female) +
             srvlng + srvlng2 +
             age + age2 +
             as.factor(rgroup) +
             as.factor(region) + 
             as.factor(totchi) + 
             demvote +
             (ngirls*democratic), 
           data=DB[DB$congress=="105",])) %>% map_dfr(tidy) %>% 
  filter(term=="ngirls" | term=="ngirls:democratic") %>%
  arrange(term) %>% mutate(congress= rep(x=c(105:108),times=2),
                           source="now") %>%
  arrange(congress) %>% select(congress, source, everything()) %>%
  filter(congress==105)



#  aauw
T3.R2 <- DB %>% split(.$congress) %>%
  map(~ lm(aauw ~ ngirls + 
             as.factor(white) + 
             as.factor(female) +
             srvlng + srvlng2 +
             age + age2 +
             as.factor(rgroup) +
             as.factor(region) + 
             as.factor(totchi) + 
             demvote +
             (ngirls*democratic), 
           data=.)) %>% map_dfr(tidy) %>% 
  filter(term=="ngirls" | term=="ngirls:democratic") %>%
  arrange(term) %>% mutate(congress= rep(x=c(105:108),times=2),
                           source="aauw") %>%
  arrange(congress) %>% select(congress, source, everything())

T3.2 <- rbind(T3.R1,T3.R2)
remove(T3.R1,T3.R2)
remove(list=ls())

#############################################################################
#5A credito extra
#a
DB <- read.dta13("data/basic.dta")
DB <- DB %>% mutate(
  age2 = age^2,
  srvlng2 = srvlng^2
) %>% filter(congress==108)
DB2 <- read.dta13("data/genold108.dta")
DB <- left_join(DB2,DB) %>% filter(genold!="") 
DB <- unique(DB)
remove(DB2)

#b
T1A.1 <- lm(ngirls ~ 
      as.factor(genold) + 
        as.factor(female) +
     as.factor(white) + 
     as.factor(party) +
     srvlng + srvlng2 +
     age + age2 +
     as.factor(rgroup) +
     as.factor(region) + 
     as.factor(totchi) + 
     demvote,  data=DB) %>% tidy %>%
     filter(term=="as.factor(genold)G")

T1A.2 <- lm(totchi ~ 
              as.factor(genold) + 
              as.factor(female) +
              as.factor(white) + 
              as.factor(party) +
              srvlng + srvlng2 +
              age + age2 +
              as.factor(rgroup) +
              as.factor(region) +
              demvote,  data=DB)  %>% tidy %>%
  filter(term=="as.factor(genold)G")

T1A.3 <- lm(ngirls ~ 
              as.factor(genold) + 
              as.factor(female) +
              as.factor(white) + 
              
              srvlng + srvlng2 +
              age + age2 +
              as.factor(rgroup) +
              as.factor(region) + 
              as.factor(totchi) + 
              demvote,  data=DB[DB$party==1,])  %>% tidy %>%
  filter(term=="as.factor(genold)G")

T1A.4 <- lm(totchi ~ 
              as.factor(genold) + 
              as.factor(female) +
              as.factor(white) + 
              
              srvlng + srvlng2 +
              age + age2 +
              as.factor(rgroup) +
              as.factor(region) + 
              
              demvote,  data=DB[DB$party==1,])  %>% tidy %>%
  filter(term=="as.factor(genold)G")

T1A.5 <- lm(ngirls ~ 
              as.factor(genold) + 
              as.factor(female) +
              as.factor(white) + 
              
              srvlng + srvlng2 +
              age + age2 +
              as.factor(rgroup) +
              as.factor(region) + 
              as.factor(totchi) + 
              demvote,  data=DB[DB$party==2,])  %>% tidy %>%
  filter(term=="as.factor(genold)G")

T1A.6 <- lm(totchi ~ 
              as.factor(genold) + 
              as.factor(female) +
              as.factor(white) + 
              
              srvlng + srvlng2 +
              age + age2 +
              as.factor(rgroup) +
              as.factor(region) + 
              
              demvote,  data=DB[DB$party==2,])  %>% tidy %>%
  filter(term=="as.factor(genold)G")

T1.A <- rbind(T1A.1,T1A.2,T1A.3,T1A.4,T1A.5,T1A.6)

#c
T1A.1.c <- lm(ngirls ~ 
              as.factor(genold),  data=DB) %>% tidy

T1A.2.b <- lm(totchi ~ 
              as.factor(genold) ,  data=DB) %>% tidy

T1A.3.b <- lm(ngirls ~ 
              as.factor(genold) ,  data=DB[DB$party==1,]) %>% tidy

T1A.4.b <- lm(totchi ~ 
              as.factor(genold),  data=DB[DB$party==1,]) %>% tidy

T1A.5.b <- lm(ngirls ~ 
              as.factor(genold),  data=DB[DB$party==2,]) %>% tidy

T1A.6.b <- lm(totchi ~ 
              as.factor(genold) ,  data=DB[DB$party==2,]) %>% tidy

T1.5.c <- rbind(T1A.1.c,T1A.2.b,T1A.3.b,T1A.4.b,T1A.5.b,T1A.6.b) %>%
  filter(term=="as.factor(genold)G")

remove(list=ls())

xtable(T1.5.c)

#############################################################################
#Afirmaciones 
###1
#1.a
DB <- read.dta13("data/basic.dta")
DB <- DB %>% mutate(
  age2 = age^2,
  srvlng2 = srvlng^2
)


R2.1.a.1 <- lm(totchi ~ as.factor(party) ,  data=DB)
R2.1.a.2 <- lm(totchi ~ aauw ,  data=DB)
R2.1.a.3 <- lm(totchi ~ as.factor(rgroup) ,  data=DB)

require(stargazer)
R2.1.a <- stargazer(list(R2.1.a.1,R2.1.a.2,R2.1.a.3),report=c("v","c","s","t","p"))


#1.b falta

#####2 

R2.2.1.a <- lm(aauw ~ ngirls + as.factor(totchi),data=DB)
R2.2.1.b <- lm(aauw ~ ngirls + as.factor(totchi),
               data=DB[DB$totchi!=0,])

R2.2.1.c <- lm(rtl ~ ngirls + as.factor(totchi),data=DB)
R2.2.1.d <- lm(rtl ~ ngirls + as.factor(totchi),
               data=DB[DB$totchi!=0,])

#####3
R2.3 <- lm(propgirls ~ as.factor(party),data=DB)
R2.3.b <- lm(propgirls ~ 
              as.factor(party) + 
              as.factor(female) +
              as.factor(white) + 
              srvlng + srvlng2 +
              age + age2 +
              as.factor(rgroup) +
              as.factor(region) + 
              as.factor(totchi) + 
              demvote,  data=DB)

screenreg(l=list(R2.3,R2.3.b))

#####4

