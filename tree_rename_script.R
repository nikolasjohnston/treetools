library("ape")

setwd("~/OneDrive/Work/PostDoc/2024/Research/papers_projects/ABRS_Calliphoridae/DNAwork/tree_files")
tree_file <- read.tree("calimito_comb_wa_filtered.tree")
label_data <- read.csv("label_data.csv")

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
write.tree(new_tree, file = "calimito_comb_wa_filtered_renamed.tree")
# 
# 
# new_tiplabels <- label_data$new_label
# orig_tiplabels <- label_data$old_label
# new_tree <- tree_file;
# new_tree$tip.label <- new_tiplabels[match(tree_file$tip.label,orig_tiplabels)]; 
# par(mfrow=c(1,2));  
# plot(tree_file); 
# plot(new_tree)
# write.tree(new_tree, file = "PCGs_filtered_10_5_renamed.tree")
