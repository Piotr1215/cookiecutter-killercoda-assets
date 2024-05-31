import os
import shutil
from pathlib import Path, PurePath
from tempfile import TemporaryDirectory


def _move_single_file(src_dir: PurePath, dst_dir: PurePath, file_name: str):
    shutil.move(
        str(src_dir.joinpath(file_name)),
        dst_dir.joinpath(file_name),
        copy_function=lambda x, y: shutil.copytree(
            x, y, dirs_exist_ok=True, copy_function=shutil.copy2
        ),
    )


def move_directory_contents(src: PurePath, dst: PurePath):
    temp_dir = TemporaryDirectory()
    temp_dir_path = Path(temp_dir.name)

    directory_contents = os.listdir(src)
    for item in directory_contents:
        print(f"Moving {item} to {temp_dir_path}")
        _move_single_file(src, temp_dir_path, item)

    directory_contents.remove(src.name)

    for item in directory_contents:
        print(f"Moving {item} to {dst}")
        _move_single_file(temp_dir_path, dst, item)

    os.removedirs(src)

    _move_single_file(temp_dir_path, dst, src.name)


if __name__ == "__main__":
    if "{{ cookiecutter.use_current_directory }}".lower() == "y":
        src = Path.cwd()
        assert src.name == "{{ cookiecutter.project_slug }}"
        move_directory_contents(src, src.parent)
