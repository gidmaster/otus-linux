#!/usr/bin/env python3
from datetime import timedelta
import os, os.path
import re

class Process:

    def __init__(self, pid):
        self.pid = pid
        self.pid_file_path = os.path.join('/proc', self.pid)
        self.stat_file_path = os.path.join(self.pid_file_path, 'stat')
        self.cmd_file_path = os.path.join(self.pid_file_path, 'cmdline')
        self.tty = self._get_tty()
        self.state = self._get_state()
        self.command = self._get_command()
        self.time = self._get_time()

    def _get_tty(self):
        with open(self.stat_file_path, 'r') as stat_file:
            stat = stat_file.read().split(" ")
            tty_nr = int(stat[6])

        major_dict = {
            4:  'tty',
            3:  'ttyp',
            2:  'ptyp',
            136:'pts/',
            137:'pts/',
            138:'pts/',
            139:'pts/',
            140:'pts/',
            141:'pts/',
            142:'pts/',
            143:'pts/',
            227:'3270tty'
        }
        if tty_nr == 0:
            return '?'
        b_tty_nr = f'{tty_nr:032b}'
        d_major = int(b_tty_nr[16:24], 2)
        if d_major not in major_dict.keys():
            return 'UNKWN'
        d_minor = int(b_tty_nr[0:16] + b_tty_nr[24:32], 2)
        tty = f'{major_dict[d_major]}{d_minor}'
        return tty

    def _get_state(self):
        with open(self.stat_file_path, 'r') as stat_file:
            stat = stat_file.read().split(" ")
            return stat[2]

    def _get_command(self):
        with open(self.cmd_file_path, 'rb') as cmd_file:
            command = cmd_file.read().decode('utf8')

        if not command:
            with open(self.stat_file_path, 'r') as stat_file:
                stat = stat_file.read().split(" ")
                command = stat[1]
        return command

    def _get_time(self):
        ticks = 0
        with open(self.stat_file_path, 'r') as stat_file:
            stat = stat_file.read().split(" ")
            ticks = int(stat[14]) + int(stat[15]) + int(stat[16]) + int(stat[17])
        times = timedelta(microseconds = ticks/10).total_seconds()
        return times
    

class Ps:

    def __init__(self):
        pass

    def _get_pids(self):
        files = []
        tree = next(os.walk('/proc'))[1]
        for i in tree:
            if re.match(r'\d+', i):
                files.append(i)
        return files

    def get_processes(self):
        pids = self._get_pids()
        # files_path = [os.path.join('/proc', pid) for pid in pids]
        processes = []
        for pid in pids:
            print(pid)
            processes.append(Process(pid))
        return processes

    def print_processes(self):
        processes = self.get_processes()
        print('PID   TTY   STAT    TIME   COMMAND')
        for process in processes:
            print(f'{process.pid:5} {process.tty:5} {process.state:2} {process.time:10} {process.command}')

ps = Ps()
print(ps.print_processes())