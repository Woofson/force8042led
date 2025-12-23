# Force CapsLock LED

Forces the CapsLock LED on some Lenovo Laptops that uses an 8043 embedded controller.

gcc -O3 force_led.c -o force_led  
sudo mv force_led /usr/local/bin/kbd_led_force  
sudo chown root:root /usr/local/bin/kbd_led_force  
sudo chmod u+s /usr/local/bin/kbd_led_force  

