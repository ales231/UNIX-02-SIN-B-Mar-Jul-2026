
# View the current primary group
id
id-gn # only the primary group name
# Create a file and see which group inherits 
touch ~/test_inherited_group.txt
Is -la ~/test_inherited_group.txt
# The group is the user's primary group