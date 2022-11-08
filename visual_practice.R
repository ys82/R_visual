#git test @ aa

rm(list=ls())
library(ggplot2)
library(dplyr)
library(tidyr)
library(lattice)
library(data.table)
library(datasets)

data()

gg<-iris %>% ggplot(aes(Species,Sepal.Length))
gg+geom_point()


mean_Sepal <- iris %>% group_by(Species) %>% summarise(mean_SL = mean(Sepal.Length))
max_Sepal <- iris %>% group_by(Species) %>% summarise(max_SL=max(Sepal.Length))
min_Sepal <- iris %>% group_by(Species) %>% summarise(min_SL=min(Sepal.Length))
range_Sepal <- max_Sepal %>% left_join(min_Sepal,by='Species') %>% mutate(range_SL = max_SL - min_SL)


gg<-iris %>% ggplot(aes(Species,Sepal.Length))
gg+geom_point()
gg+geom_point()+geom_point(data=mean_Sepal,aes(x=Species,y=mean_SL),color='red',size=5)+
  geom_col(data=range_Sepal,aes(Species,range_SL),fill='green',alpha=0.2)


gg+geom_point()+geom_point(data=mean_Sepal,aes(x=Species,y=mean_SL),color='red',size=5)+
  geom_col(data=range_Sepal,aes(Species,range_SL/2),fill='green',alpha=0.2)+
  scale_y_continuous(sec.axis = sec_axis(~.*2,name="range"))+
  coord_cartesian(ylim=c(mean(iris$Sepal.Length)-5*sd(iris$Sepal.Length),
                         mean(iris$Sepal.Length)+5*sd(iris$Sepal.Length)))+
  labs(x="Spec",y="SL",title="sepal.Length vs Species")+
  annotate(geom="text",x="setosa",y=10,label=paste("max_value",max(iris$Sepal.Length), sep="="))


           