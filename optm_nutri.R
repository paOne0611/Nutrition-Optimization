library(tidyr)
library(readxl)
library(dplyr)

indb <- read_excel("C:/Users/paone/OneDrive/Desktop/G22_DA/Anuvaad_INDB_2024.11.xlsx")
tul <- read.csv("C:/Users/paone/OneDrive/Desktop/G22_DA/TUL.csv")
rda <- read.csv("C:/Users/paone/OneDrive/Desktop/G22_DA/RDA1.csv")
ear <- read.csv("C:/Users/paone/OneDrive/Desktop/G22_DA/ear.csv")

pattern_drinks <- "coffee|tea|squash|thandai|milk|lemonade|fruit punch (with squashes)|lem-o-gin|milkshake|lassi|juice|sharbat|cooler|panna|sorbet|smoothie|egg nog|water|hot chocolate|drink|sherbet|cocoa|kanji|canjee"
pattern_salad <- "salad|raita|kachumber|aspic|dressing|dip"
pattern_dessert <- "kheer|butterscotch|choux swans|cream horns|halwa|burfi|cake|pastry|tart|souffle|mousse|custard|jamun|ladoo|chikki|candy|pudding|kulfi|triffle|charlotte|pavlova|malpua|shrikhand|rabri|jelly|ice cream|poda|marmalade|jam|biscuit|cookie|sweet|icing|fool|syrup|meringue|chum chum|rasbhari|rasgulla|rasmalai|murabba|gateau|finger|rounds|filling|frosting|whip|delight"
pattern_curry <- "curry|dal|sambar|kadhi|yakhni|korma|bhartha|sabzi|sabji|subji|gravy|stew|fricassee|consomme|stock|rasam|sambhar|kofta|jalfrezi|gatte|baghar|tadka"
pattern_bread <- "chapati|uttapam|chilla|cheela|roti|paratha|parantha|naan|toast|bun|poori|bread|thepla|kulcha|bhatura|pav|flatbread|appam|straw|loaf"
pattern_main <- "biryani|masala dosa|pulao|rice|pasta|spaghetti|macaroni|noodles|chowmein|lasagne|burger|pizza|kebab|kabab|roast|casserole|manchurian|dhokla|vada|upma|poha|cheela|chilla|idli|dosa|sandwich|patties|patty|steak|khichdi|khichri|tahar|muthia|tikki|roll|cutlet|pakora|pakoda|samosa|vada|bhujia|vangi|nests|aigrette"
pattern_others <- "sauce|mayonnaise|cream|dip|chutney|masala|powder|soup|shoraba|consomme|stock|puree|preserves|murabba|pickle|achaar|ketchup|dressing"

y_drinks <- grepl(pattern_drinks, indb$food_name, ignore.case = TRUE)
y_salad <- grepl(pattern_salad, indb$food_name, ignore.case = TRUE)
y_dessert <- grepl(pattern_dessert, indb$food_name, ignore.case = TRUE)
y_curry <- grepl(pattern_curry, indb$food_name, ignore.case = TRUE)
y_bread <- grepl(pattern_bread, indb$food_name, ignore.case = TRUE)
y_main <- grepl(pattern_main, indb$food_name, ignore.case = TRUE)
y_others <- grepl(pattern_others, indb$food_name, ignore.case = TRUE)

mat <- cbind(y_drinks, y_salad, y_dessert, y_curry, y_bread, y_main, y_others)

indb$category <- apply(mat, 1, function(row) {
  if (row["y_drinks"]) return("drinks")
  else if (row["y_salad"]) return("salads")
  else if (row["y_dessert"]) return("dessert")
  else if (row["y_curry"]) return("curry")
  else if (row["y_bread"]) return("bread")
  else if (row["y_main"]) return("main")
  else if (row["y_others"]) return("others")
  else return("main")
})

