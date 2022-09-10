color_p <- colorRampPalette(c('#0dec53','#2ac2cf'))(20)
color_m <- colorRampPalette(c('#f90076','#f95b00'))(20)
background_b <- '#000518'



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
plot(x, type = 'l', col = paste0(p,0), pch = 16, axes= FALSE)
lines(smooth.spline(x, df = 15), col = p)

arrows(x0 = seq(1,20,1), x1 = seq(1,20,1),
       y0 = rep(0,20), y1 = x,
       code = 3, col = paste0(p,53), length = 0)
points(x, col = p)
abline(h = 0, col = paste0(p,33))


