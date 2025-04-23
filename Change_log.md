-----------------------------------------------------------------------------------------------------------------------------

### 【Change Log】

-----------------------------------------------------------------------------------------------------------------------------

【v1.1】 Initial release, view existing inbound firewall rules including Docker port rules and forwarding rules. (2024.08.16 PM)

-----------------------------------------------------------------------------------------------------------------------------

【v1.2】 Second release, added SSH management for firewall, update menu, update log, integrated ipset addresses, and removed host rules. (2024.08.16 Night)

-----------------------------------------------------------------------------------------------------------------------------

【v1.3】 Third release, adjusted details, optimized color scheme, enhanced readability, highlighted key information, session screen management, and fixed issue where selecting N/n still triggered an update. (2024.08.17 PM)

-----------------------------------------------------------------------------------------------------------------------------

【v1.4】 Fourth release, fixed issue preventing script updates, reminded to delete update temporary files, improved aesthetics, and added author’s website display. (2024.08.17 Night)

-----------------------------------------------------------------------------------------------------------------------------

【v1.5】 Fifth Edition, Added language switching feature to the script, supporting switching between Chinese and English, with improvements to the script’s appearance. (2024.08.20 Night)

-----------------------------------------------------------------------------------------------------------------------------

【v1.6】 Sixth Edition, Managed Docker firewall rules.Managed Docker services that support only IPv4 access and those that support both IPv4 and IPv6 access.For services supporting both, the script requires enabling Docker custom networks and configuring IPv6 forwarding and access. The script does not force users to complete these configurations in a specific way, but currently, using the Docker project robbertkl/ipv6nat to achieve IPv6 forwarding and access in Docker networks is a recommended approach, though other methods can also be used.The Docker service firewall management function in this script was the original purpose of creating the script and is considered by the author to be a crucial part of automating Docker maintenance strategies.Two very important tasks: restricting external access to Docker services and enabling IPv6 access for Docker services. (2024.08.21 Noon)

-----------------------------------------------------------------------------------------------------------------------------

【v1.7】 Seventh Edition, Fixed logical errors in Docker firewall management options.Added a prompt to ask whether to create a configuration file.Added a submenu for common system commands.Added an option to the main menu for displaying Docker container information, which includes container name, network name, IPv4 address, IPv6 address, container status, and port mapping information.Improved the readability and aesthetic presentation of Docker container information display. (2024.08.22 Night)

-----------------------------------------------------------------------------------------------------------------------------

【v1.8】 Eighth Edition, Changed the container status in Docker container information display to white, in order to avoid visual confusion with container names when the code automatically wraps on mobile clients.Modified the script so that when Docker container information is not retrieved, it displays the character "N/A" to represent missing information,preventing potential misalignment of information columns. (2024.08.23 PM)

-----------------------------------------------------------------------------------------------------------------------------

【v1.9】 Ninth Version, This version fixes the issue where the script did not check if ipset was already installed before creating Docker firewall configuration files. It optimizes and changes the terminal interaction logic when managing SSH firewall rules and Docker firewall rules.When a user chooses not to create a configuration file, the script will first check if the configuration file already exists in the system. This approach introduces a validation logic to prevent mistakenly proceeding directly to the file creation step, which may not be the best user experience. Similarly, when the user chooses to modify an existing configuration file, the script will also first check if the corresponding configuration file already exists in the system, applying the same validation logic.In previous versions, the script only checked if the configuration file existed right before actually creating it. Now, this check has been moved up to the interaction inquiry phase. This change ensures that before any configuration file is created, the system confirms the absence of the corresponding configuration file, avoiding any blind file creation. All actions are carried out under a transparent logical environment for the script's sensitive operations. The previous detection step is now converted into corresponding prompt messages.(2024.08.25 Night)

-----------------------------------------------------------------------------------------------------------------------------

【v2.0】 Tenth Edition, In the latest version of Debian, it is no longer possible to view detailed port NAT forwarding information through POSTROUTING when checking iptables IPv4 Docker NAT rules and ip6tables IPv6 Docker NAT rules. This version adds DOCKER details to display the forwarding information. (2025.04.17 Noon)

-----------------------------------------------------------------------------------------------------------------------------

【v2.1】 Eleventh Edition, In the new version, both the Nezha monitoring server and the monitored client share the same port. This script updates the method for matching IP address firewall rules while retaining compatibility with both the new and old port matching methods. (2025.04.18 PM)

-----------------------------------------------------------------------------------------------------------------------------

【v2.2】 Twelfth Edition, Corrected the error in the script for creating new SSH firewall rules. The original script did not define a drop rule, which constitutes a critical functional flaw. Defining only allow rules without a corresponding drop rule renders the configuration meaningless. (2025.04.21 PM)

-----------------------------------------------------------------------------------------------------------------------------
【v2.3】 Thirteenth Edition, remove the code that displays the IP address set after initially creating the SSH rule, as it cannot be displayed and is therefore invalid code. (2025.04.23 PM)

-----------------------------------------------------------------------------------------------------------------------------
