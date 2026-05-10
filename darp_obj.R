library(readxl)

indb <- read_excel("C:/Users/paone/OneDrive/Desktop/G22_DA/Anuvaad_INDB_2024.11.xlsx")

###extracting food names from the recipes.csv file based on the ingregients instead of searching for keywords from the food name column in the indb df
#library(readr)
recipes <- read_xlsx("C:/Users/paone/OneDrive/Desktop/G22_DA/recipes.xlsx")
#View(recipes)

# 2. Define the regex pattern for non-vegetarian keywords (case-insensitive)
non_veg_pattern <- "(?i)\\b(chicken|mutton|fish|egg|meat|prawn|bacon|ham|salami|keema|machli|anda|ande|jhinga|lamb|sausage|sausages)\\b"

# 3. Identify all rows where the ingredient (food_name_org) is non-vegetarian
non_veg_rows <- recipes[grepl(non_veg_pattern, recipes$food_name_org), ] #returns a vector of the indices of the elements of x that yielded a match

# 4. Create the Non-Vegetarian vector with unique recipe names
non_veg_recipes <- unique(non_veg_rows$recipe_name)

# 5. Create the Vegetarian vector
all_recipes <- unique(recipes$recipe_name)
#all_recipes1 <- unique(recipes$recipe_name_org)
veg_recipes <- setdiff(all_recipes, non_veg_recipes)
x=with(indb, food_name %in% non_veg_recipes)

indb[325,43]="malpua"  #malqura is a typo

#x=with(indb, non_veg==1)
#View(indb[,c(2,83)])
#indb$non_veg=as.character(indb$non_veg)
non_veg=numeric(1014)
indb=cbind(indb, non_veg)
indb[x,83]="non_veg"
indb[!x,83]="veg"


pattern_drinks="coffee|tea|squash|thandai|milk|lemonade|fruit punch (with squashes)|lem-o-gin|milkshake|lassi|juice|sharbat|cooler|panna|sorbet|smoothie|egg nog|water|hot chocolate|drink|sherbet|cocoa|kanji|canjee"

pattern_salad="salad|raita|kachumber|aspic|dressing|dip"

pattern_dessert="kheer|butterscotch|choux swans|cream horns|halwa|burfi|cake|pastry|tart|souffle|mousse|custard|jamun|ladoo|chikki|candy|pudding|kulfi|triffle|charlotte|pavlova|malpua|shrikhand|rabri|jelly|ice cream|poda|marmalade|jam|biscuit|cookie|sweet|icing|fool|syrup|meringue|chum chum|rasbhari|rasgulla|rasmalai|murabba|gateau|finger|rounds|filling|frosting|whip|delight"

pattern_curry="curry|dal|sambar|kadhi|yakhni|korma|bhartha|sabzi|sabji|subji|gravy|stew|fricassee|consomme|stock|rasam|sambhar|kofta|jalfrezi|gatte|baghar|tadka"

pattern_bread="chapati|uttapam|chilla|cheela|roti|paratha|parantha|naan|toast|bun|poori|bread|thepla|kulcha|bhatura|pav|flatbread|appam|straw|loaf"

pattern_main="biryani|masala dosa|pulao|rice|pasta|spaghetti|macaroni|noodles|chowmein|lasagne|burger|pizza|kebab|kabab|roast|casserole|manchurian|dhokla|vada|upma|poha|cheela|chilla|idli|dosa|sandwich|patties|patty|steak|khichdi|khichri|tahar|muthia|tikki|roll|cutlet|pakora|pakoda|samosa|vada|bhujia|vangi|nests|aigrette"

pattern_others="sauce|mayonnaise|cream|dip|chutney|masala|powder|soup|shoraba|consomme|stock|puree|preserves|murabba|pickle|achaar|ketchup|dressing"


y_drinks=grepl(pattern_drinks, indb$food_name, ignore.case = TRUE)  #used for pattern matching
y_salad=grepl(pattern_salad, indb$food_name, ignore.case = TRUE)  #used for pattern matching
y_dessert=grepl(pattern_dessert, indb$food_name, ignore.case = TRUE)  #used for pattern matching
y_curry=grepl(pattern_curry, indb$food_name, ignore.case = TRUE)  #used for pattern matching
y_bread=grepl(pattern_bread, indb$food_name, ignore.case = TRUE)  #used for pattern matching
y_main=grepl(pattern_main, indb$food_name, ignore.case = TRUE)  #used for pattern matching
y_others=grepl(pattern_others, indb$food_name, ignore.case = TRUE)  #used for pattern matching

mat=cbind(y_drinks, y_salad, y_dessert, y_curry, y_bread, y_main, y_others)

indb$category=apply(mat, 1, function(row) {
  if (row["y_drinks"]) return("drinks")
  else if (row["y_salad"]) return("salads")
  else if (row["y_dessert"]) return("dessert")
  else if (row["y_curry"]) return("curry")
  else if (row["y_bread"]) return("bread")
  else if (row["y_main"]) return("main")
  else if (row["y_others"]) return("others")
  else return("main")
})

#indb[c(743,745),83]=replicate(2,"dessert")
#indb[c(505,504),84]="main"


# View the distribution of the newly created categories
table(indb$category)

save(indb,recipes, file = "C:\\Users\\paone\\OneDrive\\Desktop\\G22_DA\\clean.RData")




