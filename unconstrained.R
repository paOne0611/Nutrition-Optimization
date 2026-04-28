loc=""  ##give location where saved the .RData file in your device containing the objects
load(loc)

breakfast_item <- sample_prop %>% 
  filter(breakfast == 1) %>% 
  sample_n(1, replace = FALSE)

dinner_item <- sample_prop %>% 
  filter(dinner == 1) %>% 
  sample_n(1, replace = FALSE)

lunch <- sample_prop %>% 
  filter(lunch == 1) 

snacks_item <- sample_prop %>% 
  filter(snacks == 1) %>% 
  sample_n(1, replace = FALSE)
##what sample to take such that all the constraints are satisfies
consumed <- rbind(breakfast_item, snacks_item, dinner_item)

n=1
r1 <- abs(rda_prop[1,5:13] - colSums(consumed[,2:10]))
rownames(r1) <- NULL
#r2 <- r1 / rowSums(r1)

#obj_val <- data.frame()
#sub_logi <- sample$lunch == 1
obj_val <- apply(lunch[, 2:10], 1, function(row) {
  rowSums(row * log(row / r1) - row + r1) |>
    rbind()
}) |> as.matrix()
obj_val <- cbind(food_name = sample[sub_logi,1], obj_val) |> as.data.frame()
obj_val$V2 <- as.numeric(obj_val$V2)
names(obj_val)[2] <- "val"
x=head(obj_val[order(obj_val$val),], 10)
y= sample_prop$food %in% x$food_name
a= sample[y,]  ##nutrients of consumed items in g
y= sample_prop$food %in% consumed$food
b= sample[y,]  ##nutrients of low obj. val items in grams
rda_sub[n,]
##ear_sub have all values in grams
b[1,2:10]+ colSums(a[,2:10])
