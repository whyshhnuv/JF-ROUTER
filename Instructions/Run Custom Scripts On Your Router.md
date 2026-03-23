# RUN CUSTOM SCRIPTS ON JIO ROUTER

This guide is only for educational purposes, I am not responsible for bricked routers, Try at your own risk. 

**Keep in mind you are changing commands in root partition, so don't try to experiment without knowing what you are doing as it may brick your router.**

Successfully Tested on JF JCOW404 and JCOW411 ONT. 

1.Create your script using telnet and store in a directory.

2.Go to `/etc/init.d`

3.Find `rcS` file, edit it. 

4.At the end of this file file add a line
`/path to script/script.sh &`
path to script - where u stored script
or you can store scripts in directory and use a loop like I did

You may use the path `/scripts`

To do so use commands
`mkdir /scripts`

Create any script in this directory using command 
`vi /scripts/scriptname.sh`

**LOOP TO RUN SCRIPTS IN A DIRECTORY**

```none
for i in /scripts/*.sh; do
if [ -x "$i" ]; then # Check if the file exists and is executable
echo "Executing custom script: $i"
"$i" & # Run in the background (optional, depends on your needs) 
# Or run in the foreground: 
# "$i"
fi
done
```

Here I have used /scripts as path to scripts you may use any path as per your convenience. 






