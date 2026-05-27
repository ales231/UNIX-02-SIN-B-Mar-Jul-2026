
# View the current primary group
id
id-gn # only the primary group name
# Create a file and see which group inherits 
touch ~/test_grupo_heredado.txt
Is -la ~/test_grupo_heredado.txt
# The group is the user's primary group
# View the current group
id -gn
echo "Current group: $(id -gn)"
# Create a file before newgrp
touch ~/antes_de_newgrp.txt
is -la ~/antes_de_newgrp.txt
# Change to the developers group
newgrp desarrolladores
# Verify that the active group has changed
id -gn
echo "New active group: $(id-gn)"
# Create a file inside the subshell
touch ~/inside_newgrp.txt
Is -la ~/inside_newgrp.txt
# The group is now developers
# Create a directory
mkdir -p ~/dev_project/src
Is -la -/
# project_dev/ has group 'developers'
# Exit the newgrp subshell
exit
# Verify that we returned to the original group
id -gn
echo "Group restored: $ (id -gn)"
# Compare the two files
Is -la ~/before_newgrp.txt
~/inside_newgrp.txt
