p <- colorRampPalette(c('#0dec53','#2ac2cf'))(10)
m <- colorRampPalette(c('#f90076','#f95b00'))(10)
b <- '#000518'



A <- 
  matrix(
    c(
      x <- table(cut(rnorm(1000), breaks = 10)),
      y <- table(cut(rnorm(1000), breaks = 10))
    ),
    ncol = 2,
    byrow = FALSE
  )

par(bg = b, pty = 's', font.axis = 3, font.lab = 3, family = 'serif', col.axis = m[5], col.lab = m[5])
barplot(t(A), beside = TRUE, col = c(p,m), border = FALSE, horiz = FALSE)

par(mfrow = c(1,1))
hist(rnorm(1000), col = m, col.lab = m[5], axes = F, main = '')
hist(rnorm(1000), col = p, col.lab = p[5], axes = F, main = '')

#
x <- density(rnorm(1000))
plot(x, col = p, axes = FALSE)
polygon(x, col = paste0(m,33), border = m)

#
par(bg = b, pty = 's', font.axis = 3, font.lab = 3, family = 'serif', col.axis = p[5], col.lab = p[5])
x <- rexp(20)
plot(x, type = 'l', col = paste0(p,33), pch = 16, axes= FALSE)
points(x, col = p)
