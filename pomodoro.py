#!/usr/bin/env python3

import time
import os
import sys
import argparse

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def display_timer(seconds, total_seconds, width=50):
    filled_width = int(width * seconds / total_seconds)
    bar = '█' * filled_width + '░' * (width - filled_width)
    percent = seconds / total_seconds * 100
    return f"[{bar}] {percent:.1f}%"

def format_time(seconds):
    minutes, secs = divmod(seconds, 60)
    return f"{minutes:02d}:{secs:02d}"

def get_digit_art(digit):
    digit_art = {
        '0': ['  ___  ', ' / _ \\ ', '| | | |', '| | | |', '| |_| |', ' \\___/ '],
        '1': ['  __   ', ' /_ |  ', '  | |  ', '  | |  ', '  | |  ', '  |_|  '],
        '2': [' ____  ', '|___ \\ ', '  __) |', ' / __/ ', '| |___ ', '|_____|'],
        '3': [' _____ ', '|___ / ', '  |_ \\ ', ' ___) |', '|____/ ', '       '],
        '4': [' _  _   ', '| || |  ', '| || |_ ', '|__   _|', '   | |  ', '   |_|  '],
        '5': [' ____  ', '| ___| ', '|___ \\ ', ' ___) |', '|____/ ', '       '],
        '6': ["  __   ", " / /_  ", "| '_ \\ ", "| (_) |", " \\___/ ", "       "],
        '7': [' ______ ', '|____  |', '    / / ', '   / /  ', '  / /   ', ' /_/    '],
        '8': ['  ___  ', ' ( _ ) ', ' / _ \\ ', '| (_) |', ' \\___/ ', '       '],
        '9': ['  ___  ', ' / _ \\ ', '| (_) |', ' \\__, |', '   / / ', '  /_/  '],
        ':': ['   ', '   ', ' _ ', '(_)', ' _ ', '(_)']
    }
    return digit_art.get(digit, [' ' * 7] * 6)

def display_large_time(time_str):
    lines = [''] * 6
    for char in time_str:
        char_lines = get_digit_art(char)
        for i in range(6):
            lines[i] += char_lines[i] + '  '
    return '\n'.join(lines)

def run_timer(duration, session_type):
    start_time = time.time()
    while True:
        elapsed_time = int(time.time() - start_time)
        remaining_time = duration - elapsed_time

        if remaining_time <= 0:
            break

        clear_screen()
        print(f"\n{session_type} Time Remaining:\n")
        print(display_large_time(format_time(remaining_time)))
        print("\n" + display_timer(elapsed_time, duration))
        
        clock_face = [
            "    ┌───────────┐    ",
            "    │  ●─────●  │    ",
            "    │ /       \\ │    ",
            "    │|    |    |│    ",
            "    │ \\       / │    ",
            "    │  ●─────●  │    ",
            "    └───────────┘    "
        ]
        
        hand_positions = ['│', '/', '─', '\\']
        hand = hand_positions[elapsed_time % 4]
        clock_face[3] = clock_face[3][:9] + hand + clock_face[3][10:]
        
        print("\n" + "\n".join(clock_face))
        
        sys.stdout.flush()
        time.sleep(1)

    clear_screen()
    print(f"\n{session_type} session completed!")
    input("Press Enter to continue...")

def pomodoro_timer(work_time, break_time):
    while True:
        run_timer(work_time * 60, "Work")
        run_timer(break_time * 60, "Break")

def parse_arguments():
    parser = argparse.ArgumentParser(description="Pomodoro Timer CLI")
    parser.add_argument("-w", "--work", type=int, default=25, help="Work time in minutes (default: 25)")
    parser.add_argument("-b", "--break_time", type=int, default=5, help="Break time in minutes (default: 5)")
    return parser.parse_args()

def main():
    args = parse_arguments()
    print(f"Starting Pomodoro Timer with {args.work} minutes work and {args.break_time} minutes break.")
    input("Press Enter to begin...")
    try:
        pomodoro_timer(args.work, args.break_time)
    except KeyboardInterrupt:
        print("\nPomodoro timer stopped.")

if __name__ == "__main__":
    main()
