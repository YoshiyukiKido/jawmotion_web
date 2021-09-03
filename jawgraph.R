library(animation)

csvfile = commandArgs(trailingOnly=TRUE)[1]
giffile <- gsub("\\..+$", "", csvfile)
giffile <- paste(giffile, ".gif", sep = "")
data <- read.csv(csvfile)

n <- nrow(data)
time <- data[1]
ten0.x <- data[8]
ten0.y <- data[76]
ten0.z <- data[144]
eye0.x <- data[47]
eye0.y <- data[115]
eye0.z <- data[183]
eye1.x <- data[50]
eye1.y <- data[118]
eye1.z <- data[186]
ear0.x <- data[9]
ear0.y <- data[77]
ear0.z <- data[145]
ear1.x <- data[23]
ear1.y <- data[91]
ear1.z <- data[159]
ori.x <- (eye0.x + eye1.x)/2
ori.y <- (eye0.y + eye1.y)/2
ori.z <- (eye0.z + eye1.z)/2
data[2] <- ten0.x
data[3] <- ten0.y
data[4] <- ten0.z
plot(data[c(2,3)])
plot(data[c(2,4)])

#saveGIF({
#  ani.options(loop = TRUE)
#  for (i in 1:n)
#  {
#    plot(data[1:i,2],data[1:i,4],xlab="X-Label",ylab="Y-Label",asp = 1,xlim = c(-100,-10),ylim = c(430,370))
#  }
#}, movie.name="gif2.gif", interval=0.02)

#ori wo (0,0,0) ni
ten0.x <- ten0.x - ori.x
ten0.y <- ten0.y - ori.y
ten0.z <- ten0.z - ori.z
eye0.x <- eye0.x - ori.x
eye0.y <- eye0.y - ori.y
eye0.z <- eye0.z - ori.z
eye1.x <- eye1.x - ori.x
eye1.y <- eye1.y - ori.y
eye1.z <- eye1.z - ori.z
ear0.x <- ear0.x - ori.x
ear0.y <- ear0.y - ori.y
ear0.z <- ear0.z - ori.z
ear1.x <- ear1.x - ori.x
ear1.y <- ear1.y - ori.y
ear1.z <- ear1.z - ori.z
data[2] <- ten0.x
data[3] <- ten0.y
data[4] <- ten0.z
plot(data[c(2,3)])
#plot(data[c(2,3)],xlim = c(-10,40),ylim = c(130,100))

#roll
for(i in 1:n){
  #roll wo motomeru
  a <- sqrt(eye1.x[i,1]^2 + eye1.y[i,1]^2)
  b <- eye1.x[i,1]
  c <- -eye1.y[i,1]
  cosr <- b/a
  sinr <- c/a
  
  #z kaitenngyouretu
  x <- cosr*ten0.x[i,1] - sinr*ten0.y[i,1]
  ten0.y[i,1] <- sinr*ten0.x[i,1] + cosr*ten0.y[i,1]
  ten0.x[i,1] <- x
  x <- cosr*eye0.x[i,1] - sinr*eye0.y[i,1]
  eye0.y[i,1] <- sinr*eye0.x[i,1] + cosr*eye0.y[i,1]
  eye0.x[i,1] <- x
  x <- cosr*eye1.x[i,1] - sinr*eye1.y[i,1]
  eye1.y[i,1] <- sinr*eye1.x[i,1] + cosr*eye1.y[i,1]
  eye1.x[i,1] <- x
  x <- cosr*ear0.x[i,1] - sinr*ear0.y[i,1]
  ear0.y[i,1] <- sinr*ear0.x[i,1] + cosr*ear0.y[i,1]
  ear0.x[i,1] <- x
  x <- cosr*ear1.x[i,1] - sinr*ear1.y[i,1]
  ear1.y[i,1] <- sinr*ear1.x[i,1] + cosr*ear1.y[i,1]
  ear1.x[i,1] <- x
  
}
data[2] <- round(ten0.x, digits = 2)
data[3] <- round(ten0.y, digits = 2)
data[4] <- round(ten0.z, digits = 2)
plot(data[c(2,3)])

