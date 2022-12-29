package ec2

import input.Reservations

default match = false

# Check if the instance uses IMDSv1
match = Reservations.Instances.MetadataOptions.HttpTokens == "optional"