pattern_d <- "rice|salads|pulao|biryani|biriyani|dal|curry|sabzi|sabji|subji|roti|chapati|naan|bhatura|pasta|spaghetti|macaroni|lasagne|khichdi|khichri|khitchdi|stew|stock|kofta|bhartha|yakhni|korma|jalfrezi|roast|grill|tandoori|soup|shoraba|consomme"
pattern_b <- "soup|salads|sandwich|shoraba|consomme|porridge|flakes|idli|dosa|upma|rice|pulao|biryani|biriyani|dal|curry|sabzi|sabji|subji|roti|chapati|naan|pasta|spaghetti|macaroni|kachori|poha|egg|pancake|toast|thepla|chilla|cheela|canjee|puttu|pesarattu|khura|lasagne|khichdi|khichri|khitchdi|stew|stock|kofta|bhartha|yakhni|korma|jalfrezi|roast|grill|tandoori|manchurian|tahar"
pattern_l <- "rice|pulao|salads|biryani|biriyani|dal|curry|sabzi|sabji|subji|roti|chapati|naan|bhatura|pasta|spaghetti|macaroni|lasagne|khichdi|khichri|khitchdi|stew|stock|kofta|bhartha|yakhni|korma|jalfrezi|roast|grill|tandoori|manchurian|tahar"
pattern_s <- "pakora|pakoda|samosa|cutlet|vada|sandwich|roll|burger|pizza|chaat|kebab|kabab|bhujia|chips|biscuit|cookie|mathri|kachori|dip|sauce|chutney|tea|coffee|juice|milkshake|lassi|sharbat|thandai|smoothie|cooler|sorbet|kheer|halwa|burfi|ladoo|laddoo|cake|pastry|pudding|tart|pie|custard|meringue|mousse|souffle|chikki|murukku|mixture|ghujia|gunjia|gateau|finger|rounds|filling|icing|murabba|jam|jelly|sweet|drink|lemonade|lem-o-gin|cocoa|punch|squash|muthia|tikki|aigrette|paras"

d <- grepl(pattern_d, indb$food_name, ignore.case = TRUE)
l <- grepl(pattern_l, indb$food_name, ignore.case = TRUE)
b <- grepl(pattern_b, indb$food_name, ignore.case = TRUE)
s <- grepl(pattern_s, indb$food_name, ignore.case = TRUE)

logi.mat <- cbind(b,l,d,s)
logi_staple <- indb$category=="main" | indb$category=="bread" | indb$category=="curry" | indb$category=="salads"
indb$dinner[d & logi_staple] <- 1
indb$breakfast[b & logi_staple] <- 1
indb$lunch[l & logi_staple] <- 1
indb$snacks[s & (indb$category=="desserts" | indb$category=="drinks")] <- 1

fun_rm <- function(df){
  apply(df, 2, function(col){
    col[col=="-" | col==""] <- NA
    col
  })
}

rda <- fun_rm(rda) |> as.data.frame()
ear <- fun_rm(ear) |> as.data.frame()

ear[,1:5] <- NULL
temp <- rda$Physical.activity.level
rda$Physical.activity.level <- NULL
ear <- cbind(rda[1:21,]$Category.Age.group, rda[1:21,]$Age.Group..years., rda[1:21,]$Body.Wt..kg., ear)
rda$Dietary.Fibre...g.d. <- NULL
ear$Protein..g.kg.d. <- NULL
rda$Protein..g.kg.d. <- NULL

ear[,3:18] <- apply(ear[,3:18], 2, as.numeric, na.rm=TRUE)
rda[,3:18] <- apply(rda[,3:18], 2, as.numeric, na.rm=TRUE)

ear[,c(5:13, 16)] <- apply(ear[,c(5:13, 16)], 2, function(col) col*(1e-3))
ear[,c(14, 15, 17)] <- apply(ear[,c(14,15,17)], 2, function(col) col*(1e-6))
ear$Vit.D..IU.d. <- ear$Vit.D..IU.d. * (1/40) * (1e-6)

