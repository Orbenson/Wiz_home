package sg

import input.IpPermissions
import input.IpPermissionsEgress

# A list of secure ports
secure_ports = [22, 53, 135, 443, 445, 563, 993]

# Check if the SG allows any insecure ports in the inbound rules
allow_insecure_inbound = false

# Check if the SG allows any insecure ports in the outbound rules
allow_insecure_outbound = false

# Iterate through the inbound rules
for i in IpPermissions {
  # Check if the protocol is not ICMP and the port is lower than 1024
  if i.IpProtocol != "icmp" and i.FromPort < 1024 {
    # If the port is not in the list of secure ports, set allow_insecure_inbound to true
    if i.FromPort not in secure_ports {
      allow_insecure_inbound = true
      break
    }
  }
}

# Iterate through the outbound rules
for i in IpPermissionsEgress {
  # Check if the protocol is not ICMP and the port is lower than 1024
  if i.IpProtocol != "icmp" and i.FromPort < 1024 {
    # If the port is not in the list of secure ports, set allow_insecure_outbound to true
    if i.FromPort not in secure_ports {
      allow_insecure_outbound = true
      break
    }
  }
}

# If the SG allows any insecure ports in the inbound or outbound rules, set match to true
match = allow_insecure_inbound or allow_insecure_outbound
