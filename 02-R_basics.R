# review vectors
# a vector is an ordered sequence of 
# any one class type
my_pets_ages <- c(8, 2, 6, 3, 1)
my_pets_names <- c("Daisy", "Violet", "Lily",
                   "Iris", "Poppy")
class(my_pets_ages)
class(my_pets_names)

# index a vector
my_pets_names[2]

# Create a dataframe
my_pets <- data.frame(name = my_pets_names,
                      age = my_pets_ages)
# what's the class of my_pets
class(my_pets)

# summarized info
summary(my_pets)

# number of rows
nrow(my_pets)

# number of columns in my_pets
ncol(my_pets)

# dimensions of my_pets
dim(my_pets)

# column names
colnames(my_pets)

# indexing dataframes
my_pets
# retrieve value in third row and second column
my_pets[3, 2]

# retrieve all values for fourth row
my_pets[4, ]

# retrieve all values in second column
my_pets[ , 2]
my_pets[ , "age"]
my_pets$age

# retrieve age of second pet
my_pets$age[2]

# descriptive stats
# Run different functions such as sum(), mean(),
# min(), max(), sd() on the age column in the
# my_pets dataframe
sum(my_pets$age)
mean(my_pets$age)
median(my_pets$age)
sort(my_pets$age)

# different way to calculate mean
sum(my_pets$age)/nrow(my_pets)

# min value
min(my_pets$age)
max(my_pets$age)
sd(my_pets$age)

# Operations with dataframe columns/variables
my_pets$age * 4

# create a new column in my dataframe
# that is age multiplied by 4 to create
# a human_age variable
my_pets$human_age <- my_pets$age * 4
my_pets

# create a TRUE/FALSE variable, to indicate
# whether each pet is older than 2
my_pets_ages > 2
my_pets$older_two <- my_pets_ages > 2
my_pets

# always select a column/variable in your
# dataframe to do the operation/comparison
# with
my_pets$age * 4
my_pets$age > 2

# sum() and mean() required a numeric variable
sum(my_pets$age)
# sum(my_pets$name) # error
summary(my_pets)
# logical variables are also numeric
# 0 means FALSE, 1 means TRUE
sum(my_pets$older_two)
mean(my_pets$older_two)
