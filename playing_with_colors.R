# Source colors from a file
source(paste0('col_hex.R'))
# Load and play with overwatch league 2021 player data
library(data.table)
options(scipen = 6)

# Read data and define column classes
dt_owl <- fread(file = paste0('rawdata/phs_2021_1.csv'), colClasses = c('Date',rep('character',8),'numeric'))

# Add month name as aggregate field
dt_owl[, start_month := months(start_time)]

# Explore filed names
dt_owl[hero_name %ilike% '^mc', unique(stat_name)]

# Make analysis dataset
dt_analysis <- dt_owl[hero_name %ilike% '^soldier' & stat_name %ilike% '^(time p|damage - w)', lapply(.SD, sum), by = .(player_name, stat_name, start_month), .SDcols = 'stat_amount']

# Use factors, we do not really like them, but here can be quite convenient
dt_analysis[, player_name := factor(player_name)]
dt_analysis[, start_month := factor(start_month, levels = c('April','May','September','June','July','August'))]
# Transform analysis datawseet Long-to-wide
dt_analysis <- dcast(dt_analysis, player_name + start_month ~ stat_name, value.var = c('stat_amount'))

# Calculate weapon damage scaled by time played
dt_analysis[, damage_rate := `Damage - Weapon` / `Time Played`]

# Visualize total sum by month
tab_barplot <- dt_analysis[, sum(damage_rate, na.rm = TRUE), by = start_month]
par(pty = 's')
barplot(tab_barplot[,V1], col = color_m, beside = TRUE, horiz = TRUE, names.arg = tab_barplot[, start_month], col.axis = color_m[1], las = 2, xaxt = 'n', border = NA, xlim = c(0,floor(max(tab_barplot[,V1]))))
axis(side = 1, at = c(0, floor(max(tab_barplot[,V1]))), col.axis = color_m[1], col.lab = color_m[1])
abline(h = 0, col = color_m[1])
title(xlab = 'Soldier 76, monthly damage rate', col.lab = color_m[1])

# Visualize total sum by month by player
dt_analysis[order(start_month)]
b <- barplot(dt_analysis$damage_rate ~ dt_analysis$player_name + dt_analysis$start_month, beside = TRUE, col = color_m, border = NA)
