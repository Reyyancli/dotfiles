#!/usr/bin/env python3

import json
import os, os.path
import socket
import subprocess
import sys

def construct_output_dict(window_title: str):
    if window_title == '':
        return { 'class': 'custom-hyprland-window#empty', 'text': window_title }
    else:
        return { 'class': 'custom-hyprland-window', 'text': window_title }

def print_json(dict: dict):
    sys.stdout.write(json.dumps(dict) + '\n')
    sys.stdout.flush()

def main():
    active_window_bytes = subprocess.check_output(['bash', '-c', 'hyprctl activewindow | grep -oP "title:\\K.*"'])
    active_window_str = active_window_bytes.decode('utf-8').strip()
    output = construct_output_dict(active_window_str)
    print_json(output)

    sock_path = os.path.join(os.environ['XDG_RUNTIME_DIR'], 'hypr', os.environ['HYPRLAND_INSTANCE_SIGNATURE'], '.socket2.sock')

    if not os.path.exists(sock_path):
      print('Socket file does not exist. Are you on Hyprland?')
      return

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(sock_path)

    data = b''
    while True:
        chunk = sock.recv(1024)
        if not chunk:
            # The socket has been closed
            break
        data += chunk
        while b'\n' in data:
            # Split the data at the first newline character
            idx = data.index(b'\n')
            line = data[:idx]
            data = data[idx+1:]

            # Process the line
            line = line.decode('utf-8')

            [event, *payload] = line.split('>>')
            payload = '>>'.join(payload)
            if event == 'activewindow':
                [_, *window_title] = payload.split(',')
                window_title = ','.join(window_title)
                window_title = window_title.replace("&", "&amp;")
                output = construct_output_dict(window_title)
                print_json(output)

    # Close the socket
    sock.close()


if __name__ == "__main__":
    main()
