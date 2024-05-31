import os
import shutil

def move_files(src, dst):
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, dirs_exist_ok=True)
        else:
            shutil.copy2(s, d)
    shutil.rmtree(src)

if __name__ == "__main__":
    # Assuming this script runs in the generated project directory
    current_directory = os.getcwd()
    src_directory = os.path.join(current_directory, 'killercoda-assets')
    move_files(src_directory, current_directory)
