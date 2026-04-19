# Encrypt Configuration File

*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*

1. Open Terminal or Command Prompt.
2. Use this command to re-encrypt the text configuration file :- 
`openssl aes-128-cbc -pass pass:sample_pass -in "RSTXXXXXXX_JCXXXXX.txt" -out "RSTXXXXXXX_JCXXXXX_MODIFIED.enc"`

   Replace `sample_pass` with the last key the `keyguesser.py` tried.

4. In your Router WEB-UI Page (`http://192.168.29.1`), go to `Administrator --> Maintenance`.

   For newer firmwares, inspect the page, find the `tf1_frmBackupSaveCurrentSettings` block, uncomment it, edit `<input type="hidden" name="thispage" id="thispage" value="backupRestore.html">` change `backupRestore.html` to `factoryDefault.html`.
6. Select and restore the `RSTXXXXXXX_JCXXXXX_MODIFIED.enc` file that was generated at step 7.
7. If by any chance your router configuration file had incorrect settings, it might reset the whole configuration or also might brick the router. If your router is bricked, a hard reset might fix it. Just push the button (inside a hole) behind the router for about 30 seconds. And after it boots up, restore the original configuration file that you downloaded directly from the Router WEB-UI to get back your original settings.
