# data collected in field
field_data = data.frame(reach = c(1,1,1, 1), 
                        species = c("A", "B", "C", "C"),
                        length = c(149, 151, 160, 0),
                        weight = c(0, 30, 28, 0))

# my controlled/known list of species
species_list = c("A", "B", "D")

# 1. check species counts
table(field_data$species)

# 2. check for correct species names
field_data$species_qc_flag <- field_data$species %in% species_list

table(field_data$species_qc_flag)

dplyr::filter(field_data, species_qc_flag == FALSE)

# 3. check for fish below 150 mm that have been recorded with a weight 
field_data$length_qc_flag <- ifelse(field_data$length < 150 & field_data$weight == 0, 
                                 'flag', # if conditions are met, output this
                                 'good') # if conditions are not met, output this

# 3b. a non vectorized way to build a multi level if-else structure
# non-vectorized = this function takes one set or 'row' of inputs, and will not accept an entire data frame
length_flag <- function(length, weight){
    if (length < 150 & weight == 0){
        return('flag')
    } else {
        return('good')
    }
}

## need to vectorize function so it accepts multiple input rows and outputs multiple rows
length_flagV <- Vectorize(length_flag)

length_flag(field_data$length, field_data$weight)

length_flagV(field_data$length, field_data$weight)

## test cases
length_flag(148, 0) # should return flag
length_flag(151, 10) # should return good