#yaw
for(i in 1:n){
  #yaw wo motomeru
  a <- sqrt(eye1.x[i,1]^2 + eye1.z[i,1]^2)
  b <- eye1.x[i,1]
  c <- eye1.z[i,1]
  cosy <- b/a
  siny <- c/a
  
  #y kaitenngyouretu
  x <- cosy*ten0.x[i,1] + siny*ten0.z[i,1]
  ten0.z[i,1] <- -siny*ten0.x[i,1] + cosy*ten0.z[i,1]
  ten0.x[i,1] <- x
  x <- cosy*eye0.x[i,1] + siny*eye0.z[i,1]
  eye0.z[i,1] <- -siny*eye0.x[i,1] + cosy*eye0.z[i,1]
  eye0.x[i,1] <- x
  x <- cosy*eye1.x[i,1] + siny*eye1.z[i,1]
  eye1.z[i,1] <- -siny*eye1.x[i,1] + cosy*eye1.z[i,1]
  eye1.x[i,1] <- x
  x <- cosy*ear0.x[i,1] + siny*ear0.z[i,1]
  ear0.z[i,1] <- -siny*ear0.x[i,1] + cosy*ear0.z[i,1]
  ear0.x[i,1] <- x
  x <- cosy*ear1.x[i,1] + siny*ear1.z[i,1]
  ear1.z[i,1] <- -siny*ear1.x[i,1] + cosy*ear1.z[i,1]
  ear1.x[i,1] <- x
}

#face normalization
eye <- eye1.x - eye0.x
eye <- 35/eye
XX <- eye*ten0.x[,1]
YY<- eye*ten0.y[,1]
ZZ <- eye*ten0.z[,1]

plot(XX[,1],YY[,1],asp=1)

#ten0.x <- round(ten0.x, digits = 2)
#ten0.y <- round(ten0.y, digits = 2)
#ten0.z <- round(ten0.z, digits = 2)
XX <- XX/20
YY <- YY/5
plot(XX[,1],YY[,1])
#plot(ten0.x[1:i,1],ten0.y[1:i,1],xlim = c(-10,5),ylim = c(120,100),xlab="X-Label",ylab="Y-Label")
#plot(data[c(2,3)],asp = 1,xlim = c(-10,10),ylim = c(120,90))
#plot(data[c(3,4)])
#plot(data[c(2,3)],type = "l",asp = 1,xlim = c(-10,20),ylim = c(120,90))

saveGIF({
  ani.options(loop = TRUE)
  for (i in 1:n)
  {
    plot(ten0.x[1:i,1],ten0.y[1:i,1],xlab="X-Label",ylab="Y-Label",asp = 1,xlim = c(-10,10),ylim = c(130,100))
  }
}, movie.name=giffile, interval=0.02)

#########################################
#pitch mada matigatteiru
#for(i in 1:n){
#  #pitch wo motomeru
#  a <- sqrt(ear1.y[i,1]^2 + ear1.z[i,1]^2)
#  b <- ear1.y[i,1]
#  c <- -ear1.z[i,1]
#  cosy <- b/a
#  siny <- c/a
#  
#  #x kaitenngyouretu
#  ten0.y[i,1] <- cosy*ten0.y[i,1] - siny*ten0.z[i,1]
#  ten0.z[i,1] <- siny*ten0.y[i,1] + cosy*ten0.z[i,1]
#  eye0.y[i,1] <- cosy*eye0.y[i,1] - siny*eye0.z[i,1]
#  eye0.z[i,1] <- siny*eye0.y[i,1] + cosy*eye0.z[i,1]
#  eye1.y[i,1] <- cosy*eye1.y[i,1] - siny*eye1.z[i,1]
#  eye1.z[i,1] <- siny*eye1.y[i,1] + cosy*eye1.z[i,1]
#  ear0.y[i,1] <- cosy*ear0.y[i,1] - siny*ear0.z[i,1]
#  ear0.z[i,1] <- siny*ear0.y[i,1] + cosy*ear0.z[i,1]
#  ear1.y[i,1] <- cosy*ear1.y[i,1] - siny*ear1.z[i,1]
#  ear1.z[i,1] <- siny*ear1.y[i,1] + cosy*ear1.z[i,1]
#}
#data[2] <- round(ten0.x, digits = 2)
#data[3] <- round(ten0.y, digits = 2)
#data[4] <- round(ten0.z, digits = 2)
#plot(data[c(2,3)])
#plot(data[c(2,3)],xlim = c(-10,10),ylim = c(80,60))
