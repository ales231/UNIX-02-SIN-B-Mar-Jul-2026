
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