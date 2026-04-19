# Get Configuration File

*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*

1. Go to Your **Router WEB-UI Page** (`http://192.168.29.1`) and Sign in as **Admin**. (The default credentials are **`admin : Jiocentrum`**)
2. A. Go to **Administrator** --> **Maintenance** and click **Backup**.

   B. For Newer firmwares, Go to **Administrator** --> **Maintenance** and inspect element the page. Find the `tf1_frmBackupSaveCurrentSettings` block and delete the trailing `<!--` and `--!>` at the end. The backup button should be visible now.
4. A file (`RSTXXXXXXX_JCXXXXX.enc`) will be downloaded with **`.enc`** extension.
5. Follow [this guide](https://github.com/Naitik1208/JF-ROUTER/blob/main/Instructions/Decrypt%20Config%20File.md) to Decrypt your config file.
