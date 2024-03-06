{ pkgs }:

pkgs.writers.writePython3Bin "bg-kill" {} ''
import subprocess


def get_pid_by_class(class_name):
    try:
        # Run hyprctl clients and capture the output
        result = subprocess.run(
            ['hyprctl', 'clients'],
            capture_output=True,
            text=True
        )
        # Check if the command was successful
        if result.returncode != 0:
            raise Exception(f"Error running hyprctl clients: {result.stderr}")
        class_index = result.stdout.find(f'class: {class_name}')
        if class_index != -1:
            pid_index = result.stdout.find('pid: ', class_index)
            if pid_index != -1:
                pid_start = pid_index + 5
                pid_end = result.stdout.find('\n', pid_start)
                pid = int(result.stdout[pid_start:pid_end])
                return pid
            else:
                raise Exception(f"No PID found for class name: {class_name}")
        else:
            raise Exception(f"No window found with class name: {class_name}")
    except Exception as e:
        print(f"Error: {e}")


# Example usage
class_name = 'alacritty-bg'
pid = get_pid_by_class(class_name)
print(pid)
''
