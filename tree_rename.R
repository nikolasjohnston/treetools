
#PURPOSE: This script will rename tree tips based on a provided .csv file ith two columns 1) old lables, 2) new labels.


#USAGE:
#Rscript tree_rename.R tree_file_path label_data_path output_file_path

#Argument details:
#where tree_file_path is your treefile, label_data_path is a csv file with two columns 1) old lables, 2) new labels, output_file_path is the output file name
# if you want labels to remain the same do not include data for these in the .csv file

# Check if 'ape' package is installed; if not, install it
if (!requireNamespace("ape", quietly = TRUE)) {
  install.packages("ape")
}

# Load the 'ape' package
library("ape")

# Function to get command line arguments
get_args <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) != 3) {
    stop("Please provide exactly three arguments: tree_file_path label_data_path output_file_path")
  }
  return(args)
}

# Get command line arguments
args <- get_args()
tree_file_path <- args[1]
label_data_path <- args[2]
output_file_path <- args[3]

# Set working directory to the current directory the script is run from
working_directory <- getwd()
setwd(working_directory)

# Read the tree file and label data file
tree_file <- read.tree(tree_file_path)
label_data <- read.csv(label_data_path)

# Create a named vector for the new labels with original labels as names
label_dict <- setNames(label_data$new_label, label_data$old_label)

# Create a new tree by renaming the tip labels
new_tree <- tree_file
new_tree$tip.label <- sapply(tree_file$tip.label, function(tip) {
  if (tip %in% names(label_dict)) {
    return(label_dict[[tip]])
  } else {
    return(tip)
  }
})

# Plot the original and the new tree side by side
par(mfrow = c(1, 2))
plot(tree_file, main = "Original Tree")
plot(new_tree, main = "Renamed Tree")

# Write the new tree to a file
write.tree(new_tree, file = output_file_path)
