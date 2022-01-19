install.packages('vegan')
library(vegan)

setwd("D:/Google 드라이브/Research/Stock_dynamical_model/code/Hierarchical structure")
stock_id = c('엑슨모빌', '셰브론', '3M', '다우', '보잉', '캐터필러', '버라이즌커뮤니케이션', '시스코시스템즈',
            '머크', '존슨앤드 존슨', '화이자', '유나이티드 헬스', '월그린스 부츠 얼라이언스', '아메리칸 익스프레스',
            'JP 모건 체이스', '트래블러스', '골드만삭스', '비자카드', 'IBM', '레이시온', '마이크로소프트',
            '인텔', '애플', '코카콜라', '프록터 & 갬블', '맥도날드', '월트디즈니 컴퍼니', '월마트', '홈디포',
            '나이키')
orig_data <- read.csv('orig_dataset/all_close_data.csv', header = FALSE)
names(orig_data) <- stock_id

log_data <- read.csv('log_dataset/log_dataset.csv', header = FALSE) # ln(s(i+1)) - ln(s(i))
names(log_data) <- stock_id

deri_data <- read.csv('modif_dataset/deri_dataset.csv', header = FALSE) # (s(i+1)-s(i))/s(i)
names(deri_data) <- stock_id

coef.corr <- cor(deri_data)  ## create the correlation coefficients
coef.d <- sqrt(2*(1-coef.corr)) # compute distance

d <- as.dist(as.matrix(coef.d)) # find distance matrix 

# Function spantree finds a minimum spanning tree (MST) connecting all points, 
# but disregarding dissimilarities that are at or above the threshold or NA.

tr <- spantree(d)
## Add tree to a metric scaling 
plot(tr, cmdscale(d), type = "t")

## Find a configuration to display the tree neatly
plot(tr, type = "t")

## Depths of nodes
depths <- spandepth(tr)
plot(tr, type = "t", label = depths)

## Plot as a dendrogram
cl <- as.hclust(tr)
plot(cl, main = "Cluster Dendrogram with modified dataset")