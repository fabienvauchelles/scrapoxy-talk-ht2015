## Step 3: Use a proxy of proxies

<img src="slides/02_bypass/03_proxy_of_proxies/proxy_of_proxies.png" />


note:

On veut repartir équitablement les requêtes sur plusieurs proxies.

On intègre un proxy supplémentaire, pour router les requêtes.

Le scrapeur envoie ses requêtes au router, qui les redirige équitablement sur les proxies.

C'est très facile à monter.


On crée un script pour le routage (100 lignes environs).

On crée une 10aine de proxy Squid sur des instances AWS EC2

On récupère les addresses IP et on les met dans la conf du script
