# This is a script for intro to R
# Basic Operations ####
3 + 2 # add
3 - 2 # subtract
3 * 2 # multiply
7 / 2 # division
3 ** 4 # exponent
3 ^ 4 # exponent
7 %% 2 # modular, remainder
7 %/% 2 # integer division, whole

# Logic Operators ####
3 != 2 # different
3 == 2 # same
3 > 2 # greater than
3 < 2 # less than
3 >= 2 # greater or same
3 <= 2 # less than or same

TRUE | FALSE # or
TRUE & FALSE # and

# Creating Variables ####
first_variable = 5 # assign 5 to first_variable
second_variable <- 5 # assign 5 to second_variable
5 -> third_variable # assign 5 to third_variable

first_variable * second_variable + first_variable
third_variable + first_variable

# Functions
class(first_variable)


# CHALLENGE
# Create an object called daisys_age that holds the number 8. 
# Multiply daisys_age by 4 and save the results in another 
# object called daisys_human_age
daisys_age <- 8
daisys_human_age = daisys_age * 4 # assign result from right to variable on left
daisys_human_age <- daisys_age * 4
daisys_age * 4 -> daisys_human_age
daisys_human_age
class(daisys_age)

# create pet_name variable
pet_name <- "Daisy"
class(pet_name)
daisys_age_string <- "8"
class(daisys_age_string)

# Vector ####
# python: my_pets_ages = [8, 2, 6, 3, 1]
my_pets_ages <- c(8, 2, 6, 3, 1) # create a vector
my_pets_ages_2 <- c(8, 2, 6, "3", 1) # create a vector
my_pets_ages_3 <- list(8, 2, 6, "3", 1) # create a list

# Indexing ####
my_pets_ages[1] # get first element of the vector
my_pets_ages[3] # get third element of the vector

# Operations with vectors
my_pets_ages * 4
my_pets_ages_2 * 4
class(my_pets_ages_2)

my_pets_ages_2 <- as.numeric(my_pets_ages_2)
my_pets_ages_2 * 4

