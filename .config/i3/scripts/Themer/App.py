from os import environ
import subprocess
import Colors

def all_colors():
    result = '\n'.join(str(name)for name in Colors.names)
    return result

def get_path(path):
    if(path == "polybar"):
        try:
            environ['XDG_CONFIG_HOME']
        except KeyError:
            path = f'{environ['HOME'] + "/.config/polybar/colors.ini"}'
        else:
            path = environ['XDG_CONFIG_HOME'] + "/polybar/colors.ini"
        return path
    if(path == "i3"):
        try:
            environ['XDG_CONFIG_HOME']
        except KeyError:
            path = f'{environ['HOME'] + "/.config/i3/color"}'
        else:
            path = environ['XDG_CONFIG_HOME'] + "/i3/color"
        return path
    if(path == "starship"):
        try:
            environ['XDG_CONFIG_HOME']
        except KeyError:
            path = f'{environ['HOME'] + "/.config/starship.toml"}'
        else:
            path = environ['XDG_CONFIG_HOME'] + "/starship.toml"
        return path

def new_color():
    print("new")
    quit()

def remove_color():
    print("remove")
    quit()

def get_input():
    cmd = f'echo "{all_colors()}\nNew_Color\nRemove_Color" | dmenu -i -p "Select Theme:"'
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    out, err = p.communicate()
    out = out.decode().strip()
    if (out == "New_Color"):
        new_color()
    elif (out == "Remove_Color"):
        remove_color()
    else:
        index = [i for i, val in enumerate(Colors.names) if val == out]
        index = index[0]
        return index

def write(index ,path, primary, secondary):
    primary_index = 0
    secondary_index = 0
    with open(f'{get_path(path)}', "r") as file:
        line = file.readlines()
        for row in line:
            if row.find(primary) != -1:
                primary_index = line.index(row)
            if row.find(secondary) != -1:
                secondary_index = line.index(row)
    if (path == "polybar"):
        line[primary_index] = f'foreground = #{Colors.primary[index]}\n'
        line[secondary_index] = f'primary = #{Colors.secondary[index]}\n'
    if (path == "i3"):
        line[primary_index] = f'set $maincolor #{Colors.primary[index]}\n'
        line[secondary_index] = f'set $secondarycolor #{Colors.secondary[index]}\n'
    if (path == "starship"):
        line[primary_index] = f'primary = "#{Colors.primary[index]}"\n'
        line[secondary_index] = f'secondary = "#{Colors.secondary[index]}"\n'

    with open(f'{get_path(path)}', "w") as file:
        file.writelines(line)  

def main():
    index = get_input()
    write(index, "polybar", "foreground", "primary")
    write(index,"i3", "set $maincolor", "set $secondarycolor")
    subprocess.run(["i3-msg", "reload"])
    write(index,"starship", "primary =", "secondary =")

 
if __name__ == "__main__":
    main()
