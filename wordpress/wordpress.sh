mkdir available-site/


curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C available-site/ \
    && rm /tmp/wordpress.tar.gz
 
