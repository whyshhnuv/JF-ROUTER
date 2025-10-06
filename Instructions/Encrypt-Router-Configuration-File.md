# Encrypt Configuration File (Do not use this anymore)

*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*
1. Open Terminal or Command Prompt.
2. Use this command to re-encrypt the text configuration file with your respective `server.key` :- 
`openssl aes-128-cbc -kfile "<path to the key file>" -in "RSTXXXXXXX_JCXXXXX.txt" -out "RSTXXXXXXX_JCXXXXX_MODIFIED.enc"`
3. In your Router WEB-UI Page (`http://192.168.29.1`), go to `Administrator --> Maintenance`.
4. Select and restore the `RSTXXXXXXX_JCXXXXX_MODIFIED.enc` file that was generated at step 7.
5. If by any chance your router configuration file had incorrect settings, it might reset the whole configuration or also might brick the router. If your router is bricked, a hard reset might fix it. Just push the button (inside a hole) behind the router for about 30 seconds. And after it boots up, restore the original configuration file that you downloaded directly from the Router WEB-UI to get back your original settings.
