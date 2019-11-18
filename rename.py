import glob, os

for filename in glob.glob("*.H"):
    target = filename
    target = filename.replace("H", "h")
    os.rename(filename, target)
    	