rda[,c(5:13, 16)] <- apply(rda[,c(5:13, 16)], 2, function(col) col*(1e-3))
rda[,c(14, 15, 17)] <- apply(rda[,c(14,15,17)], 2, function(col) col*(1e-6))
rda$Vit.D..IU.d. <- rda$Vit.D..IU.d. * (1/40) * (1e-6)

x <- c("age_group","age_yrs","weight","protein","calcium","magnesium","iron","zinc","iodine","vit_b1","vit_b2","vit_b3","vit_b6","vit_b9","vit_b12","vit_c","vit_a","vit_d")
colnames(rda) <- x
colnames(ear) <- x
rda_sub <- rda[1:21,]

vit_d <- indb$vitd2_ug + indb$vitd3_ug

rda_sub <- rda[, c(1:3, 6, 7, 8, 9, 12:14, 16:18)]
ear_sub <- ear[, c(1:3, 6, 7, 8, 9, 12:14, 16:18)]

tul[,1:3] <- NULL
tul <- cbind(ear[,1:3], tul)
tul$Calcium..mg.d. <- NULL
colnames(tul) <- colnames(rda_sub)
tul <- fun_rm(tul) |> as.data.frame()
indb_sub <- indb[, c("food_name","magnesium_mg","iron_mg","zinc_mg","vitb3_mg","vitb6_mg","vitb9_ug","vitc_mg","vita_ug")]
rda_sub <- rda_sub[1:21,]

indb_sub[,c(2:6, 8)] <- indb_sub[,c(2:6, 8)] * (1e-3)
indb_sub[,c(7,9)] <- indb_sub[,c(7,9)] * (1e-6)
sample <- cbind(indb_sub, vit_d*(1e-6))
rda_sub$iodine <- NULL
ear_sub$iodine <- NULL
tul$iodine <- NULL
x <- colnames(rda_sub[,4:12])
colnames(sample)[2:10] <- x

sub <- indb[,84:87]
sample <- cbind(sample, sub)
sample[,11:14] <- apply(sample[,11:14], 2, function(col){
  col[is.na(col)] <- 0
  return(col)
})

sample <- sample[-707,]

breakfast_item <- sample %>% 
  filter(breakfast == 1) %>% 
  sample_n(2, replace = FALSE)

dinner_item <- sample %>% 
  filter(dinner == 1) %>% 
  sample_n(2, replace = FALSE)

lunch <- sample %>% 
  filter(lunch == 1) 

snacks_item <- sample %>% 
  filter(snacks == 1) %>% 
  sample_n(10, replace = FALSE)

consumed <- rbind(breakfast_item, snacks_item, dinner_item)

rda_prop <- data.frame()
rda_prop <- rbind(rda_prop, rda_sub[, 4:12] / rowSums(rda_sub[,4:12])) |> as.data.frame()
rda_prop <- rda_prop[1:6,]
rda_prop <- cbind(rda[1:6,1:3], physical_activity=temp[1:6], rda_prop)

r1 <- abs(rda_prop[2,5:13] - colSums(consumed[,2:10]))
rownames(r1) <- NULL
r2 <- r1 / rowSums(r1)

sample_prop <- data.frame()
sample_prop <- rbind(sample_prop, sample[1:1013, 2:10] / rowSums(sample[1:1013,2:10])) |> as.data.frame()

obj_val <- data.frame()
sub_logi <- sample$lunch == 1
obj_val <- apply(sample_prop[sub_logi,], 1, function(row) {
  rowSums(row * log(row / r2)) |>
    rbind()
}) |> as.matrix()
obj_val <- cbind(food_name = sample[sub_logi,1], obj_val) |> as.data.frame()
obj_val$V2 <- as.numeric(obj_val$V2)
names(obj_val)[2] <- "val"
head(obj_val[order(obj_val$val),], 8)